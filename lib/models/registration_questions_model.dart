class RegistrationQuestion {
  final int? id;
  final String? questionText;
  final String? type;
  final List<String>? options;

  RegistrationQuestion({
    this.id,
    this.questionText,
    this.type,
    this.options,
  });

  factory RegistrationQuestion.fromJson(Map<String, dynamic> json) {
    return RegistrationQuestion(
      id: json['id'] as int?,
      questionText: json['question_text'] as String?,
      type: json['type'] as String?,
      options:
          (json['options'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question_text': questionText,
      'type': type,
      'options': options,
    };
  }
}
