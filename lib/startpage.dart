// ignore_for_file: use_build_context_synchronously
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:quzi_app/quenstion.dart';
import 'package:quzi_app/quenstionpage.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(initialRoute: '/start_page', routes: {
    '/start_page': (context) => const StartPage(),
    '/question_page': (context) => QuestionPage(quenstions: quenstions)
  }));
}

List<Question> quenstions = <Question>[];
String url = 'https://quizapi.io/api/v1/questions?',
    apiKey = 'j24WhINsXuMG7PszLmbkLHqRiXRoFnjRZrHxkwDa',
    categoryQuzi = "Linux",
    difficultyQuzi = "easy";

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Container(
      color: Colors.white,
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        const Text(
          "Давай настроим Quzi!",
          style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              decoration: TextDecoration.none),
        ),
        Center(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: ElevatedButton(
                        onPressed: () {
                          categoryQuzi = "Linux";
                        },
                        style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll<Color>(Colors.brown)),
                        child: const Text("Linux")),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(10),
                      child: ElevatedButton(
                          onPressed: () {
                            categoryQuzi = "DevOps";
                          },
                          style: const ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll<Color>(
                                  Colors.brown)),
                          child: const Text("DevOps"))),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                      padding: const EdgeInsets.all(10),
                      child: ElevatedButton(
                          onPressed: () {
                            difficultyQuzi = "easy";
                          },
                          style: const ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll<Color>(
                                  Colors.green)),
                          child: const Text("EASY",
                              style: TextStyle(fontSize: 17)))),
                  Padding(
                      padding: const EdgeInsets.all(10),
                      child: ElevatedButton(
                          onPressed: () {
                            difficultyQuzi = "medium";
                          },
                          style: const ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll<Color>(
                                  Colors.yellow)),
                          child: const Text("MEDIUM",
                              style: TextStyle(fontSize: 17)))),
                  Padding(
                      padding: const EdgeInsets.all(10),
                      child: ElevatedButton(
                          onPressed: () {
                            difficultyQuzi = "hard";
                          },
                          style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll<Color>(Colors.red)),
                          child: const Text("HARD",
                              style: TextStyle(fontSize: 17))))
                ],
              )
            ])),
        ElevatedButton(
            onPressed: () async {
              quenstions = await fetch();
              Navigator.pushNamed(context, '/question_page',
                  arguments: quenstions);
            },
            style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(Colors.brown)),
            child: const Text("Начнём!"))
      ]),
    ));
  }
}

fetch() async {
  List<Question> quenstionsList = <Question>[];
  String queryParams =
      'apiKey=$apiKey&limit=10&category=$categoryQuzi&difficulty=$difficultyQuzi';
  http.Response response = await http.get(Uri.parse(url + queryParams));

  final decoded = json.decode(response.body);

  for (final item in decoded) {
    quenstionsList.add(Question.fromJson(item));
  }

  return quenstionsList;
}
