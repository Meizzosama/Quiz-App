import 'package:flutter/material.dart';
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
final List<QuizQuestion> dummyQuestions = [
  QuizQuestion(
    question: 'What is the capital of France?',
    options: ['London', 'Berlin', 'Paris'],
    correctAnswer: 2,
  ),
  QuizQuestion(
    question: 'Which planet is known as the "Red Planet"??',
    options: ['Jupiter', 'Venus', 'Mars'],
    correctAnswer: 2,
  ),
  QuizQuestion(
    question: 'What is the largest organ in the human body?',
    options: ['Heart', 'Brain', 'Skin'],
    correctAnswer: 2,
  ),
  QuizQuestion(
    question: 'Who painted the Mona Lisa?',
    options: ['Leonardo da Vinci', 'Vincent van Gogh', ' Pablo Picasso'],
    correctAnswer: 0,
  ),
  QuizQuestion(
    question: 'What is the chemical symbol for water?',
    options: ['H2O', 'CO2', 'O2'],
    correctAnswer: 0,
  ),
];
class EasyQuizScreen extends StatefulWidget {
  const EasyQuizScreen({super.key});
  @override
  _EasyQuizScreenState createState() => _EasyQuizScreenState();
}
class _EasyQuizScreenState extends State<EasyQuizScreen> {
  int currentQuestionIndex = 0;
  int userScore = 0;

  final List<String> optionLabels = ['A', 'B', 'C'];
  int selectedOptionIndex = -1;

  List<String> remarks = [
    'Perfect! You got all questions correct!',
    'Well done! You did a great job!',
    'Keep practicing. You can do better!',
  ];
  void showRemarks() {
    int remarksIndex = userScore == dummyQuestions.length
        ? 0
        : userScore >= (dummyQuestions.length ~/ 2)
        ? 1
        : 2;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Quiz Remarks'),
          content: Text(remarks[remarksIndex]),
          actions: <Widget>[
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
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    final currentQuestion = dummyQuestions[currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Easy Quiz'),
        backgroundColor: Colors.black12,
        centerTitle: true,
      ),
      body:
      Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black12, Colors.orangeAccent],
          ),
      ),
          child:  Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Question ${currentQuestionIndex + 1}/${dummyQuestions.length}:',
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
                      userScore = isCorrectAnswer ? userScore + 1 : userScore;
                      if (currentQuestionIndex < dummyQuestions.length - 1) {
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
      ) );
  }
}