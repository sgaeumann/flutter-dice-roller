import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const TP02DiceRollerApp());
}

class TP02DiceRollerApp extends StatelessWidget {
  const TP02DiceRollerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dice Roller',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const DiceRollerScreen(),
    );
  }
}

class DiceRollerScreen extends StatefulWidget {
  const DiceRollerScreen({Key? key}) : super(key: key);

  @override
  State<DiceRollerScreen> createState() => _DiceRollerScreenState();
}

class _DiceRollerScreenState extends State<DiceRollerScreen> {
  static const int diceNumber = 6;
  late int dice1;
  late int dice2;
  bool useTwoDices = false;
  final Random random = Random();

  @override
  void initState() {
    super.initState();
    dice1 = _roll();
    dice2 = _roll();
  }

  int _roll() {
    return random.nextInt(diceNumber) + 1;
  }

  void _throwDice() {
    setState(() {
      dice1 = _roll();
      if (useTwoDices) {
        dice2 = _roll();
      }
    });
  }

  String _getDiceImagePath(int diceValue) {
    return 'assets/dice$diceValue.png';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Switch section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      useTwoDices ? 'Play with 2 dices' : 'Play with 1 dice',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Switch(
                      value: useTwoDices,
                      onChanged: (value) {
                        setState(() {
                          useTwoDices = value;
                        });
                      },
                      activeColor: Theme.of(context).colorScheme.primary,
                      activeTrackColor: Theme.of(context).colorScheme.primaryContainer,
                    ),
                  ),
                ],
              ),
              // Dices section
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (useTwoDices)
                    Expanded(
                      child: Image.asset(
                        _getDiceImagePath(dice2),
                        width: 100,
                        height: 100,
                      ),
                    ),
                  Expanded(
                    child: Image.asset(
                      _getDiceImagePath(dice1),
                      width: 100,
                      height: 100,
                    ),
                  ),
                ],
              ),
              // Button section
              ElevatedButton(
                onPressed: _throwDice,
                child: const Text('Roll'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}