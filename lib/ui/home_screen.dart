import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nazwa_tiketing/ui/romance_screen.dart';
import 'package:nazwa_tiketing/ui/horror_screen.dart';
import 'package:nazwa_tiketing/ui/action_screen.dart';
import 'package:nazwa_tiketing/ui/family_screen.dart';
import 'package:nazwa_tiketing/ui/tiket_screen.dart';
import 'movie_detail_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';

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
            backgroundImage: NetworkImage('assets/images/avatar.png'),
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
            SizedBox(height: 20),
            Text('Now Playing',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            SizedBox(height: 10),
            _buildMovieList('Now Playing'),
            SizedBox(height: 20),
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
    List<Map<String, String>> movies = [
      {
        'title': 'Doctor Strange',
        'image': 'assets/images/img_rectangle_64.png',
        'genre': 'Action',
        'duration': '2h 6m',
        'rating': '8.5',
        'synopsis':
            'Doctor Strange adalah sebuah film pahlawan super Amerika yang menampilkan karakter Marvel Comics dengan nama yang sama, diproduksi oleh Marvel Studios dan didistribusikan oleh Walt Disney Motion Pictures. Film ini merupakan film keempat belas dari Marvel Cinematic Universe (MCU).'
      },
      {
        'title': 'KKN Di Desa Penari',
        'image': 'assets/images/img_rectangle_67.png',
        'genre': 'Horror',
        'duration': '1h 50m',
        'rating': '9.8',
        'synopsis':
            'KKN Di Desa Penari diadaptasi dari salah satu cerita horror yang telah viral di tahun 2019 melalui Twitter, menurut sang penulis, cerita ini diambil dari sebuah kisah nyata sekelompok mahasiswa yang tengah melakukan program KKN (Kuliah Kerja Nyata) di Desa Penari. Tak berjalan mulus, serentetan pengalaman horror pun menghantui mereka hingga program KKN tersebut berakhir tragis.'
      },
      {
        'title': 'My Sassy Girl',
        'image': 'assets/images/img_rectangle_86.png',
        'genre': 'Romance',
        'duration': '2h 3m',
        'rating': '8.0',
        'synopsis':
            'Gian seharusnya pergi ke rumah tantenya karena sang tante ingin menjodohkan Gian dengan mantan kekasih almarhum anaknya. Namun sejak di stasiun hingga di dalam gerbong kereta, Gian terjebak dalam situasi harus mengurus gadis mabuk bernama Sisi hingga harus membawanya ke hotel.'
      },
    ];

    if (section == 'Popular') {
      movies = [
        {
          'title': 'Keluarga Cemara 2',
          'image': 'assets/images/img_rectangle_90.png',
          'genre': 'Family',
          'duration': '2h 1m',
          'rating': '7.8',
          'synopsis':
              'Setelah jatuh miskin, Emak dan Abah bertahan hidup di desa. Ingin sejahtera, tapi lupa dengan kebahagiaan anak-anaknya. Abah sibuk dengan pekerjaan barunya, tak bisa tiap hari antar jemput anak-anaknya. Emak mencari sampingan agar keluarganya punya pendapatan tambahan dan juga tabungan.'
        },
        {
          'title': 'Teluh',
          'image': 'assets/images/img_rectangle_62.png',
          'genre': 'Horror',
          'duration': '1h 45m',
          'rating': '8.2',
          'synopsis':
              'Film horor Indonesia tahun 2022 ini berkisah tentang teror yang muncul setelah pembunuhan misterius terhadap Yulia, karyawati dan selingkuhan direktur perusahaan batik. Setelah kematiannya yang dianggap sebagai bunuh diri, keluarga direktur tersebut mulai mengalami kejadian aneh dan mistis yang dihubungkan dengan kiriman teluh, atau kutukan dalam tradisi Jawa.'
        },
        {
          'title': 'The Doll 3',
          'image': 'assets/images/img_rectangle_70.png',
          'genre': 'Horror',
          'duration': '1h 42m',
          'rating': '8.5',
          'synopsis':
              'Sebagai bagian dari trilogi film The Doll, film horor Indonesia tahun 2022 ini mengisahkan Tara, yang setelah kehilangan kedua orang tuanya dalam kecelakaan, harus menghadapi kematian adiknya, Gian. Dalam upaya untuk menghidupkan kembali adiknya, Tara meminta seorang dukun untuk memanggil arwah Gian ke dalam sebuah boneka bernama Bobby. Namun, boneka tersebut mulai menunjukkan perilaku yang mengancam nyawa orang-orang disekitar Tara.'
        },
      ];
    }

    return SizedBox(
      height: 180,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: movies.map((movie) {
          return _buildMovieItem(
            movie['title']!,
            movie['image']!,
            movie['genre']!,
            movie['duration']!,
            double.parse(movie['rating']!),
            movie['synopsis']!,
          );
        }).toList(),
      ),
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
