import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
        backgroundColor: Colors.black,
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
        backgroundColor: Colors.black,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/img_home.png',
                width: 24, height: 24),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/img_ticket.png',
                width: 24, height: 24),
            label: 'Ticket',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/img_history.png',
                width: 24, height: 24),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/img_users.png',
                width: 24, height: 24),
            label: 'Profile',
          ),
        ],
        currentIndex: 2, // Set the current index to History
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
        // Implement navigation to TicketScreen
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
