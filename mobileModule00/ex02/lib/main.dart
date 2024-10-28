import 'package:flutter/material.dart';

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

class CalculatorScreen extends StatelessWidget {
  final List<String> buttons = [
    '7', '8', '9', 'C', 'AC',
    '4', '5', '6', '+', '-',
    '1', '2', '3', '*', '/',
    '0', '00', '.', '=',
  ];

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
                        "0", // Placeholder for expression
                        style: TextStyle(color: Colors.white, fontSize: 24.0),
                      ),
                      Text(
                        "0", // Placeholder for result
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
                      onTap: () {
                        debugPrint("Button pressed: $buttonText");
                      },
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