import 'dart:math';
import 'package:flutter/material.dart';

import '../home_screen/home_screen.dart';

class QuizQuestion {
  final String question;
  final List<String> options;
  final int correctAnswer;

  QuizQuestion({
    required this.question,
    required this.options,
    required this.correctAnswer,
  });
}

final List<QuizQuestion> hardQuestions = [
  QuizQuestion(
    question: 'What is the capital city of Australia?',
    options: ['Sydney', 'Melbourne', 'Canberra'],
    correctAnswer: 2,
  ),
  QuizQuestion(
    question: 'Which element has the atomic number 1?',
    options: ['Oxygen', 'Helium', 'Hydrogen'],
    correctAnswer: 2,
  ),
  QuizQuestion(
    question: 'Who wrote the novel "1984"?',
    options: ['George Orwell', 'Aldous Huxley', 'F. Scott Fitzgerald'],
    correctAnswer: 0,
  ),
  QuizQuestion(
    question: 'Which country has won the most FIFA World Cups?',
    options: ['Germany', 'Brazil', 'Italy'],
    correctAnswer: 1,
  ),
  QuizQuestion(
    question: 'What is the square root of 144?',
    options: ['10', '12', '14'],
    correctAnswer: 1,
  ),
  QuizQuestion(
    question: 'Who is known as the father of modern physics?',
    options: ['Isaac Newton', 'Albert Einstein', 'Niels Bohr'],
    correctAnswer: 1,
  ),
  QuizQuestion(
    question: 'Which year did the Titanic sink?',
    options: ['1910', '1912', '1915'],
    correctAnswer: 1,
  ),
  QuizQuestion(
    question: 'Which planet has the most moons?',
    options: ['Saturn', 'Jupiter', 'Uranus'],
    correctAnswer: 1,
  ),
  QuizQuestion(
    question: 'Who was the first person to walk on the moon?',
    options: ['Neil Armstrong', 'Buzz Aldrin', 'Yuri Gagarin'],
    correctAnswer: 0,
  ),
  QuizQuestion(
    question: 'What is the largest desert in the world?',
    options: ['Sahara', 'Gobi', 'Antarctica'],
    correctAnswer: 2,
  ),
];

class HardQuizScreen extends StatefulWidget {
  const HardQuizScreen({super.key});

  @override
  _HardQuizScreenState createState() => _HardQuizScreenState();
}

class _HardQuizScreenState extends State<HardQuizScreen> {
  int currentQuestionIndex = 0;
  int userScore = 0;
  int selectedOptionIndex = -1;

  late List<QuizQuestion> questions;
  final List<String> optionLabels = ['A', 'B', 'C'];
  final Random random = Random();

  @override
  void initState() {
    super.initState();
    // Shuffle the hard questions when the quiz starts
    questions = hardQuestions..shuffle(random);
  }

  List<String> remarks = [
    'Excellent! You aced the hard quiz!',
    'Good job! You did really well!',
    'Keep practicing! You can improve!',
  ];

  void showRemarks() {
    int remarksIndex = userScore == questions.length
        ? 0
        : userScore >= (questions.length ~/ 2)
        ? 1
        : 2;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Quiz Remarks'),
          content: Text(
            '${remarks[remarksIndex]}\n\nYou scored $userScore out of ${questions.length}.',
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    // Reset the quiz
                    setState(() {
                      currentQuestionIndex = 0;
                      userScore = 0;
                      selectedOptionIndex = -1;
                    });
                    Navigator.of(context).pop();
                  },
                  child: const Text('Restart'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const HomeScreen()));
                  },
                  child: const Text('Okay'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = questions[currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hard Quiz'),
        backgroundColor: Colors.deepOrange,
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.deepOrange, Colors.deepPurpleAccent],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Question ${currentQuestionIndex + 1}/${questions.length}:',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                currentQuestion.question,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 16),
              Column(
                children: currentQuestion.options.asMap().entries.map((entry) {
                  final optionIndex = entry.key;
                  final optionText = entry.value;
                  final isCorrectAnswer =
                      optionIndex == currentQuestion.correctAnswer;
                  return InkWell(
                    onTap: () {
                      setState(() {
                        selectedOptionIndex = optionIndex;
                        if (isCorrectAnswer) {
                          userScore++;
                        }
                        if (currentQuestionIndex < questions.length - 1) {
                          currentQuestionIndex++;
                          selectedOptionIndex = -1;
                        } else {
                          showRemarks();
                        }
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: selectedOptionIndex == optionIndex
                              ? (isCorrectAnswer
                              ? Colors.green
                              : Colors.red)
                              : Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: const EdgeInsets.all(12.0),
                      margin: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        children: [
                          Text(
                            optionLabels[optionIndex],
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(optionText),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
