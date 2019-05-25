import "package:flutter/material.dart";

import "../utils/question.dart";
import "../utils/quiz.dart";

import "../ui/answer_button.dart";
import "../ui/question_text.dart";
import "../ui/on_answer_overlay.dart";

import "./score_page.dart";

class QuizPage extends StatefulWidget {
  @override
  State createState() => new QuizPageState();
}

class QuizPageState extends State<QuizPage>{

  Question currentQuestion;
  Quiz quiz = new Quiz([
    new Question("Elon Musk is human", false),
    new Question("Bread is edible", true),
    new Question("Flutter is awesome", true),
    new Question("You can walk on water", false),
    new Question("Ice is warm", false),
  ]);
  String questionText;
  int questionNumber;
  bool isCorrect;
  bool isOverlayVisible;

  void handleAnswer(bool answer) {
    isCorrect = (currentQuestion.answer == answer);
    quiz.answer(isCorrect);
    this.setState(() {
      isOverlayVisible = true;
    });
  }

  @override
  void initState() {
    super.initState();
    currentQuestion = quiz.nextQuestion;
    questionText = currentQuestion.question;
    questionNumber = quiz.questionNumber;
  }


  @override
  Widget build(BuildContext context) {
    return new Stack(
      fit: StackFit.expand,
      children: <Widget>[
        new Column( // Main page
          children: <Widget>[
            new AnswerButton(true, () => handleAnswer(true)),
            new QuestionText(questionText, questionNumber),
            new AnswerButton(false, () => handleAnswer(false)),
          ],
        ),
        isOverlayVisible == true ? new OnAnswerOverlay(isCorrect, () {
          if (quiz.length == questionNumber) {
            Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(builder: (BuildContext context) => new ScorePage(quiz.score, quiz.length)), (Route route) => route == null);
          }
          currentQuestion = quiz.nextQuestion;
          this.setState(() {
            isOverlayVisible = false;
            questionText = currentQuestion.question;
            questionNumber = quiz.questionNumber;
          });
        }) : new Container(),
      ],
    );
  }
}