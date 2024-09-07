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

final List<QuizQuestion> mediumLevelQuestions = [
  QuizQuestion(
    question: 'What is the square root of 81?',
    options: ['7', '8', '9'],
    correctAnswer: 2,
  ),
  QuizQuestion(
    question: 'Which element has the atomic number 6?',
    options: ['Carbon', 'Oxygen', 'Nitrogen'],
    correctAnswer: 0,
  ),
  QuizQuestion(
    question: 'Which country is known as the Land of the Rising Sun?',
    options: ['China', 'Japan', 'Thailand'],
    correctAnswer: 1,
  ),
  QuizQuestion(
    question: 'Which planet is the largest in the solar system?',
    options: ['Earth', 'Jupiter', 'Saturn'],
    correctAnswer: 1,
  ),
  QuizQuestion(
    question: 'Who discovered electricity?',
    options: ['Nikola Tesla', 'Thomas Edison', 'Benjamin Franklin'],
    correctAnswer: 2,
  ),
  QuizQuestion(
    question: 'What is the main ingredient in traditional Japanese miso soup?',
    options: ['Soybeans', 'Rice', 'Seaweed'],
    correctAnswer: 0,
  ),
  QuizQuestion(
    question: 'How many degrees are in a right angle?',
    options: ['45', '90', '180'],
    correctAnswer: 1,
  ),
  QuizQuestion(
    question: 'What is the capital city of Canada?',
    options: ['Toronto', 'Vancouver', 'Ottawa'],
    correctAnswer: 2,
  ),
  QuizQuestion(
    question: 'What is the powerhouse of the cell?',
    options: ['Nucleus', 'Mitochondria', 'Ribosome'],
    correctAnswer: 1,
  ),
  QuizQuestion(
    question: 'Which is the second longest river in the world?',
    options: ['Amazon', 'Nile', 'Yangtze'],
    correctAnswer: 0,
  ),
];

class MediumQuizScreen extends StatefulWidget {
  const MediumQuizScreen({super.key});

  @override
  _MediumQuizScreenState createState() => _MediumQuizScreenState();
}

class _MediumQuizScreenState extends State<MediumQuizScreen> {
  int currentQuestionIndex = 0;
  int userScore = 0;

  final List<String> optionLabels = ['A', 'B', 'C'];
  int selectedOptionIndex = -1;

  List<String> remarks = [
    'Great job! You nailed it!',
    'Good work! Keep improving!',
    'Not bad, but you can do better!',
  ];

  void showRemarks() {
    int remarksIndex = userScore == mediumLevelQuestions.length
        ? 0
        : userScore >= (mediumLevelQuestions.length ~/ 2)
        ? 1
        : 2;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Quiz Completed'),
          content: Text(
            '${remarks[remarksIndex]}\n\nYou scored $userScore out of ${mediumLevelQuestions.length}.',
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
    final currentQuestion = mediumLevelQuestions[currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Medium Quiz'),
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blueGrey, Colors.deepPurpleAccent],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Question ${currentQuestionIndex + 1}/${mediumLevelQuestions.length}:',
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
                  final isCorrectAnswer = optionIndex == currentQuestion.correctAnswer;

                  return InkWell(
                    onTap: () {
                      setState(() {
                        selectedOptionIndex = optionIndex;
                        // Add points if the answer is correct
                        if (isCorrectAnswer) {
                          userScore++;
                        }

                        // Move to the next question or show remarks at the end
                        if (currentQuestionIndex < mediumLevelQuestions.length - 1) {
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
                              ? (isCorrectAnswer ? Colors.green : Colors.red)
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
