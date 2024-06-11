import 'package:flutter/material.dart';
import 'select_seat.dart';

class RomanceScreen extends StatelessWidget {
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
        title: Text('Romance', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            MovieCard(
              imageUrl:
                  'https://upload.wikimedia.org/wikipedia/id/b/bb/Poster_film_Garis_Waktu.jpg', // Example image URL
              title: 'Garis Waktu',
              description:
                  'Garis Waktu menceritakan tentang seorang musikus cafe yang hidup sebatang kara bernama Sena. Suatu hari dia bertemu dengan putri bangsawan kaya raya bernama April. Sena jatuh cinta dengan April dan mencoba menjalin hubungan, tetapi terhalang oleh restu orang tua.',
            ),
            SizedBox(height: 20),
            MovieCard(
              imageUrl: 'assets/images/img_rectangle_86.png',
              title: 'My Sassy Girl',
              description:
                  'Gian seharusnya pergi ke rumah tantenya karena sang tante ingin menjodohkan Gian dengan mantan kekasih almarhum anaknya.',
            ),
          ],
        ),
      ),
    );
  }
}

class MovieCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;

  const MovieCard({
    required this.imageUrl,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Image.network(
            imageUrl,
            width: 100,
            height: 150,
            fit: BoxFit.cover,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(height: 5),
                Text(
                  description,
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReservationApp(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(primary: Colors.lightBlue),
                  child: Text('Pay Ticket'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
