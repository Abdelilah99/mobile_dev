import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(), // Setting HomePage as the main screen
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _handleButtonPress() {
    print('Button pressed'); // This will print to the debug console
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Exercise ex00'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Hello, World!',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20), // Adds spacing between text and button
            ElevatedButton(
              onPressed: _handleButtonPress, // Calls the function when pressed
              child: Text('Press Me'),
            ),
          ],
        ),
      ),
    );
  }
}
