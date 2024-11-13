import 'package:flutter/material.dart';

void main() {
  runApp(const BMICalculatorApp());
}


class BMICalculatorApp extends StatelessWidget {
  const BMICalculatorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BMICalculator(),
    );
  }
}

class BMICalculator extends StatefulWidget {
  @override
  _BMICalculatorState createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  String gender = "Select Gender";
  double bmi = 0;
  String bmiStatus = "";
  String avatar = "assets/question_mark.png";
  final Map<String, String> avatars = {
    'Male': 'assets/male_avatar.png',
    'Female': 'assets/female_avatar.png',
  };

  void calculateBMI() {
    double height = double.parse(heightController.text) / 100;
    double weight = double.parse(weightController.text);
    setState(() {
      bmi = weight / (height * height);
      if (bmi < 16.0) {
        bmiStatus = "Severe Thinness";
      } else if (bmi < 18.5) {
        bmiStatus = "Underweight";
      } else if (bmi < 25.0) {
        bmiStatus = "Normal";
      } else if (bmi < 30.0) {
        bmiStatus = "Overweight";
      } else {
        bmiStatus = "Obese";
      }
    });
  }

  void resetFields() {
    setState(() {
      heightController.clear();
      weightController.clear();
      gender = "Select Gender";
      bmi = 0;
      bmiStatus = "";
      avatar = "assets/question_mark.png";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "BMI Calculator",
          style: TextStyle(
            fontSize: 30.0,
            color: Colors.brown,
          ),
        ),
      ),
      body: Container(
        color: Colors.brown[50],
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // Height input field
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Height',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown,
                      ),
                    ),
                    const SizedBox(width: 16),
                    SizedBox(
                      width: 250,
                      child: TextField(
                        controller: heightController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          hintText: 'Enter Your Height (cm)',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Weight input field
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Weight',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown,
                      ),
                    ),
                    const SizedBox(width: 16),
                    SizedBox(
                      width: 250,
                      child: TextField(
                        controller: weightController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          hintText: 'Enter Your Weight (KG)',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25), // Space between fields

                // Gender selection dropdown and avatar
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: gender,
                        icon: const Icon(Icons.arrow_drop_down),
                        underline: Container(
                          height: 2,
                          color: Colors.brown,
                        ),
                        style: const TextStyle(
                          color: Colors.brown,
                          fontWeight: FontWeight.bold,
                        ),
                        items: <String>['Select Gender', 'Male', 'Female']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            gender = newValue!;
                            avatar = avatars.containsKey(gender)
                                ? avatars[gender]!
                                : "assets/question_mark.png"; // Set corresponding avatar
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 16), // Space between dropdown and avatar
                    CircleAvatar(
                      radius: 80, // Size of the avatar
                      backgroundImage: AssetImage(avatar),
                      backgroundColor: Colors.white,
                    ),
                  ],
                ),
                const SizedBox(height: 25), // Space between avatar and buttons

                // Calculate and reset buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: calculateBMI,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Icon(Icons.calculate_rounded),
                    ),
                    ElevatedButton(
                      onPressed: resetFields,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Icon(Icons.refresh),
                    ),
                  ],
                ),
                const SizedBox(height: 30), // Space before result

                // BMI result display
                Container(
                  width: double.infinity, // Make the container fill horizontally
                  padding: const EdgeInsets.all(24.0), // Increase padding for a bigger box
                  decoration: BoxDecoration(
                    color: Colors.white, // Set the background color to white
                    border: Border.all(color: Colors.brown),
                    borderRadius: BorderRadius.circular(12), // Slightly bigger border radius
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
                    children: <Widget>[
                      Center(
                        child: Text(
                          "The $gender Result",
                          style: const TextStyle(
                            fontSize: 24.0, // Increased font size
                            fontWeight: FontWeight.bold,
                            color: Colors.brown,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "BMI Calculated = ${bmi.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontSize: 22.0, // Increased font size
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "Current Status = $bmiStatus",
                        style: const TextStyle(
                          fontSize: 22.0, // Increased font size
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
