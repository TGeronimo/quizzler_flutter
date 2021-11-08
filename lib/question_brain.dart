import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'question.dart';

class QuestionBrain {
  int _questionNumber = 0;
  int numberCorrect = 0;

  List<Icon> answersStatusList = [];

  final List<Question> _questionBank = [
    Question(
        questionText: 'Uma vaca pode subir escadas, mas não pode descer.',
        questionAnswer: false),
    Question(
        questionText: 'Cavalos podem aprender a contar.', questionAnswer: true),
    Question(
        questionText:
            '"Martelo" é o nome de um dos menores ossos do corpo humano.',
        questionAnswer: true),
    Question(
        questionText: 'Soldados Kamikazes usavam capacetes?',
        questionAnswer: true),
    Question(
        questionText: 'Um raio pode derrubar o avião.', questionAnswer: true),
    Question(
        questionText:
            'A água da privada gira em sentidos diferentes no hemisfério norte e no hemisfério sul.',
        questionAnswer: false),
    Question(
        questionText:
            'Se houvesse guerras no espaço, como no filme Guerra nas Estrelas, o barulho de tiros e perseguições não seriam ouvidos.',
        questionAnswer: true),
    Question(
        questionText:
            'Os aviões são fabricados com o mesmo material das caixas pretas.',
        questionAnswer: false),
    Question(
        questionText:
            'Apertar os botões do controle remoto com mais força faz com que ele volte a funcionar.',
        questionAnswer: false),
    Question(
        questionText: 'A fila ao lado sempre andará mais rápido que a sua.',
        questionAnswer: true),
    Question(
        questionText:
            'Quando ligamos para um número errado, nunca dará ocupado.',
        questionAnswer: false),
    Question(
        questionText: 'Bebidas Alcoólicas matam as células do seu cérebro.',
        questionAnswer: false),
    Question(
        questionText: 'A fórmula da Coca-Cola nunca foi descoberta.',
        questionAnswer: false),
    Question(
        questionText: 'Turbulências são capazes de derrubar aviões.',
        questionAnswer: false),
    Question(questionText: 'O Sol não é amarelo.', questionAnswer: true),
  ];

  String getQuestionText() {
    return _questionBank[_questionNumber].questionText;
  }

  void nextQuestion() {
    if (_questionNumber < _questionBank.length - 1) {
      _questionNumber++;
    }
  }

  void checkAnswer(bool buttonAnswer, BuildContext context) {
    if (buttonAnswer == _questionBank[_questionNumber].questionAnswer) {
      numberCorrect++;
      playSoundOK();
      answersStatusList.add(const Icon(
        Icons.check,
        color: Colors.green,
      ));
    } else {
      playSoundWrong();
      answersStatusList.add(const Icon(
        Icons.close,
        color: Colors.red,
      ));
    }

    if (isFinished()) {
      var finalScore = getFinalScore().toStringAsPrecision(2);

      reset();

      var alertStyle = AlertStyle(
        animationType: AnimationType.grow,
        isCloseButton: false,
        isOverlayTapDismiss: false,
        descStyle: TextStyle(fontWeight: FontWeight.bold),
        descTextAlign: TextAlign.start,
        animationDuration: Duration(milliseconds: 600),
        alertBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40.0),
          side: const BorderSide(
            color: Colors.grey,
          ),
        ),
        titleStyle: TextStyle(
          color: Colors.lightBlue[600],
        ),
        alertAlignment: Alignment.center,
      );

      Alert(
          context: context,
          title: "AÊEEEEEEE",
          style: alertStyle,
          desc: "Você concluiu o quiz.",
          content: Center(
            child: Text(
              '\nSua pontuação foi de $finalScore%',
              style: const TextStyle(
                color: Colors.green,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          image: Image.asset("images/well-done.png"),
          padding: const EdgeInsets.all(8.0),
          buttons: [
            DialogButton(
                height: 60.0,
                width: 250.0,
                padding: EdgeInsets.all(5.0),
                radius: BorderRadius.circular(50.0),
                onPressed: () => Navigator.pop(context),
                color: Colors.lightBlue[700],
                child: const Text(
                  'DE NOVO!',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 30,
                    wordSpacing: 5,
                  ),
                )),
          ]).show();
    } else {
      nextQuestion();
    }
  }

  double getFinalScore() {
    return (numberCorrect / _questionBank.length * 100);
  }

  void playSoundOK() {
    final player = AudioCache();
    player.play('tada.mp3');
  }

  void playSoundWrong() {
    final player = AudioCache();
    player.play('bonk.mp3');
  }

  bool isFinished() {
    if (_questionBank[_questionNumber].questionText ==
        _questionBank.last.questionText) {
      return true;
    } else {
      return false;
    }
  }

  void reset() {
    _questionNumber = 0;
    numberCorrect = 0;
    answersStatusList.clear();
  }
}
