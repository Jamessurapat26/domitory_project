import 'package:flutter/material.dart';
import 'package:domitory_project/admin/room.dart';
import 'package:domitory_project/sign_in_screen.dart';

import 'bill_details_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dormitory',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SignInScreen(),
      routes: {
        '/billDetails': (context) => BillDetailsScreen(),
        '/roomList': (context) => RoomListScreen(),
      },
    );
  }
}

// class SignInScreen extends StatefulWidget {
//   @override
//   _SignInScreenState createState() => _SignInScreenState();
// }

// class _SignInScreenState extends State<SignInScreen> {
//   bool isAdmin = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 isAdmin ? 'Admin' : 'Dormitory',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 40,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 40),
//               Container(
//                 padding: EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text('Name'),
//                     TextField(
//                       decoration: InputDecoration(
//                         hintText: 'username',
//                       ),
//                     ),
//                     SizedBox(height: 20),
//                     Text('Password'),
//                     TextField(
//                       decoration: InputDecoration(
//                         hintText: 'password',
//                       ),
//                       obscureText: true,
//                     ),
//                     SizedBox(height: 20),
//                     Center(
//                       child: ElevatedButton(
//                         onPressed: () {
//                           if (isAdmin) {
//                             Navigator.pushNamed(context, '/roomList');
//                           } else {
//                             Navigator.pushNamed(context, '/billDetails');
//                           }
//                         },
//                         child: Text('Sign In'),
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.black,
//                           foregroundColor: Colors.white,
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 10),
//                     Center(
//                       child: TextButton(
//                         onPressed: () {},
//                         child: Text(
//                           'Forgot password?',
//                           style: TextStyle(color: Colors.blue),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 20),
//               ToggleButtons(
//                 isSelected: [!isAdmin, isAdmin],
//                 onPressed: (index) {
//                   setState(() {
//                     isAdmin = index == 1;
//                   });
//                 },
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                     child: Text('User', style: TextStyle(color: Colors.white)),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                     child: Text('Admin', style: TextStyle(color: Colors.white)),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class RoomListScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         title: Text('', style: TextStyle(color: Colors.white)),
//         actions: [
//           Switch(
//             value: true,
//             onChanged: (value) {
//               // Handle admin mode toggle
//               print('Admin mode toggled: $value');
//             },
//             activeColor: Colors.white,
//           ),
//           SizedBox(width: 8),
//           Center(
//             child: Text(
//               'Admin mode',
//               style: TextStyle(color: Colors.white),
//             ),
//           ),
//           SizedBox(width: 16),
//         ],
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: TextField(
//               decoration: InputDecoration(
//                 hintText: 'Search for a room',
//                 prefixIcon: Icon(Icons.search),
//                 filled: true,
//                 fillColor: Colors.white,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(30),
//                   borderSide: BorderSide.none,
//                 ),
//               ),
//               onChanged: (value) {
//                 // Handle search
//                 print('Searching for: $value');
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: Align(
//               alignment: Alignment.centerLeft,
//               child: Text(
//                 'อาคาร A',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: Align(
//               alignment: Alignment.centerLeft,
//               child: Text(
//                 'Room',
//                 style: TextStyle(fontSize: 16),
//               ),
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: 7,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   leading: Icon(Icons.star_border),
//                   title: Text('Room ${101 + index}'),
//                   subtitle: Text('Menu description.'),
//                   trailing: IconButton(
//                     icon: Icon(Icons.add),
//                     onPressed: () {
//                       // Handle add button press
//                       print('Add pressed for Room ${101 + index}');
//                     },
//                   ),
//                   onTap: () {
//                     // Handle room selection
//                     print('Room ${101 + index} selected');
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class BillDetailsScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         title: Text('Room 402'),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Center(
//               child: Text(
//                 'ค้างชำระ',
//                 style: TextStyle(color: Colors.white, fontSize: 18),
//               ),
//             ),
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Container(
//               padding: EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: Colors.black,
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Row(
//                 children: [
//                   CircleAvatar(
//                     radius: 30,
//                     backgroundImage: NetworkImage(
//                         'https://via.placeholder.com/150'), // Placeholder image
//                   ),
//                   SizedBox(width: 10),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Surapat Saetan',
//                         style: TextStyle(color: Colors.white, fontSize: 18),
//                       ),
//                       Text(
//                         '064-0577384',
//                         style: TextStyle(color: Colors.white, fontSize: 14),
//                       ),
//                     ],
//                   ),
//                   Spacer(),
//                   Icon(Icons.check_circle, color: Colors.white, size: 30),
//                 ],
//               ),
//             ),
//             SizedBox(height: 16),
//             Expanded(
//               child: ListView(
//                 children: [
//                   buildBillItem('ค่าน้ำ', '200.0'),
//                   buildBillItem('ค่าไฟ', '500.0'),
//                   buildBillItem('ค่าทิ้งขยะ', '30.0'),
//                   buildBillItem('ค่าห้อง', '4000.0'),
//                   buildBillItem('อื่นๆ', ''),
//                   SizedBox(height: 10),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       Text(
//                         'ยอดรวม',
//                         style: TextStyle(fontSize: 18, color: Colors.red),
//                       ),
//                       SizedBox(width: 10),
//                       Text(
//                         '5000',
//                         style: TextStyle(fontSize: 18, color: Colors.red),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () {},
//               child: Text('Pay Bills'),
//               style: ElevatedButton.styleFrom(
//                 padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(30),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildBillItem(String title, String amount) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 5.0),
//       child: Container(
//         padding: EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(10),
//           border: Border.all(color: Colors.grey.shade300),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               title,
//               style: TextStyle(fontSize: 16),
//             ),
//             Text(
//               amount,
//               style: TextStyle(fontSize: 16),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
