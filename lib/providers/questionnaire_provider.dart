import 'package:flutter/material.dart';
import 'package:skyedge/models/registration_questions_model.dart';
import 'package:skyedge/repositories/questionnaire_repo.dart';

class QuestionnaireProvider extends ChangeNotifier {
  List<RegistrationQuestion> _questions = [];
  bool _isSubmitting = false;

  List<RegistrationQuestion> get questions => _questions;
  bool get isSubmitting => _isSubmitting;

  final QuestionnaireRepo _questionnaireRepo = QuestionnaireRepo();

  List questionResponse = [];

  Future<void> getRegisterationQuestions() async {
    notifyListeners();
    final response = await _questionnaireRepo.getRegisterationQuestions();
    if (response?.response?.data != null) {
      var data = response?.response?.data;
      if (data['questions'] != null) {
        _questions = (data['questions'] as List<dynamic>)
            .map(
                (e) => RegistrationQuestion.fromJson(e as Map<String, dynamic>))
            .toList();
        notifyListeners();
      }
    }
    debugPrint(
        "getRegisterationQuestions response: ${response?.response?.data}");
  }

  Future<bool> submitQuestionnaire() async {
    if (questionResponse.isEmpty) return false;

    try {
      _isSubmitting = true;
      notifyListeners();

      final response =
          await _questionnaireRepo.submitQuestionnaire(questionResponse);
      _isSubmitting = false;
      notifyListeners();

      return response?.response?.statusCode == 200;
    } catch (e) {
      _isSubmitting = false;
      notifyListeners();
      debugPrint("Error submitting questionnaire: $e");
      return false;
    }
  }

  void addQuestionResponse(
      int questionId, dynamic response, bool isMultipleSelect) {
    debugPrint(
        "addQuestionResponse: $questionId, $response, $isMultipleSelect");
    final existingIndex = questionResponse
        .indexWhere((element) => element["question_id"] == questionId);

    if (existingIndex != -1) {
      questionResponse[existingIndex]["answer_text"] = response;
    } else {
      questionResponse
          .add({"question_id": questionId, "answer_text": response});
    }
    notifyListeners();
  }

  bool isOptionSelected(int questionId, String option) {
    final response = questionResponse.firstWhere(
      (element) => element["question_id"] == questionId,
      orElse: () => {"question_id": questionId, "answer_text": null},
    );

    if (response["answer_text"] == null) return false;

    // Handle both single string and list of strings
    if (response["answer_text"] is List) {
      return (response["answer_text"] as List).contains(option);
    } else {
      return response["answer_text"] == option;
    }
  }
}
