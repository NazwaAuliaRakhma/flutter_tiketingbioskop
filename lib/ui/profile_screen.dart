import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.black,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Row(
            children: <Widget>[
              CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage('assets/images/img_2.png'),
              ),
              SizedBox(width: 16.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Nazwa Aulia Rakhma',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'nazwa123@gmail.com',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 24.0),
          Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.movie,
                  color: Colors.white,
                  size: 40.0,
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child: Text(
                    "Let's Watch in Bioskop, Don't Watch Pirated Movies Guys!!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24.0),
          ListTile(
            leading: Icon(Icons.person, color: Colors.blue),
            title: Text(
              'Update Profile',
              style: TextStyle(color: Colors.white),
            ),
            trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
            tileColor: Colors.grey[900],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/updateProfile');
            },
          ),
          SizedBox(height: 16.0),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.blue),
            title: Text(
              'Log Out',
              style: TextStyle(color: Colors.white),
            ),
            trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
            tileColor: Colors.grey[900],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            onTap: () {
              // Handle Log Out tap
            },
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
        currentIndex: 3, // Set the current index to Profile
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
        Navigator.pushNamed(context, '/history');
        break;
      case 3:
        // Already on ProfileScreen
        break;
    }
  }
}
