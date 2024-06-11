import 'package:flutter/material.dart';

class UserDataScreen extends StatelessWidget {
  final List<User> users = [
    User(
        name: 'Nazwa Aulia Rakhma',
        email: 'nazwa@gmail.com',
        username: 'nazwa21102015'),
    User(
        name: 'Lala Hikmatul Maula',
        email: 'lala@gmail.com',
        username: 'lala21102200'),
    User(
        name: 'Abdul Jabbar Robbani',
        email: 'abdul@gmail.com',
        username: 'abdul21102310'),
    User(
        name: 'Fifi Alfiaturrohmah',
        email: 'fifi@gmail.com',
        username: 'fifi21102097'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF1A1A1A),
        elevation: 0,
        title: Text(
          'User Data',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: users.length,
        itemBuilder: (context, index) {
          return userCard(users[index]);
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF1A1A1A),
        selectedItemColor: Colors.lightBlueAccent,
        unselectedItemColor: Colors.grey,
        currentIndex:
            1, // Set the index of the selected item (0: Movie, 1: User)
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.movie),
            label: 'Movie',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'User',
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, '/movie'); // Navigate to MovieScreen
          }
        },
      ),
    );
  }

  Widget userCard(User user) {
    return Card(
      color: Color(0xFF2C2C2C),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.grey,
              child: Icon(Icons.person, color: Colors.white, size: 30),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    user.email,
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(
                    user.username,
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class User {
  final String name;
  final String email;
  final String username;

  User({required this.name, required this.email, required this.username});
}
