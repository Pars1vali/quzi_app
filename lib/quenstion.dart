import 'package:quzi_app/answers.dart';

class Question {
  late int id;
  late String question;
  List<String> texts = [];
  List<bool> corects = [];

  List<Answers> answers = <Answers>[];

  Question(this.id, this.question);

  Question.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];

    json['answers'].forEach((key, value) => {
          if (value == null) {texts.add("null")} else {texts.add(value)}
        });
    json['correct_answers'].forEach((key, value) => {
          corects.add(bool.parse(value))
        });

    for (int i = 0; i < texts.length; i++) {
      answers.add(Answers(texts[i], corects[i]));
    }
  }
}
