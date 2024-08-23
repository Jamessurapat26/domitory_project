import 'package:flutter/material.dart';

class AddBillForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController rentController;
  final TextEditingController waterFeeController;
  final TextEditingController electricityFeeController;
  final TextEditingController otherFeesController;
  final TextEditingController dateController;
  final VoidCallback onSubmit;

  AddBillForm({
    required this.formKey,
    required this.rentController,
    required this.waterFeeController,
    required this.electricityFeeController,
    required this.otherFeesController,
    required this.dateController,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: formKey,
        child: ListView(
          children: [
            TextFormField(
              controller: rentController,
              decoration: InputDecoration(labelText: 'Rent'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter rent amount';
                }
                return null;
              },
            ),
            TextFormField(
              controller: waterFeeController,
              decoration: InputDecoration(labelText: 'Water Fee'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter water fee amount';
                }
                return null;
              },
            ),
            TextFormField(
              controller: electricityFeeController,
              decoration: InputDecoration(labelText: 'Electricity Fee'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter electricity fee amount';
                }
                return null;
              },
            ),
            TextFormField(
              controller: otherFeesController,
              decoration: InputDecoration(labelText: 'Other Fees'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter other fees amount';
                }
                return null;
              },
            ),
            TextFormField(
              controller: dateController,
              decoration: InputDecoration(labelText: 'Date (YYYY-MM-DD)'),
              keyboardType: TextInputType.datetime,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a date';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: onSubmit,
              child: Text('Add Bill'),
            ),
          ],
        ),
      ),
    );
  }
}
