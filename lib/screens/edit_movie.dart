import 'package:flutter/material.dart';

class EditMovieScreen extends StatefulWidget {
  final String title;
  final String studio;
  final String genre;
  final String duration;
  final String tickets;
  final String price;
  final String time1;
  final String time2;
  final String time3;
  final String time4;
  final String description;
  final String date;
  final String imagePath;

  EditMovieScreen({
    required this.title,
    required this.studio,
    required this.genre,
    required this.duration,
    required this.tickets,
    required this.price,
    required this.time1,
    required this.time2,
    required this.time3,
    required this.time4,
    required this.description,
    required this.date,
    required this.imagePath,
  });

  @override
  _EditMovieScreenState createState() => _EditMovieScreenState();
}

class _EditMovieScreenState extends State<EditMovieScreen> {
  late TextEditingController titleController;
  late TextEditingController studioController;
  late TextEditingController genreController;
  late TextEditingController durationController;
  late TextEditingController ticketsController;
  late TextEditingController priceController;
  late TextEditingController time1Controller;
  late TextEditingController time2Controller;
  late TextEditingController time3Controller;
  late TextEditingController time4Controller;
  late TextEditingController descriptionController;
  late TextEditingController dateController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.title);
    studioController = TextEditingController(text: widget.studio);
    genreController = TextEditingController(text: widget.genre);
    durationController = TextEditingController(text: widget.duration);
    ticketsController = TextEditingController(text: widget.tickets);
    priceController = TextEditingController(text: widget.price);
    time1Controller = TextEditingController(text: widget.time1);
    time2Controller = TextEditingController(text: widget.time2);
    time3Controller = TextEditingController(text: widget.time3);
    time4Controller = TextEditingController(text: widget.time4);
    descriptionController = TextEditingController(text: widget.description);
    dateController = TextEditingController(text: widget.date);
  }

  @override
  void dispose() {
    titleController.dispose();
    studioController.dispose();
    genreController.dispose();
    durationController.dispose();
    ticketsController.dispose();
    priceController.dispose();
    time1Controller.dispose();
    time2Controller.dispose();
    time3Controller.dispose();
    time4Controller.dispose();
    descriptionController.dispose();
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Movie'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: studioController,
              decoration: InputDecoration(labelText: 'Studio'),
            ),
            TextField(
              controller: genreController,
              decoration: InputDecoration(labelText: 'Genre'),
            ),
            TextField(
              controller: durationController,
              decoration: InputDecoration(labelText: 'Duration'),
            ),
            TextField(
              controller: ticketsController,
              decoration: InputDecoration(labelText: 'Tickets'),
            ),
            TextField(
              controller: priceController,
              decoration: InputDecoration(labelText: 'Price'),
            ),
            TextField(
              controller: time1Controller,
              decoration: InputDecoration(labelText: 'Showtime 1'),
            ),
            TextField(
              controller: time2Controller,
              decoration: InputDecoration(labelText: 'Showtime 2'),
            ),
            TextField(
              controller: time3Controller,
              decoration: InputDecoration(labelText: 'Showtime 3'),
            ),
            TextField(
              controller: time4Controller,
              decoration: InputDecoration(labelText: 'Showtime 4'),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: dateController,
              decoration: InputDecoration(labelText: 'Date'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Simpan perubahan di sini
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}