import 'package:flutter/material.dart';

class MovieDetailScreen extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String genre;
  final String duration;
  final double rating;
  final String synopsis;

  const MovieDetailScreen({
    Key? key,
    required this.title,
    required this.imageUrl,
    required this.genre,
    required this.duration,
    required this.rating,
    required this.synopsis,
  }) : super(key: key);

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
        title: Text('Movie Details', style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  imageUrl,
                  height: 300,
                ),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildDetailIcon(Icons.category, genre),
                _buildDetailIcon(Icons.access_time, duration),
                _buildDetailIcon(Icons.star, rating.toString()),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Synopsis',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              synopsis,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/select');
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Reservation',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailIcon(IconData icon, String text) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 30),
        SizedBox(height: 5),
        Text(text, style: TextStyle(color: Colors.white, fontSize: 16)),
      ],
    );
  }
}
