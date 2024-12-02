import 'package:flutter/material.dart';
import 'home_page2.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _baseSalaryController = TextEditingController();
  final TextEditingController _taxRateController = TextEditingController();
  final TextEditingController _socialSecurityRateController = TextEditingController();
  final TextEditingController _healthInsuranceController = TextEditingController();
  final TextEditingController _overtimeHoursController = TextEditingController();
  final TextEditingController _overtimeRateController = TextEditingController();

  double grossSalary = 0.0;
  double totalTaxes = 0.0;
  double netSalary = 0.0;
  double overtimePay = 0.0;
  String message = "";

  // Calculate the gross salary, taxes, and net salary
  void calculate() {
    // Retrieving user inputs and parsing them as doubles
    final double baseSalary = double.tryParse(_baseSalaryController.text) ?? 0.0;
    final double taxRate = double.tryParse(_taxRateController.text) ?? 0.0;
    final double socialSecurityRate = double.tryParse(_socialSecurityRateController.text) ?? 0.0;
    final double healthInsurance = double.tryParse(_healthInsuranceController.text) ?? 0.0;
    final double overtimeHours = double.tryParse(_overtimeHoursController.text) ?? 0.0;
    final double overtimeRate = double.tryParse(_overtimeRateController.text) ?? 0.0;

    // Check if base salary is entered, and show a message if not
    setState(() {
      if (baseSalary == 0.0) {
        message = "Please enter a valid salary.";
        grossSalary = 0.0;
        totalTaxes = 0.0;
        netSalary = 0.0;
        overtimePay = 0.0;
      } else {
        // Calculations based on the input values
        overtimePay = overtimeHours * overtimeRate;
        grossSalary = baseSalary + overtimePay;

        final double federalTax = grossSalary * (taxRate / 100);
        final double stateTax = grossSalary * 0.05; // Assuming 5% state tax
        final double socialSecurity = grossSalary * (socialSecurityRate / 100);

        totalTaxes = federalTax + stateTax + socialSecurity + healthInsurance;
        netSalary = grossSalary - totalTaxes;
        message = ""; // Clear any previous error messages
      }
    });

    // Navigate to HomePage2 with the calculated values
    if (grossSalary > 0.0) {
      print("Gross Salary: $grossSalary, Total Taxes: $totalTaxes, Net Salary: $netSalary");

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage2(
            grossSalary: grossSalary,
            totalTaxes: totalTaxes,
            netSalary: netSalary,
          ),
        ),
      );
    }
  }

  // Reset the form and clear all input fields
  void reset() {
    setState(() {
      _baseSalaryController.clear();
      _taxRateController.clear();
      _socialSecurityRateController.clear();
      _healthInsuranceController.clear();
      _overtimeHoursController.clear();
      _overtimeRateController.clear();
      grossSalary = 0.0;
      totalTaxes = 0.0;
      netSalary = 0.0;
      overtimePay = 0.0;
      message = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Vertically center the children
          children: [
            // Header Section
            Container(
              width: 800,
              color: Colors.teal,
              padding: const EdgeInsets.all(16),
              child: const Center(
                child: Text(
                  'Payroll Tax Calculator',
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            // Main Content Section
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Input Fields
                      buildInputField(_baseSalaryController, 'Base Salary (\$)'),
                      buildInputField(_taxRateController, 'Tax Rate (%)'),
                      buildInputField(_socialSecurityRateController, 'Social Security Rate (%)'),
                      buildInputField(_healthInsuranceController, 'Health Insurance (\$)'),
                      buildInputField(_overtimeHoursController, 'Overtime Hours Worked'),
                      buildInputField(_overtimeRateController, 'Overtime Rate (\$ per hour)'),
                      const SizedBox(height: 20),

                      // Calculate Button
                      ElevatedButton(
                        onPressed: calculate,
                        child: const Text('Calculate'),
                      ),
                      const SizedBox(height: 20),

                      // Output Section
                      if (message.isNotEmpty)
                        Text(
                          message,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal,
                          ),
                        ),
                      const SizedBox(height: 20),

                      // Reset Button
                      ElevatedButton(
                        onPressed: reset,
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                        child: const Text('Reset'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build input fields with consistent width
  Widget buildInputField(TextEditingController controller, String label) {
    return Column(
      children: [
        SizedBox(
          width: 800,
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: label,
              border: const OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
