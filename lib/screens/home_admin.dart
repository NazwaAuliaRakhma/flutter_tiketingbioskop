import 'package:flutter/material.dart';
import 'edit_movie.dart';

class MovieScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF1A1A1A),
        elevation: 0,
        title: Text(
          'MOVIE',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Colors.white),
            onPressed: () {
              Navigator.pushNamed(context, '/add_movie');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            movieCard(
              context,
              'KKN Di Desa Penari',
              'STUDIO 1',
              'Horror',
              '1j 30m',
              '44',
              '40.000',
              '13:30',
              '15:00',
              '16:30',
              '18:00',
              'KKN Desa Penari merupakan sebuah film horor yang diangkat dari kisah nyata enam mahasiswa.',
              '28.06.2024',
              'assets/images/img_rectangle_67.png',
            ),
            movieCard(
              context,
              'THE DOLL 3',
              'STUDIO 2',
              'Horror',
              '1j 40m',
              '50',
              '45.000',
              '15:30',
              '18:00',
              '19:30',
              '21:00',
              'The Doll 3 adalah film horor yang menceritakan kisah boneka berhantu.',
              '29.06.2024',
              'assets/images/img_rectangle_70.png',
            ),
            movieCard(
              context,
              'TELUH',
              'STUDIO 3',
              'Horror',
              '1j 35m',
              '48',
              '42.000',
              '14:00',
              '15:30',
              '17:00',
              '18:30',
              'Teluh adalah film yang mengisahkan tentang kutukan yang menyerang sebuah keluarga.',
              '30.06.2024',
              'assets/images/img_rectangle_73.png',
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF1A1A1A),
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.movie),
            label: 'Movie',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          if (index == 1) {
            Navigator.pushNamed(context, '/user_data');
          }
        },
      ),
    );
  }

  Widget movieCard(
      BuildContext context,
      String title,
      String studio,
      String genre,
      String duration,
      String tickets,
      String price,
      String time1,
      String time2,
      String time3,
      String time4,
      String description,
      String date,
      String imagePath) {
    return Card(
      color: Color(0xFF2C2C2C),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  imagePath,
                  width: 100,
                  height: 150,
                  fit: BoxFit.cover,
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        description,
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(height: 16),
                      Text(
                        studio,
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(height: 8),
                      Text(
                        date,
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.white),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditMovieScreen(
                          title: title,
                          studio: studio,
                          genre: genre,
                          duration: duration,
                          tickets: tickets,
                          price: price,
                          time1: time1,
                          time2: time2,
                          time3: time3,
                          time4: time4,
                          description: description,
                          date: date,
                          imagePath: imagePath,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                movieInfo('Genre', genre, Icons.movie),
                movieInfo('Duration', duration, Icons.timer),
                movieInfo('Ticket', tickets, Icons.event_seat),
                movieInfo('Price', price, Icons.attach_money),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                showtimeButton(time1),
                showtimeButton(time2),
                showtimeButton(time3),
                showtimeButton(time4),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget movieInfo(String title, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.white),
        SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 12),
        ),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(color: Colors.white, fontSize: 12),
        ),
      ],
    );
  }

  Widget showtimeButton(String time) {
    return ElevatedButton(
      onPressed: () {
        // Action saat tombol showtime ditekan
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      child: Text(time),
    );
  }
}

                       