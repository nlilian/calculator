import 'package:calculator/calcbutton.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorView extends StatefulWidget {
  const CalculatorView({super.key});

  @override
  State<CalculatorView> createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<CalculatorView> {
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;

  // Step 6: Implement the calculator logic

  buttonPressed(String buttonText) {
    // used to check if the result contains a decimal

    String doesContainDecimal(dynamic result) {
      if (result.toString().contains(".")) {
        List<String> splitDecimal = result.toString().split(".");
        if (!(int.parse(splitDecimal[1]) > 0)) {
          return result = splitDecimal[0].toString();
        }
      }
      return result;
    }

    setState(() {
      if (buttonText == "AC") {
        equation = "0";
        result = "0";
      } else if (buttonText == "⌫") {
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } else if (buttonText == "+/-") {
        if (equation[0] != '-') {
          equation = '-$equation';
        } else {
          equation = equation.substring(1);
        }
      } else if (buttonText == "=") {
        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');
        expression = expression.replaceAll('%', '%');

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
          if (expression.contains('%')) {
            result = doesContainDecimal(result);
          }
        } catch (e) {
          result = "Error";
        }
      } else {
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black54,
        // leading: const Icon(Icons.settings, color: Colors.orange),
        actions: const [
          Padding(
            padding: EdgeInsets.only(top: 18.0),
            child: Text(
              "DEG",
              style: TextStyle(color: Colors.white38),
            ),
          ),
          SizedBox(width: 20),
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Align(
              alignment: Alignment.bottomRight,
              child: SingleChildScrollView(
                // scrollDirection: Axis.vertical,
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            result,
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.fade,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                            ),
                          ),
                        ),
                        // const Icon(
                        //   Icons.more_vert,
                        //   color: Colors.orange,
                        //   size: 30,
                        // ),
                        const SizedBox(width: 20),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: RichText(
                              maxLines: 3,
                              textDirection: TextDirection.ltr,
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(
                                text: equation,
                                style: TextStyle(
                                  fontSize: equation.length > 14 ? 26 : 40,
                                  color: Colors.white38,
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Flexible(
                        //   child: Padding(
                        //     padding: const EdgeInsets.all(20),
                        //     child: Text(equation,
                        //     // overflow: TextOverflow.ellipsis,
                        // style:  TextStyle(
                        //   fontSize: equation.length > 30 ? 20 : 40,
                        //   color: Colors.white38,
                        // )),
                        //   ),
                        // ),

                        const SizedBox(width: 20),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 12),
                      child: IconButton(
                        icon: const Icon(Icons.backspace_outlined,
                            color: Colors.orange, size: 30),
                        onPressed: () {
                          equation.length == 10 ? null : buttonPressed("⌫");
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
// Adding Buttons

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcButton("AC", Colors.white10, () => buttonPressed("AC")),
                calcButton('%', Colors.white10,
                    () => equation.length == 66 ? null : buttonPressed('%')),
                calcButton('÷', Colors.white10,
                    () => equation.length == 66 ? null : buttonPressed('÷')),
                calcButton("×", Colors.white10,
                    () => equation.length == 66 ? null : buttonPressed('×')),
              ],
            ),
            const SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcButton('7', Colors.white24,
                    () => equation.length == 66 ? null : buttonPressed('7')),
                calcButton('8', Colors.white24,
                    () => equation.length == 66 ? null : buttonPressed('8')),
                calcButton('9', Colors.white24,
                    () => equation.length == 66 ? null : buttonPressed('9')),
                calcButton('-', Colors.white10,
                    () => equation.length == 66 ? null : buttonPressed('-')),
              ],
            ),
            const SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcButton('4', Colors.white24,
                    () => equation.length == 66 ? null : buttonPressed('4')),
                calcButton('5', Colors.white24,
                    () => equation.length == 66 ? null : buttonPressed('5')),
                calcButton('6', Colors.white24,
                    () => equation.length == 66 ? null : buttonPressed('6')),
                calcButton('+', Colors.white10,
                    () => equation.length == 66 ? null : buttonPressed('+')),
              ],
            ),
            const SizedBox(height: 10),
// calculator number buttons

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  //mainAxisAlignment: MainAxisAlignment.spaceAround
                  children: [
                    Row(
                      children: [
                        calcButton(
                            '1',
                            Colors.white24,
                            () => equation.length == 66
                                ? null
                                : buttonPressed('1')),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.06),
                        calcButton(
                            '2',
                            Colors.white24,
                            () => equation.length == 66
                                ? null
                                : buttonPressed('2')),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.06),
                        calcButton(
                            '3',
                            Colors.white24,
                            () => equation.length == 66
                                ? null
                                : buttonPressed('3')),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        calcButton(
                            '+/-',
                            Colors.white24,
                            () => equation.length == 66
                                ? null
                                : buttonPressed('+/-')),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.06),
                        calcButton(
                            '0',
                            Colors.white24,
                            () => equation.length == 66
                                ? null
                                : buttonPressed('0')),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.06),
                        calcButton(
                            '.',
                            Colors.white24,
                            () => equation.length == 66
                                ? null
                                : buttonPressed('.')),
                      ],
                    ),
                  ],
                ),
                calcButton('=', Colors.orange, () => buttonPressed('=')),
              ],
            )
          ],
        ),
      ),
    );
  }
}
