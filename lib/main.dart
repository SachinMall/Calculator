import 'package:calculator/colors.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: CalculatorApp(),
    );
  }
}

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  //variables//
  double firstNum = 0.0;
  double secondNum = 0.0;
  var input = '';
  var output = '';
  var operation = '';
  var hideInput = false;
  var outputSize = 50.0;

  onButtonClick(value) {
    //if value is AC

    if (value == "AC") {
      input = '';
      output = '';
    } else if (value == "<") {
      input = input.substring(0, input.length - 1);
    } else if (value == "=") {
      if (input.isNotEmpty) {
        var userInput = input;

        userInput = input.replaceAll("x", "*");
        Parser p = Parser();
        Expression expression = p.parse(userInput);
        ContextModel cm = ContextModel();
        var finalValue = expression.evaluate(EvaluationType.REAL, cm);
        output = finalValue.toString();
        if (output.endsWith(".0")) {
          output = output.substring(0, output.length - 2);
        }
        input = output;
        hideInput = true;
        outputSize = 52;
      }
    } else {
      input = input + value;
      hideInput = false;
      outputSize = 52;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
              child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  hideInput ? '' : input,
                  style: const TextStyle(fontSize: 70, color: Colors.white),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  output,
                  style: TextStyle(
                      fontSize: outputSize,
                      color: Colors.white.withOpacity(0.7)),
                ),
              ],
            ),
          )),
          Row(
            children: [
              button(
                  text: "AC",
                  buttonBgColor: operatorColor,
                  tColor: Colors.black),
              button(text: "<", buttonBgColor: operatorColor),
              button(text: "+/_", buttonBgColor: operatorColor),
              button(text: "/", buttonBgColor: orangeColor)
            ],
          ),
          Row(
            children: [
              button(
                text: "7",
              ),
              button(
                text: "8",
              ),
              button(
                text: "9",
              ),
              button(text: "x", buttonBgColor: orangeColor)
            ],
          ),
          Row(
            children: [
              button(
                text: "4",
              ),
              button(
                text: "5",
              ),
              button(
                text: "6",
              ),
              button(text: "-", buttonBgColor: orangeColor)
            ],
          ),
          Row(
            children: [
              button(
                text: "1",
              ),
              button(
                text: "2",
              ),
              button(
                text: "3",
              ),
              button(text: "+", buttonBgColor: orangeColor)
            ],
          ),
          Row(
            children: [
              button(
                text: "%",
              ),
              button(
                text: "0",
              ),
              button(
                text: ".",
              ),
              button(text: "=", buttonBgColor: orangeColor)
            ],
          ),
        ],
      ),
    );
  }

  Widget button({
    text,
    tColor = Colors.white,
    buttonBgColor = buttonColor,
  }) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(60),
            ),
            backgroundColor: buttonBgColor,
            padding: const EdgeInsets.all(22),
          ),
          onPressed: () => onButtonClick(text),
          child: Text(
            text,
            style: TextStyle(
                fontWeight: FontWeight.bold, color: tColor, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
