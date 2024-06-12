import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nazwa_tiketing/ui/romance_screen.dart';
import 'package:nazwa_tiketing/ui/horror_screen.dart';
import 'package:nazwa_tiketing/ui/action_screen.dart';
import 'package:nazwa_tiketing/ui/family_screen.dart';
import 'package:nazwa_tiketing/ui/tiket_screen.dart';
import 'movie_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  String _username = '';

  Future<void> _getUsername() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .get();
      if (doc.exists) {
        setState(() {
          _username = doc['username'];
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _getUsername(); // Panggil _getUsername saat initState
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1D1D28),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 37, 37, 53),
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/images/avatar.png'),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hi!', style: TextStyle(fontSize: 18, color: Colors.white)),
            Text('$_username',
                style: TextStyle(fontSize: 22, color: Colors.white)),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search, color: Colors.white),
                hintText: 'Search Film',
                hintStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text('Genre',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildGenreButton('Romance', Icons.favorite, RomanceScreen()),
                _buildGenreButton(
                    'Horror', Icons.emoji_emotions, HorrorScreen()),
                _buildGenreButton(
                    'Family', Icons.family_restroom, FamilyScreen()),
                _buildGenreButton(
                    'Action', Icons.local_activity, ActionScreen()),
              ],
            ),
            SizedBox(height: 15),
            Text('Now Playing',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            SizedBox(height: 10),
            _buildMovieList('Now Playing'),
            SizedBox(height: 15),
            Text('Popular',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            SizedBox(height: 10),
            _buildMovieList('Popular'),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromRGBO(26, 26, 63, 1.0),
        currentIndex: _currentIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TicketScreen()),
            );
          } else if (index == 2) {
            Navigator.pushNamed(context, '/history');
          } else if (index == 3) {
            Navigator.pushNamed(context, '/profile');
          }
        },
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
      ),
    );
  }

  Widget _buildGenreButton(String title, IconData icon, Widget screen) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        );
      },
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            child: Icon(icon, size: 30),
          ),
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(color: Colors.white), // Warna teks putih
          ),
        ],
      ),
    );
  }

  Widget _buildMovieList(String section) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('movies').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(
              child: Text('No movies available',
                  style: TextStyle(color: Colors.white)));
        }

        final movies = snapshot.data!.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();

        return SizedBox(
          height: 200,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: movies.map((movie) {
              return _buildMovieItem(
                movie['movie_name'],
                movie['cover_movie'],
                movie['genre'],
                movie['price'],
                8.0, // Nilai rating tetap
                movie['movie_description'],
              );
            }).toList(),
          ),
        );
      },
    );
  }

  Widget _buildMovieItem(String title, String imageUrl, String genre,
      String duration, double rating, String synopsis) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MovieDetailScreen(
                title: title,
                imageUrl: imageUrl,
                genre: genre,
                duration: duration,
                rating: rating,
                synopsis: synopsis,
              ),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(imageUrl, width: 120, height: 140, fit: BoxFit.cover),
            SizedBox(height: 5),
            Text(
              title,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
