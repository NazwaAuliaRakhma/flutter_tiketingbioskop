import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/images/img_2.png'),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hi!', style: TextStyle(fontSize: 18)),
            Text('Nazwa Aulia Rakhma', style: TextStyle(fontSize: 22)),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search Film',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text('Genre',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildGenreButton('Romance', Icons.favorite),
                _buildGenreButton('Horror', Icons.emoji_emotions),
                _buildGenreButton('Family', Icons.family_restroom),
                _buildGenreButton('Action', Icons.local_activity),
              ],
            ),
            SizedBox(height: 20),
            Text('Now Playing',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            _buildMovieList('Now Playing'),
            SizedBox(height: 20),
            Text('Popular',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            _buildMovieList('Popular'),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        currentIndex: _currentIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          if (index == 2) {
            Navigator.pushNamed(context, '/history');
          } else if (index == 3) {
            Navigator.pushNamed(context, '/profile');
          }
        },
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
      ),
    );
  }

  Widget _buildGenreButton(String title, IconData icon) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          child: Icon(icon, size: 30),
        ),
        SizedBox(height: 8),
        Text(title),
      ],
    );
  }

  Widget _buildMovieList(String section) {
    List<Map<String, String>> movies = [
      {
        'title': 'Doctor Strange',
        'image': 'assets/images/img_rectangle_64.png',
      },
      {
        'title': 'KKN Di Desa Penari',
        'image': 'assets/images/img_rectangle_67.png',
      },
      {
        'title': 'My Sassy Girl',
        'image': 'assets/images/img_rectangle_86.png',
      },
    ];

    if (section == 'Popular') {
      movies = [
        {
          'title': 'Ngeri-Ngeri Sedap',
          'image': 'assets/images/img_rectangle_61.png',
        },
        {
          'title': 'Teluh',
          'image': 'assets/images/img_rectangle_62.png',
        },
        {
          'title': 'The Doll 3',
          'image': 'assets/images/img_rectangle_70.png',
        },
      ];
    }

    return SizedBox(
      height: 180,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: movies.map((movie) {
          return _buildMovieItem(movie['title']!, movie['image']!);
        }).toList(),
      ),
    );
  }

  Widget _buildMovieItem(String title, String imageUrl) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Image.asset(
            imageUrl,
            width: 120,
            height: 140,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 8),
          Text(title, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
