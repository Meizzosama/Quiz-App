import 'package:flutter/material.dart';

import '../questions/easy.dart';
import '../questions/hard.dart';
import '../questions/normal.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double opacity = 1.0; // Example variable that might change over time

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
            colors: [Colors.blue, Colors.green],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedOpacity(
                opacity: opacity,
                duration: const Duration(seconds: 1),
                child: Image.asset('assets/splash.png'),
              ),
              const Text(
                'Choose your quiz difficulty:',
                style: TextStyle(
                  fontSize: 24,
                  color: Color(0xFF5200FF),
                ),
              ),
              const SizedBox(height: 20),
              QuizButton(
                difficulty: 'Easy',
                onPressed: () {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return const EasyQuizScreen();
                      },
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        const begin = Offset(0.0, 0.2);
                        const end = Offset.zero;
                        var tween = Tween(begin: begin, end: end);
                        var offsetAnimation = animation.drive(tween);
                        return SlideTransition(
                          position: offsetAnimation,
                          child: child,
                        );
                      },
                    ),
                  );
                },
              ),
              QuizButton(
                difficulty: 'Normal',
                onPressed: () {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return const NormalQuizScreen();
                      },
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        const begin = Offset(0.0, 0.1);
                        const end = Offset.zero;
                        var tween = Tween(begin: begin, end: end);
                        var offsetAnimation = animation.drive(tween);
                        return SlideTransition(
                          position: offsetAnimation,
                          child: FadeTransition(
                            opacity: animation,
                            child: child,
                          ),
                        );
                      },
                    ),
                  );
                },
              ),

              QuizButton(
                difficulty: 'Hard',
                onPressed: () {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return const HardQuizScreen();
                      },
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        const begin = 0.0;
                        const end = 1.0;
                        var tween = Tween(begin: begin, end: end);
                        var opacityAnimation = animation.drive(tween);
                        return FadeTransition(
                          opacity: opacityAnimation,
                          child: ScaleTransition(
                            scale: animation,
                            alignment: Alignment.center,
                            child: child,
                          ),
                        );
                      },
                    ),
                  );
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

  const QuizButton({super.key, required this.difficulty, required this.onPressed});

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
