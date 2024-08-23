import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class RoomBillsScreen extends StatefulWidget {
  final int roomId;
  final String roomNumber;

  RoomBillsScreen({required this.roomId, required this.roomNumber});

  @override
  _RoomBillsScreenState createState() => _RoomBillsScreenState();
}

class _RoomBillsScreenState extends State<RoomBillsScreen> {
  List<Map<String, dynamic>> _bills = [];
  bool _isEditing = false;
  int? _editingBillId;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _rentController = TextEditingController();
  final TextEditingController _waterFeeController = TextEditingController();
  final TextEditingController _electricityFeeController =
      TextEditingController();
  final TextEditingController _otherFeesController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadBills(); // Load bills when the screen initializes
  }

  Future<void> _loadBills() async {
    final url =
        Uri.parse('http://192.168.100.129:3000/bills?room_id=${widget.roomId}');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          _bills = List<Map<String, dynamic>>.from(data);
        });
      } else {
        throw Exception('Failed to load bills');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _saveBill() async {
    if (_formKey.currentState?.validate() ?? false) {
      final url = _editingBillId != null
          ? Uri.parse('http://192.168.100.129:3000/bills/$_editingBillId')
          : Uri.parse('http://192.168.100.129:3000/bills');

      // Logging the request payload for debugging
      final payload = json.encode({
        'room_id': widget.roomId,
        'rent': double.parse(_rentController.text),
        'water_fee': double.parse(_waterFeeController.text),
        'electricity_fee': double.parse(_electricityFeeController.text),
        'other_fees': double.parse(_otherFeesController.text),
        'bill_status': 'Pending', // Default status for new bills
        'date': _dateController.text, // Assuming date is correctly formatted
        'pay': false, // Default pay status for new bills
      });

      print(
          'Sending ${_editingBillId != null ? "PUT" : "POST"} request to $url with payload: $payload');

      final response = await (_editingBillId != null
          ? http.put(url,
              headers: {'Content-Type': 'application/json'}, body: payload)
          : http.post(url,
              headers: {'Content-Type': 'application/json'}, body: payload));

      if (response.statusCode == 201 || response.statusCode == 200) {
        _loadBills(); // Reload bills after saving
        setState(() {
          _isEditing = false;
          _editingBillId = null;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Bill saved successfully')),
        );
      } else {
        // Logging response details for debugging
        print('Failed to save bill. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save bill')),
        );
      }
    }
  }

  Future<void> _confirmDeleteBill(int billId) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Bill'),
          content: Text('Are you sure you want to delete this bill?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      _deleteBill(billId);
    }
  }

  Future<void> _deleteBill(int billId) async {
    final url = Uri.parse('http://192.168.100.129:3000/bills/$billId');
    final response = await http.delete(url);

    if (response.statusCode == 200) {
      _loadBills(); // Reload bills after deleting
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Bill deleted successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete bill')),
      );
    }
  }

  @override
  void dispose() {
    _rentController.dispose();
    _waterFeeController.dispose();
    _electricityFeeController.dispose();
    _otherFeesController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bills for Room ${widget.roomNumber}'),
        backgroundColor: Colors.black,
      ),
      body: _isEditing ? _buildAddEditForm() : _buildBillList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _isEditing = !_isEditing;
            _editingBillId = null;
            _clearFormFields();
          });
        },
        child: Icon(_isEditing ? Icons.cancel : Icons.add),
        backgroundColor: Colors.black,
      ),
    );
  }

  Widget _buildAddEditForm() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _rentController,
              decoration: InputDecoration(labelText: 'Rent'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter rent';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _waterFeeController,
              decoration: InputDecoration(labelText: 'Water Fee'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter water fee';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _electricityFeeController,
              decoration: InputDecoration(labelText: 'Electricity Fee'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter electricity fee';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _otherFeesController,
              decoration: InputDecoration(labelText: 'Other Fees'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter other fees';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _dateController,
              decoration: InputDecoration(labelText: 'Date (YYYY-MM-DD)'),
              keyboardType: TextInputType.datetime,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a date';
                }
                return null;
              },
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );

                if (pickedDate != null) {
                  setState(() {
                    _dateController.text =
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                  });
                }
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _saveBill,
              child: Text(_editingBillId != null ? 'Save Changes' : 'Add Bill'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBillList() {
    return _bills.isNotEmpty
        ? ListView.builder(
            itemCount: _bills.length,
            itemBuilder: (context, index) {
              final bill = _bills[index];
              return ListTile(
                title: Text('Bill ID: ${bill['bill_id']}'),
                subtitle: Text(
                    'Rent: ${bill['rent']} \nWater: ${bill['water_fee']} \nElectricity: ${bill['electricity_fee']} \nOther Fees: ${bill['other_fees']} \nDate: ${_formatDateForDisplay(bill['date'])}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.blue),
                      onPressed: () {
                        setState(() {
                          _isEditing = true;
                          _editingBillId = bill['bill_id'];
                          _rentController.text = bill['rent'].toString();
                          _waterFeeController.text =
                              bill['water_fee'].toString();
                          _electricityFeeController.text =
                              bill['electricity_fee'].toString();
                          _otherFeesController.text =
                              bill['other_fees'].toString();
                          _dateController.text =
                              _formatDateForDisplay(bill['date']);
                        });
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        _confirmDeleteBill(bill['bill_id']);
                      },
                    ),
                  ],
                ),
                onTap: () {
                  print('Bill ${bill['bill_id']} selected');
                },
              );
            },
          )
        : Center(
            child: Text(
              'No bills found',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          );
  }

  String _formatDateForDisplay(String dateString) {
    try {
      final dateTime = DateTime.parse(dateString);
      return DateFormat('yyyy-MM-dd').format(dateTime);
    } catch (e) {
      return dateString;
    }
  }

  void _clearFormFields() {
    _rentController.clear();
    _waterFeeController.clear();
    _electricityFeeController.clear();
    _otherFeesController.clear();
    _dateController.clear();
  }
}
