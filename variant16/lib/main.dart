import 'package:flutter/material.dart';
import "package:math_expressions/math_expressions.dart";

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String input = '0';
  String previous = '';
  bool shouldReset = false;
  bool hasDecimal = false;

  void onButtonPressed(String value) {
    setState(() {
      if (value == 'AC') {
        input = '0';
        previous = '';
        shouldReset = false;
        hasDecimal = false;
      } else if (value == '=') {
        try {
          String expression = input.replaceAll('x', '*').replaceAll('÷', '/');
          // ignore: deprecated_member_use
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          double eval = exp.evaluate(EvaluationType.REAL, cm);

          previous = input;
          input = eval % 1 == 0 ? eval.toInt().toString() : eval.toString();
          shouldReset = true;
          hasDecimal = input.contains('.');
        } catch (e) {
          input = 'Error';
          shouldReset = true;
        }
      } else if ('+-*/'.contains(value)) {
        if ('+-*/'.contains(input[input.length - 1])) {
          input = input.substring(0, input.length - 1) + value;
        } else {
          input += value;
        }
        hasDecimal = false;
        shouldReset = false;
      } else if (value == '.') {
        if (!hasDecimal) {
          if ('+-*/'.contains(input[input.length - 1])) {
            input += '0.';
          } else {
            input += '.';
          }
          hasDecimal = true;
        }
      } else {
        if (shouldReset) {
          input = value;
          shouldReset = false;
        } else {
          if (input == '0') {
            input = value;
          } else {
            input += value;
          }
        }
      }
    });
  }

  Widget buildButton(String text, {Color? color}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: GestureDetector(
          onTap: () => onButtonPressed(text),
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              color: color ?? Colors.grey[600],
              borderRadius: BorderRadius.circular(6),
            ),
            child: Center(
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Container(
          width: 300,
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [Colors.lime, Colors.green]),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                // ignore: deprecated_member_use
                color: Colors.black.withOpacity(0.3),
                offset: const Offset(4, 4),
                blurRadius: 10,
              ),
            ],
          ),
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Bitta Container ichida ikkita Text widgeti
              Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      height: 40,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        previous,
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Container(
                      height: 80,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        input,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              Container(
                color: Colors.black,
                child: Column(
                  children: [
                    Row(
                      children: [
                        buildButton('AC', color: Colors.green),
                        const Spacer(),
                        buildButton('/', color: Colors.green),
                      ],
                    ),
                    Row(
                      children: [
                        buildButton('7'),
                        buildButton('8'),
                        buildButton('9'),
                        buildButton('*', color: Colors.green),
                      ],
                    ),
                    Row(
                      children: [
                        buildButton('4'),
                        buildButton('5'),
                        buildButton('6'),
                        buildButton('-', color: Colors.green),
                      ],
                    ),
                    Row(
                      children: [
                        buildButton('1'),
                        buildButton('2'),
                        buildButton('3'),
                        buildButton('+', color: Colors.green),
                      ],
                    ),
                    Row(
                      children: [
                        buildButton('0', color: Colors.green),
                        buildButton('.', color: Colors.green),
                        buildButton('=', color: Colors.green),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
