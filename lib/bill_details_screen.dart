import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BillDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final int roomId = args['roomId'];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Room $roomId Details'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                'ค้างชำระ',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: _fetchBillDetails(roomId),
        builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('No billing data available.'));
          }

          final billDetails = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                          'https://via.placeholder.com/150',
                        ),
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Room $roomId',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          Text(
                            'Bill ID: ${billDetails['bill_id']}',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ],
                      ),
                      Spacer(),
                      Icon(
                        billDetails['pay'] == 1
                            ? Icons.check_circle
                            : Icons.warning,
                        color: Colors.white,
                        size: 30,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Expanded(
                  child: ListView(
                    children: [
                      buildBillItem('Rent', billDetails['rent'].toString()),
                      buildBillItem(
                          'Water Fee', billDetails['water_fee'].toString()),
                      buildBillItem('Electricity Fee',
                          billDetails['electricity_fee'].toString()),
                      buildBillItem(
                          'Other Fees', billDetails['other_fees'].toString()),
                      buildBillItem('Date', billDetails['date'].toString()),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Total',
                            style: TextStyle(fontSize: 18, color: Colors.red),
                          ),
                          SizedBox(width: 10),
                          Text(
                            calculateTotal(billDetails).toString(),
                            style: TextStyle(fontSize: 18, color: Colors.red),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    _payBill(billDetails['bill_id']);
                  },
                  child: Text('Pay Bills'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<Map<String, dynamic>> _fetchBillDetails(int roomId) async {
    final url = Uri.parse('http://192.168.100.129:3000/bills/latest/$roomId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return {
        'bill_id': data['bill_id'],
        'rent': double.tryParse(data['rent'].toString()) ?? 0.0,
        'water_fee': double.tryParse(data['water_fee'].toString()) ?? 0.0,
        'electricity_fee':
            double.tryParse(data['electricity_fee'].toString()) ?? 0.0,
        'other_fees': double.tryParse(data['other_fees'].toString()) ?? 0.0,
        'bill_status': data['bill_status'],
        'date': data['date'],
        'pay': data['pay'],
      };
    } else {
      throw Exception('Failed to load billing details');
    }
  }

  double calculateTotal(Map<String, dynamic> billDetails) {
    return (billDetails['rent'] ?? 0.0) +
        (billDetails['water_fee'] ?? 0.0) +
        (billDetails['electricity_fee'] ?? 0.0) +
        (billDetails['other_fees'] ?? 0.0);
  }

  Widget buildBillItem(String title, String amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 16),
            ),
            Text(
              amount,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _payBill(int billId) async {
    final url = Uri.parse('http://192.168.100.129:3000/bills/pay/$billId');
    final response = await http.put(url, body: json.encode({'pay': 1}));

    if (response.statusCode == 200) {
      print('Bill paid successfully');
    } else {
      print('Failed to pay the bill');
    }
  }
}
