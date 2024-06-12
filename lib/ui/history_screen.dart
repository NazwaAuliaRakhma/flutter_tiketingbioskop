import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1D1D28),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 37, 37, 53),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('History', style: TextStyle(color: Colors.white)),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 16.0),
            child: Image.asset('assets/images/img_rectangle_67.png'),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 16.0),
            child: Image.asset('assets/images/img_rectangle_90.png'),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 16.0),
            child: Image.asset('assets/images/img_rectangle_67.png'),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF1A1A2E),
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Color(0xFFA1F7FF)), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.movie, color: Color(0xFFA1F7FF)),
              label: 'Ticket'),
          BottomNavigationBarItem(
              icon: Icon(Icons.history, color: Color(0xFFA1F7FF)),
              label: 'History'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person, color: Color(0xFFA1F7FF)),
              label: 'Profile'),
        ],
        currentIndex: 2, // Set the current index to History
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          _onItemTapped(context, index);
        },
      ),
    );
  }

  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/home');
        break;
      case 1:
        Navigator.pushNamed(context, '/tiket');
        break;
      case 2:
        // Already on HistoryScreen
        break;
      case 3:
        Navigator.pushNamed(context, '/profile');
        break;
    }
  }
}
