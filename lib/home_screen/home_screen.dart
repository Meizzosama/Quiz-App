import 'package:flutter/material.dart';

import '../questions/easy.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue, Colors.green], // You can change these colors
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Choose your quiz difficulty:',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.orangeAccent,
                ),
              ),
              const SizedBox(height: 20),
              QuizButton(
                difficulty: 'Easy',
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => EasyQuizScreen()));
                },
              ),
              QuizButton(
                difficulty: 'Normal',
                onPressed: () {
                  // Navigator.of(context).push(MaterialPageRoute(builder: (_) => NormalQuizScreen()));
                },
              ),
              QuizButton(
                difficulty: 'Hard',
                onPressed: () {
                  // Navigator.of(context).push(MaterialPageRoute(builder: (_) => HardQuizScreen()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class QuizButton extends StatelessWidget {
  final String difficulty;
  final VoidCallback onPressed;

  QuizButton({required this.difficulty, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '$difficulty Quiz',
          style: const TextStyle(
            fontSize: 18,
            color: Color(0xFF5200FF),
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: onPressed,
          child: const Text(
            'Start Quiz',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF5200FF),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
