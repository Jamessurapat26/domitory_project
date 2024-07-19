import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Room List App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: RoomListScreen(),
    );
  }
}

class RoomListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // This would typically pop the current route
            // but since this is the home screen, we'll just print a message
            print('Back button pressed');
          },
        ),
        title: Text('', style: TextStyle(color: Colors.white)),
        actions: [
          Switch(
            value: true,
            onChanged: (value) {
              // Handle admin mode toggle
              print('Admin mode toggled: $value');
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
                // Handle search
                print('Searching for: $value');
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'อาคาร A',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Room',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 7,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.star_border),
                  title: Text('Room ${101 + index}'),
                  subtitle: Text('Menu description.'),
                  trailing: IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      // Handle add button press
                      print('Add pressed for Room ${101 + index}');
                    },
                  ),
                  onTap: () {
                    // Handle room selection
                    print('Room ${101 + index} selected');
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}