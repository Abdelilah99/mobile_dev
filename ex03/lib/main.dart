import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String expression = '';
  String result = '0';

  void buttonPressed(String buttonText) {
    debugPrint("Button pressed: $buttonText");
    setState(() {
      if (buttonText == 'AC') {
        expression = '';
        result = '0';
      } else if (buttonText == 'C') {
        if (expression.isNotEmpty) {
          expression = expression.substring(0, expression.length - 1);
        }
      } else if (buttonText == '=') {
        try {
          // Parse and evaluate the expression
          Parser parser = Parser();
          Expression exp = parser.parse(expression);
          ContextModel cm = ContextModel();
          double eval = exp.evaluate(EvaluationType.REAL, cm);
          result = eval.toString();
        } catch (e) {
          result = 'Error';
        }
      } else {
        // Build expression with button presses
        expression += buttonText;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculator"),
        backgroundColor: Colors.teal,
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return Column(
            children: [
              // Display area for expression and result
              Expanded(
                flex: 2,
                child: Container(
                  color: Colors.black,
                  padding: EdgeInsets.all(20.0),
                  alignment: Alignment.bottomRight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        expression,
                        style: TextStyle(color: Colors.white, fontSize: 24.0),
                      ),
                      Text(
                        result,
                        style: TextStyle(color: Colors.white, fontSize: 48.0, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              // Button grid area
              Expanded(
                flex: 3,
                child: GridView.builder(
                  padding: EdgeInsets.all(10.0),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: orientation == Orientation.portrait ? 4 : 6,
                    mainAxisSpacing: 8.0,
                    crossAxisSpacing: 8.0,
                    childAspectRatio: orientation == Orientation.portrait ? 1.0 : 1.5,
                  ),
                  itemCount: buttons.length,
                  itemBuilder: (context, index) {
                    String buttonText = buttons[index];
                    return CalculatorButton(
                      text: buttonText,
                      onTap: () => buttonPressed(buttonText),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  final List<String> buttons = [
    '7', '8', '9', 'C', 'AC',
    '4', '5', '6', '+', '-',
    '1', '2', '3', '*', '/',
    '0', '00', '.', '=',
  ];
}

class CalculatorButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  CalculatorButton({required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 24.0,
              color: text == 'C' || text == 'AC' ? Colors.red : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}