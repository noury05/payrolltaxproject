import 'package:flutter/material.dart';

class HomePage2 extends StatelessWidget {
  final double grossSalary;
  final double totalTaxes;
  final double netSalary;

  const HomePage2({
    Key? key,
    required this.grossSalary,
    required this.totalTaxes,
    required this.netSalary,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Custom Header Section
          Container(
            width:800,
            color: Colors.teal,
            padding: const EdgeInsets.all(16),
            child: const Center(
              child: Text(
                'Comprehensive Tax and Salary Breakdown',
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
            child: Center( // Center the content in the middle of the screen
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // Center the column contents vertically
                crossAxisAlignment: CrossAxisAlignment.center,
                // Center the column contents horizontally
                children: [
                  const Text(
                    '---- Payroll Calculation Summary ----',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Gross Salary: \$${grossSalary.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Total Taxes: \$${totalTaxes.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Net Salary: \$${netSalary.toStringAsFixed(2)}',
                    style: const TextStyle( fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pop(); // Go back to the previous screen (HomePage)
                    },
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.navigate_before, // Arrow icon to go back
                          size: 50, // Size of the icon
                        ),
                        SizedBox(width: 10),
                        // Adds space between the icon and the text
                        Text('Return to Home Page'),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
