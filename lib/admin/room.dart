import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'room_bills_screen.dart'; // Import the RoomBillsScreen

class RoomListScreen extends StatefulWidget {
  @override
  _RoomListScreenState createState() => _RoomListScreenState();
}

class _RoomListScreenState extends State<RoomListScreen> {
  bool _isAdminMode = false;
  List<Map<String, dynamic>> _rooms = [];
  List<Map<String, dynamic>> _filteredRooms = [];

  @override
  void initState() {
    super.initState();
    _loadRooms();
  }

  Future<void> _loadRooms() async {
    final url = Uri.parse('http://192.168.100.129:3000/rooms');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          _rooms = List<Map<String, dynamic>>.from(data);
          _filteredRooms = _rooms;
        });
      } else {
        throw Exception('Failed to load rooms');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void _filterRooms(String query) {
    final filtered = _rooms
        .where((room) => room['room_number']
            .toString()
            .toLowerCase()
            .contains(query.toLowerCase()))
        .toList();
    setState(() {
      _filteredRooms = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          _isAdminMode ? 'Admin Room List' : 'Room List',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          Switch(
            value: _isAdminMode,
            onChanged: (value) {
              setState(() {
                _isAdminMode = value;
              });
              print('Admin mode toggled: $_isAdminMode');
            },
            activeColor: Colors.white,
          ),
          SizedBox(width: 8),
          Center(
            child: Text(
              'Admin mode',
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(width: 16),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search for a room',
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                _filterRooms(value);
                print('Searching for: $value');
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'อาคาร A', // Thai for "Building A"
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: _filteredRooms.isNotEmpty
                ? ListView.builder(
                    itemCount: _filteredRooms.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Icon(Icons.meeting_room, color: Colors.blue),
                        title: Text(_filteredRooms[index]['room_number']),
                        trailing: _isAdminMode
                            ? IconButton(
                                icon: Icon(Icons.edit, color: Colors.red),
                                onPressed: () {
                                  print(
                                      'Edit pressed for ${_filteredRooms[index]['room_number']}');
                                },
                              )
                            : null,
                        onTap: () {
                          // Navigate to RoomBillsScreen and pass the room ID and room number
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RoomBillsScreen(
                                roomId: _filteredRooms[index]['room_id'],
                                roomNumber: _filteredRooms[index]
                                    ['room_number'],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  )
                : Center(
                    child: Text(
                      'No rooms found',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
