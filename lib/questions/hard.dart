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
    question: 'What is the result of the mathematical expression "8^(1/3)"?',
    options: ['2', '4', '8'],
    correctAnswer: 0,
  ),
  QuizQuestion(
    question: 'Which chemical element has the atomic number 79?',
    options: ['Gold', 'Silver', 'Copper'],
    correctAnswer: 0,
  ),
  QuizQuestion(
    question: 'What is the largest organ in the human body?',
    options: ['Heart', 'Brain', 'Skin'],
    correctAnswer: 2,
  ),
  QuizQuestion(
    question: 'Who formulated the theory of relativity, including the famous equation E=mc^2?',
    options: ['Isaac Newton', 'Albert Einstein', 'Stephen Hawking'],
    correctAnswer: 1,
  ),
  QuizQuestion(
    question: 'In which year did the Chernobyl nuclear disaster occur?',
    options: ['1986', '1979', '1991'],
    correctAnswer: 0,
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
          title: const Text('Hard Quiz'),
          backgroundColor: Colors.deepPurple,
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
              colors: [Colors.deepPurple, Colors.black12],
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