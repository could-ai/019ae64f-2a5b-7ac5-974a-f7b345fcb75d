import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Addition Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const CalculatorScreen(),
      },
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  // Controllers to retrieve text from input fields
  final TextEditingController _num1Controller = TextEditingController();
  final TextEditingController _num2Controller = TextEditingController();
  
  // Variable to store the result message
  String _result = '';

  void _calculateSum() {
    // Get text from controllers
    String text1 = _num1Controller.text;
    String text2 = _num2Controller.text;

    // Check if inputs are empty
    if (text1.isEmpty || text2.isEmpty) {
      setState(() {
        _result = 'Please enter both numbers';
      });
      return;
    }

    try {
      // Parse inputs to doubles
      double num1 = double.parse(text1);
      double num2 = double.parse(text2);
      
      // Calculate sum
      double sum = num1 + num2;

      setState(() {
        // Format output: remove decimal point if it's a whole number
        if (sum % 1 == 0) {
          _result = 'Result: ${sum.toInt()}';
        } else {
          _result = 'Result: $sum';
        }
      });
    } catch (e) {
      // Handle non-numeric input
      setState(() {
        _result = 'Invalid input. Please enter valid numbers.';
      });
    }
  }

  @override
  void dispose() {
    // Clean up controllers when the widget is disposed
    _num1Controller.dispose();
    _num2Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Addition Calculator'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // First Input Field
            TextField(
              controller: _num1Controller,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'First Number',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.numbers),
              ),
            ),
            const SizedBox(height: 20),
            
            // Plus Icon
            const Icon(Icons.add, size: 30),
            const SizedBox(height: 20),
            
            // Second Input Field
            TextField(
              controller: _num2Controller,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Second Number',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.numbers),
              ),
            ),
            const SizedBox(height: 30),
            
            // Calculate Button
            ElevatedButton(
              onPressed: _calculateSum,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                textStyle: const TextStyle(fontSize: 18),
              ),
              child: const Text('Calculate Sum'),
            ),
            const SizedBox(height: 30),
            
            // Result Display
            Text(
              _result,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
