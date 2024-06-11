import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('movies').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }

            var movies = snapshot.data!.docs;

            return ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                var movie = movies[index];

                return movieCard(
                  context,
                  movie['movie_name'],
                  'STUDIO ${movie['studio']}',
                  movie['genre'],
                  '1j 30m', // Durasi bisa diperbarui dengan data sebenarnya jika tersedia
                  '44', // Jumlah tiket bisa diperbarui dengan data sebenarnya jika tersedia
                  movie['price'],
                  '13:30', // Waktu tayang bisa diperbarui dengan data sebenarnya jika tersedia
                  '15:00',
                  '16:30',
                  '18:00',
                  movie['movie_description'],
                  movie['release_date'] ??
                      'Tanggal tidak tersedia', // Tanggal rilis
                  movie['cover_movie'],
                  movie.id, // id film untuk penghapusan
                );
              },
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF1A1A1A),
        selectedItemColor: Color(0xFFA1F7FF),
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
    String imagePath,
    String movieId, // id film untuk penghapusan
  ) {
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
                Image.network(
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
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.white),
                  onPressed: () {
                    _showDeleteConfirmationDialog(context, movieId);
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

  void _showDeleteConfirmationDialog(BuildContext context, String movieId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Konfirmasi"),
          content: Text("Anda yakin ingin menghapus film ini?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
              },
              child: Text("Batal"),
            ),
            TextButton(
              onPressed: () {
                _deleteMovie(
                    context, movieId); // Hapus film jika konfirmasi diizinkan
                Navigator.of(context).pop(); // Tutup dialog
              },
              child: Text("Hapus"),
            ),
          ],
        );
      },
    );
  }

  void _deleteMovie(BuildContext context, String movieId) async {
    try {
      await FirebaseFirestore.instance
          .collection('movies')
          .doc(movieId)
          .delete();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Film berhasil dihapus"),
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Gagal menghapus film: $e"),
      ));
    }
  }
}

void main() {
  runApp(MaterialApp(
    home: MovieScreen(),
  ));
}
