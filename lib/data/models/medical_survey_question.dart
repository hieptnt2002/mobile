enum QuestionType {
  checkbox,
  radio,
  input,
}

class AnswerOption {
  final String? answerText;
  final String? nextQuestionId;

  AnswerOption({
    this.answerText,
    this.nextQuestionId,
  });

  factory AnswerOption.fromJson(Map<String, dynamic> json) {
    return AnswerOption(
      answerText: json['answerText'] as String?,
      nextQuestionId: json['nextQuestionId'] as String?,
    );
  }
}

class QuestionContent {
  final String content;
  final bool isEmphasized;

  QuestionContent({required this.content, required this.isEmphasized});
  factory QuestionContent.fromJson(Map<String, dynamic> json) {
    return QuestionContent(
      content: json['content'] as String,
      isEmphasized: json['isEmphasized'] as bool,
    );
  }
}

class MedicalSurveyQuestion {
  final String id;
  final List<QuestionContent> questionContents;
  final QuestionType questionType;
  final List<AnswerOption> answers;

  const MedicalSurveyQuestion({
    required this.id,
    required this.questionContents,
    required this.questionType,
    required this.answers,
  });

  factory MedicalSurveyQuestion.fromJson(Map<String, dynamic> json) {
    return MedicalSurveyQuestion(
      id: json['id'] as String,
      questionContents: (json['questionContents'] as List)
          .map((contentJson) => QuestionContent.fromJson(contentJson))
          .toList(),
      questionType: QuestionType.values.byName(json['questionType'] as String),
      answers: (json['answers'] as List)
          .map((answerJson) => AnswerOption.fromJson(answerJson))
          .toList(),
    );
  }
  MedicalSurveyQuestion copyWith({
    String? id,
    List<QuestionContent>? questionContents,
    QuestionType? questionType,
    List<AnswerOption>? answers,
  }) {
    return MedicalSurveyQuestion(
      id: id ?? this.id,
      questionContents: questionContents ?? this.questionContents,
      questionType: questionType ?? this.questionType,
      answers: answers ?? this.answers,
    );
  }
}
