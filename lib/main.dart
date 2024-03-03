import 'package:flutter/material.dart';

void main() {
  runApp(const BMICalculatorApp());
}

class BMICalculatorApp extends StatelessWidget {
  const BMICalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFF3F5F7),
      ),
      home: const BMICalculatorScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class BMICalculatorScreen extends StatefulWidget {
  const BMICalculatorScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BMICalculatorScreenState createState() => _BMICalculatorScreenState();
}

class _BMICalculatorScreenState extends State<BMICalculatorScreen> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  double bmiResult = 0.0;
  String bmiCategory = "";

  void calculateBMI() {
    double? weight = double.tryParse(weightController.text);
    double? height = double.tryParse(heightController.text);
    if (weight != null && height != null && height > 0) {
      double bmi = weight / (height * height);
      setState(() {
        bmiResult = bmi;
        if (bmi < 18.5) {
          bmiCategory = 'Underweight';
        } else if (bmi < 25) {
          bmiCategory = 'Normal weight';
        } else if (bmi < 30) {
          bmiCategory = 'Overweight';
        } else {
          bmiCategory = 'Obese';
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFAEDBF5), Color(0xFFD6EAF8)],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Calculate Your BMI',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF34495E),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextField(
                        controller: weightController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Weight (kg)',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF7F8C8D)),
                          ),
                          labelStyle: TextStyle(color: Color(0xFF34495E)),
                          prefixIcon: Icon(Icons.fitness_center,
                              color: Color(0xFF34495E)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextField(
                        controller: heightController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Height (m)',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF7F8C8D)),
                          ),
                          labelStyle: TextStyle(color: Color(0xFF34495E)),
                          prefixIcon:
                              Icon(Icons.height, color: Color(0xFF34495E)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: calculateBMI,
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF34495E),
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    minimumSize: const Size(double.infinity, 48.0),
                    foregroundColor: Colors.white),
                child: const Text('Calculate BMI'),
              ),
              const SizedBox(height: 20.0),
              AnimatedOpacity(
                opacity: bmiResult > 0 ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 500),
                child: Column(
                  children: [
                    const Text(
                      'Your BMI:',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF34495E),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      bmiResult.toStringAsFixed(2),
                      style: const TextStyle(
                        fontSize: 36.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF34495E),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Text(
                      'Category: $bmiCategory',
                      style: const TextStyle(
                        fontSize: 20.0,
                        color: Color(0xFF34495E),
                      ),
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
