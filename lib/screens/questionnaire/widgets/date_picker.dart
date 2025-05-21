import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skyedge/providers/questionnaire_provider.dart';
import 'package:skyedge/theme/app_theme.dart';
import 'package:intl/intl.dart';

class CustomDatePicker extends StatelessWidget {
  final int questionId;

  const CustomDatePicker({
    Key? key,
    required this.questionId,
  }) : super(key: key);

  Future<void> _selectDate(
      BuildContext context, QuestionnaireProvider provider) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppTheme.primaryColorLight,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      final formattedDate = DateFormat('yyyy-MM-dd').format(picked);
      provider.addQuestionResponse(questionId, formattedDate, false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final questionnaireProv = Provider.of<QuestionnaireProvider>(context);
    String? selectedDate;

    try {
      selectedDate = questionnaireProv.questionResponse.firstWhere(
        (element) => element["question_id"] == questionId,
        orElse: () => {"question_id": questionId, "answer_text": null},
      )["answer_text"];
    } catch (e) {
      debugPrint("Error getting selected date: $e");
      selectedDate = null;
    }

    return GestureDetector(
      onTap: () => _selectDate(context, questionnaireProv),
      child: Container(
        height: 50,
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        width: double.infinity,
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: Colors.grey),
        ),
        child: Row(
          children: [
            Text(selectedDate ?? "Select Date"),
            Spacer(),
            Icon(Icons.calendar_month),
          ],
        ),
      ),
    );
  }
}
