import 'package:quzi_app/answers.dart';
class Question {
  late int? id;
  late String? question;
  Question({this.id, this.question});
   Question.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
  }
  /* late List<Answers> listAnswers; */
}
