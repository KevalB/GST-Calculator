import 'package:flutter/material.dart';

/* GST Calculater by Keval Behera */

// Stateful widget since we are updating values
class GST_Screen extends StatefulWidget {
  const GST_Screen({super.key});

  @override
  State<GST_Screen> createState() => _GST_ScreenState();
}

class _GST_ScreenState extends State<GST_Screen> {
  TextEditingController mainAmount = TextEditingController();
  TextEditingController gstPer = TextEditingController();

// Variable declaration
  double gstPercentage = 0.0;
  double igst = 0.0;
  double cgst = 0.0;
  double sgst = 0.0;
  double totalAmount = 0.0;
  double actualAmount = 0.0;

// Function to calculate GST where actual amount = input amount
  void calculateGST() {
    setState(() {
      igst = (actualAmount * gstPercentage) / 100;
      cgst = igst / 2;
      sgst = igst / 2;
      totalAmount =
          actualAmount + igst; // Total is actual amount + sum of two gsts
    });
  }

// Function to calculate reverse GST
  void calculateRGST() {
    setState(() {
      totalAmount = double.parse(mainAmount.text);
      actualAmount = ((double.parse(mainAmount.text) /
          (1 +
              (double.parse(gstPer.text) *
                  0.01)))); // GST formula to calculate actual amount from total amount(main amount)

      igst = double.parse(mainAmount.text) -
          actualAmount; // Total gst means actual amount cut from total amount
      cgst = igst / 2;
      sgst = igst / 2;
    });
  }

// Button to reset textfield values
  void resetButton() {
    setState(() {
      mainAmount.text = '';
      gstPer.text = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GST Calculator'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                    child: TextField(
                  controller: mainAmount,
                  decoration: InputDecoration(
                      labelText: 'Amount', border: OutlineInputBorder()),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      actualAmount = double.tryParse(value) ??
                          0.0; // to take input as double from the textfield
                    });
                  },
                )),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: TextField(
                  controller: gstPer,
                  decoration: InputDecoration(
                      labelText: 'GST percentage',
                      border: OutlineInputBorder()),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      gstPercentage = double.tryParse(value) ??
                          0.0; // to take input as double from textfield
                    });
                  },
                )),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              calculateGST(); //calling of function
              setState(() {}); //to update
            },
            child: Text('Calculate GST'),
          ),
          ElevatedButton(
            onPressed: () {
              calculateRGST(); //calling of function
              setState(() {}); //to update
            },
            child: Text('Calculate Reverse GST'),
          ),
          //Results
          Text(
            'IGST Amount: $igst',
            style: TextStyle(fontSize: 20),
          ),
          Text(
            'CGST Amount: $cgst',
            style: TextStyle(fontSize: 20),
          ),
          Text(
            'SGST Amount: $sgst',
            style: TextStyle(fontSize: 20),
          ),
          Text(
            'Total Amount: $totalAmount',
            style: TextStyle(fontSize: 20),
          ),
          Text(
            'Actual Amount: $actualAmount',
            style: TextStyle(fontSize: 20),
          ),
          IconButton(
              onPressed: () {
                resetButton();
                setState(() {});
              },
              icon: Icon(Icons.refresh)),
        ],
      ),
    );
  }
}
