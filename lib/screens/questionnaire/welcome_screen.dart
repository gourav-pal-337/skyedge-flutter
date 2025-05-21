import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:skyedge/constants/app_assets.dart';
import 'package:skyedge/constants/app_routes.dart';
import 'package:skyedge/constants/app_textstyle.dart';
import 'package:skyedge/providers/auth_provider.dart';
import 'package:skyedge/providers/questionnaire_provider.dart';
import 'package:skyedge/screens/questionnaire/widgets/aninmated_ball.dart';
import 'package:skyedge/theme/app_theme.dart';
import 'package:skyedge/utils/extensions/build_context_extensions.dart';
import 'package:skyedge/utils/extensions/int_extentions.dart';
import 'package:skyedge/widgets/show_image.dart';
import 'package:skyedge/widgets/submit_button.dart';

class QuestionnaireWelcomeScreen extends StatefulWidget {
  const QuestionnaireWelcomeScreen({super.key});

  @override
  State<QuestionnaireWelcomeScreen> createState() =>
      _QuestionnaireWelcomeScreenState();
}

class _QuestionnaireWelcomeScreenState
    extends State<QuestionnaireWelcomeScreen> {
  final List<String> _messages = [
    "Hey there!  I’m Skyecc, your AI guide, Let’s get to know each other a bit. You’ll earn Skyedge tokens as we chat! ",
    "Think of them as 'YOU’RE KILLING IT' tokens – the more you do, the more you earn! "
  ];

  int _welcomeScreenIndex = 0;

  void getQuestions() {
    final questionnaireProv =
        Provider.of<QuestionnaireProvider>(context, listen: false);
    questionnaireProv.getRegisterationQuestions();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getQuestions();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final questionnaireProv = Provider.of<QuestionnaireProvider>(context);
    debugPrint("authProvider: ${authProvider.userModel.fullname}");
    final message = _messages[_welcomeScreenIndex];
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                      const EdgeInsets.all(0),
                    ),
                  ),
                  onPressed: () {
                    // context.go(AppRoutes.registrationScreen);
                  },
                  child: Text(
                    'Skip',
                    style: AppTextStyle.body16Regular.copyWith(
                      color: AppTheme.greyText,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              10.verticalSpace,
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: RichText(
                  text: TextSpan(
                    style: AppTextStyle.title24MediumClash,
                    children: message.split(' ').map((value) {
                      if (value == "Skyecc," ||
                          value == "'YOU’RE" ||
                          value == "KILLING" ||
                          value == "IT'") {
                        return WidgetSpan(
                          child: GradientText(
                            " $value",
                            style: AppTextStyle.title24MediumClash,
                            gradientDirection: GradientDirection.ttb,
                            colors: const [
                              AppTheme.blue,
                              AppTheme.primaryColorDark,
                            ],
                          ),
                        );
                      }
                      return WidgetSpan(
                        child: GradientText(
                          " $value",
                          style: AppTextStyle.title24MediumClash,
                          gradientDirection: GradientDirection.ttb,
                          colors: [
                            AppTheme.blacktextColor(context),
                            AppTheme.blacktextColor(context)
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: _welcomeScreenIndex == 1
                      ? SizedBox(
                          width: context.mediaQuery.size.width * 0.5,
                          child: const ShowImage(imagelink: AppAssets.coinBox))
                      : AnimatedBall(),
                ),
              ),
              if (questionnaireProv.questions.isNotEmpty)
                SubmitButton(
                  onTap: () {
                    // validate();
                    if (_welcomeScreenIndex < 1) {
                      _welcomeScreenIndex++;
                    } else {
                      context.push(AppRoutes.questionnaireScreen);
                    }
                    setState(() {});
                  },
                  isAtBottom: true,
                  label: _welcomeScreenIndex == 1 ? "Next" : "Let's go",
                ),
            ],
          ),
        ),
      ),
    );
  }
}
