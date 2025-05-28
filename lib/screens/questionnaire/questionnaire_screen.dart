import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:skyedge/constants/app_assets.dart';
import 'package:skyedge/constants/app_routes.dart';
import 'package:skyedge/constants/app_textstyle.dart';
import 'package:skyedge/providers/questionnaire_provider.dart';
import 'package:skyedge/providers/socket_provider.dart';
import 'package:skyedge/screens/questionnaire/widgets/country_picker.dart';
import 'package:skyedge/screens/questionnaire/widgets/date_picker.dart';
import 'package:skyedge/screens/questionnaire/widgets/life_style_chat.dart';
import 'package:skyedge/screens/questionnaire/widgets/timeline_progress.dart';
import 'package:skyedge/theme/app_theme.dart';
import 'package:skyedge/utils/extensions/build_context_extensions.dart';
import 'package:skyedge/utils/extensions/int_extentions.dart';
import 'package:skyedge/utils/extensions/string_extensions.dart';
import 'package:skyedge/widgets/custom_popup.dart';
import 'package:skyedge/widgets/my_appbar.dart';
import 'package:skyedge/widgets/show_image.dart';
import 'package:skyedge/widgets/submit_button.dart';
import 'package:timelines_plus/timelines_plus.dart';

class QuestionnaireScreen extends StatefulWidget {
  const QuestionnaireScreen({super.key});

  @override
  State<QuestionnaireScreen> createState() => _QuestionnaireScreenState();
}

class _QuestionnaireScreenState extends State<QuestionnaireScreen> {
  PageController _pageController = PageController();

  int currentPage = 0;
  double fraction = 0.0;
  String selectedOption = '';

  getCurrentStep() {
    var value = Provider.of<QuestionnaireProvider>(context, listen: false);
    final socketProv = Provider.of<SocketProvider>(context, listen: false);
    if (value.userAnswers.isEmpty) {
      socketProv.updateLevet(0);
    } else {
      socketProv.updateLevet(1);
    }
    setState(() {});
  }

  bool isQuestionAnswered(int questionId, QuestionnaireProvider provider) {
    try {
      final response = provider.questionResponse.firstWhere(
        (element) => element["question_id"] == questionId,
        orElse: () => {"question_id": questionId, "answer_text": null},
      );
      return response["answer_text"] != null;
    } catch (e) {
      return false;
    }
  }

  void validateAndProceed(BuildContext context) async {
    final questionnaireProv =
        Provider.of<QuestionnaireProvider>(context, listen: false);
    final socketProv = Provider.of<SocketProvider>(context, listen: false);

    final currentQuestion = questionnaireProv.questions[currentPage];

    if (!isQuestionAnswered(currentQuestion.id!, questionnaireProv)) {
      "Please select an option to continue".toast();
      return;
    }

    if (currentPage == questionnaireProv.questions.length - 1) {
      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
          child: CircularProgressIndicator(),
        ),
      );

      // Submit questionnaire
      final success = await questionnaireProv.submitQuestionnaire();

      // Hide loading indicator
      Navigator.pop(context);

      if (success) {
        // Show success message and navigate
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Questionnaire submitted successfully!"),
            backgroundColor: Colors.green,
          ),
        );
        var value = await context.push(AppRoutes.questionnaireCompletionScreen);
        if (value == true) {
          socketProv.updateLevet(1);

          currentPage = 0;
          fraction = 0;
          setState(() {});
        }
        // Reset and go to first page
        // currentPage = 0;
        // fraction = 0;
        // setState(() {});
        // _pageController.jumpToPage(currentPage);
      } else {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Failed to submit questionnaire. Please try again."),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      _pageController.animateToPage(currentPage + 1,
          duration: const Duration(milliseconds: 500), curve: Curves.linear);
      currentPage++;
      fraction = (currentPage) / questionnaireProv.questions.length;
      setState(() {});
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getCurrentStep();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final socketProv = Provider.of<SocketProvider>(context);

    final questionnaireProv = Provider.of<QuestionnaireProvider>(context);
    var questionnaireData = questionnaireProv.questions;
    debugPrint(fraction.toString());
    return Scaffold(
      appBar: MyAppBar(
        title: "",
        onBackPressed: () {
          if (socketProv.levelNumber != 0) {
            context.read<SocketProvider>().disconnectSocket();
          }
          context.pop();
        },
      ),
      body: SafeArea(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TimelineProgress(
              steps: [
                "Demographics",
                "Lifestyle",
                'Hobbies & Habits',
                "Social World",
                "Education",
                "Job"
              ],
              currentStep: socketProv.levelNumber,
              fraction: fraction,
            ),
            if (socketProv.levelNumber == 0)
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  // physics: NeverScrollableScrollPhysics(), // Disable swipe
                  itemCount: questionnaireData.length,
                  itemBuilder: (context, index) {
                    var item = questionnaireData[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: AppTheme.grey?.withOpacity(0.2),
                                border: Border.all(
                                    color: AppTheme.blacktextColor(context)),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: ShowImage(
                                      imagelink: AppAssets.skyCoin,
                                    ),
                                  ),
                                  5.horizontalSpace,
                                  Text(
                                    "2 points",
                                    style: AppTextStyle.caption12Regular
                                        .copyWith(color: AppTheme.blue),
                                  )
                                ],
                              ),
                            ),
                          ),
                          15.verticalSpace,
                          Text(
                            "${item.questionText}",
                            style: AppTextStyle.title24MediumClash,
                          ),
                          // if (item['questionDec'] != null) ...[
                          //   20.verticalSpace,
                          //   Text(
                          //     "${item['questionDec']}",
                          //     style: AppTextStyle.subtitle18SemiBold,
                          //   ),
                          // ],
                          // if (item['questionDec2'] != null) ...[
                          //   Text(
                          //     "${item['questionDec2']}",
                          //     style: AppTextStyle.caption12Regular
                          //         .copyWith(color: AppTheme.greyText),
                          //   ),
                          // ],
                          20.verticalSpace,
                          if (item.type == "date")
                            CustomDatePicker(questionId: item.id!),
                          if (item.options == null &&
                              (item.questionText
                                      ?.toLowerCase()
                                      .contains("country") ??
                                  false))
                            CountryPicker(questionId: item.id!),
                          if (item.options != null)
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: (item.options as List).map((value) {
                                    var isSelected = questionnaireProv
                                        .isOptionSelected(item.id!, value);
                                    return GestureDetector(
                                      onTap: () {
                                        if (item.id == null) return;

                                        if (item.type == "multiple") {
                                          // For multiple selection, toggle the option
                                          List<String> currentSelections = [];
                                          if (questionnaireProv
                                              .isOptionSelected(item.id!, "")) {
                                            currentSelections = List<
                                                    String>.from(
                                                questionnaireProv
                                                    .questionResponse
                                                    .firstWhere((element) =>
                                                        element[
                                                            "question_id"] ==
                                                        item.id)["answer_text"]);
                                          }

                                          if (isSelected) {
                                            currentSelections.remove(value);
                                          } else {
                                            currentSelections.add(value);
                                          }

                                          questionnaireProv.addQuestionResponse(
                                              item.id!,
                                              currentSelections,
                                              true);
                                        } else {
                                          // For single selection
                                          questionnaireProv.addQuestionResponse(
                                              item.id!, value, false);
                                        }
                                      },
                                      child: Container(
                                        height: 42,
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        width: double.infinity,
                                        alignment: Alignment.centerLeft,
                                        decoration: BoxDecoration(
                                          color: isSelected
                                              ? AppTheme.primaryColorLight
                                                  .withOpacity(0.2)
                                              : Colors.transparent,
                                          border: Border.all(
                                              color: isSelected
                                                  ? AppTheme.primaryColorLight
                                                  : Colors.grey),
                                        ),
                                        child: Row(
                                          children: [
                                            if (item.type == "multiple")
                                              Icon(
                                                isSelected
                                                    ? Icons.check_box
                                                    : Icons
                                                        .check_box_outline_blank,
                                                color: isSelected
                                                    ? AppTheme.primaryColorLight
                                                    : Colors.grey,
                                              )
                                            else
                                              Icon(
                                                isSelected
                                                    ? Icons.radio_button_checked
                                                    : Icons
                                                        .radio_button_unchecked,
                                                color: isSelected
                                                    ? AppTheme.primaryColorLight
                                                    : Colors.grey,
                                              ),
                                            10.horizontalSpace,
                                            Text("$value"),
                                          ],
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            )
                        ],
                      ),
                    );
                  },
                ),
              ),
            if (socketProv.levelNumber != 0)
              LifeStyleChat(
                  key: Key('LifeStyleChat-${socketProv.levelNumber}'),
                  levelNumber: socketProv.levelNumber)
          ],
        ),
      ),
      bottomNavigationBar: socketProv.levelNumber != 0
          ? null
          : Row(
              children: [
                Expanded(
                  child: SubmitButton(
                    onTap: () {
                      validateAndProceed(context);
                    },
                    labelsize: 13,
                    isAtBottom: true,
                    color: Colors.transparent,
                    labelColor: AppTheme.blacktextColor(context),
                    label: "Skip",
                  ),
                ),
                Expanded(
                  child: SubmitButton(
                    onTap: () {
                      validateAndProceed(context);
                    },
                    labelsize: 13,
                    isAtBottom: true,
                    label: "Next",
                  ),
                ),
              ],
            ),
    );
  }
}

// List<Map> questionnaireData = [
//   {
//     "category": "Demographics",
//     "questions": [
//       {
//         "question": "What pronouns should I use for you?",
//         "options": [
//           {"label": "He/Him", "value": "He/Him", "type": "string"},
//           {"label": "She/Her", "value": "She/Her", "type": "string"},
//           {"label": "They/Them", "value": "They/Them", "type": "string"},
//           {"label": "Other", "value": "Other", "type": "string"},
//         ],
//         "type": "Single",
//         "token": 2,
//         "required": true,
//         "value": ""
//       },
//       {
//         "question": "When's your birthday?",
//         "options": [
//           {"label": "Date", "value": "dob", "type": "Date"},
//         ],
//         "type": "Date",
//         "token": 3,
//         "required": true,
//         "value": ""
//       },
//       {
//         "question": "Where are you from?",
//         "options": [
//           {"label": "City", "value": "City", "type": "Dropdown"},
//           {"label": "State", "value": "State", "type": "Dropdown"}
//         ],
//         "type": "Dropdown",
//         "token": 4,
//         "required": true,
//         "value": ""
//       },
//       {
//         "question": "Are you currently…?",
//         "options": [
//           {"label": "Employed", "value": "Employed", "type": "string"},
//           {"label": "Unemployed", "value": "Unemployed", "type": "string"},
//           {"label": "Student", "value": "Student", "type": "string"},
//           {"label": "Retired", "value": "Retired", "type": "string"}
//         ],
//         "type": "Single",
//         "token": 5,
//         "required": true,
//         "value": ""
//       },
//     ]
//   },
//   {
//     "category": "LifeStyle",
//     "questions": [
//       {
//         "question": "Are you a morning person?",
//         "options": [
//           {"label": "Yes", "value": "Yes", "type": "string"},
//           {"label": "No", "value": "No", "type": "string"},
//         ],
//         "type": "Single",
//         "token": 6,
//         "required": true,
//         "value": ""
//       },
//       {
//         "question": "How often do you exercise?",
//         "options": [
//           {"label": "Daily", "value": "Daily", "type": "string"},
//           {"label": "Weekly", "value": "Weekly", "type": "string"},
//           {"label": "Monthly", "value": "Monthly", "type": "string"},
//           {"label": "Rarely", "value": "Rarely", "type": "string"}
//         ],
//         "type": "Single",
//         "token": 7,
//         "required": true,
//         "value": ""
//       },
//     ]
//   },
//   {
//     "category": "Hobbies & Habits",
//     "questions": [
//       {
//         "question": "What do you enjoy doing in your free time?",
//         "options": [
//           {"label": "Reading", "value": "Reading", "type": "string"},
//           {
//             "label": "Listening to music",
//             "value": "Listening to music",
//             "type": "string"
//           },
//           {"label": "Hiking", "value": "Hiking", "type": "string"},
//           {"label": "Other", "value": "Other", "type": "string"}
//         ],
//         "type": "Multi",
//         "token": 8,
//         "required": true,
//         "value": []
//       },
//       {
//         "question": "What is your favorite hobby?",
//         "options": [
//           {"label": "Photography", "value": "Photography", "type": "string"},
//           {"label": "Cooking", "value": "Cooking", "type": "string"},
//           {"label": "Painting", "value": "Painting", "type": "string"},
//           {"label": "Other", "value": "Other", "type": "string"}
//         ],
//         "type": "Single",
//         "token": 9,
//         "required": true,
//         "value": ""
//       },
//     ]
//   },
//   {
//     "category": "Social World",
//     "questions": [
//       {
//         "question":
//             "Let's connect your social life  — this is where the magic happens!",
//         "questionDec": "Which of these do you use regularly?",
//         "questionDec2": "(You can select multiple)",
//         "options": [
//           {
//             "label": "Facebook",
//             "value": "Facebook",
//             "icon":
//                 "https://upload.wikimedia.org/wikipedia/commons/6/6c/Facebook_Logo_2023.png",
//             "type": "string",
//           },
//           {
//             "label": "Instagram",
//             "value": "Instagram",
//             "type": "string",
//             "icon":
//                 "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a5/Instagram_icon.png/1024px-Instagram_icon.png",
//           },
//           {
//             "label": "Whatsapp",
//             "value": "Whatsapp",
//             "type": "string",
//             "icon":
//                 "https://upload.wikimedia.org/wikipedia/commons/5/5e/WhatsApp_icon.png",
//           },
//           {
//             "label": "LinkedIn",
//             "value": "LinkedIn",
//             "type": "string",
//             "icon":
//                 "https://static.vecteezy.com/system/resources/previews/018/930/587/non_2x/linkedin-logo-linkedin-icon-transparent-free-png.png",
//           }
//         ],
//         "type": "Single",
//         "token": 10,
//         "required": true,
//         "value": ""
//       },
//     ]
//   },
// ];
