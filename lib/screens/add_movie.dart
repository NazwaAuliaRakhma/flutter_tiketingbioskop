import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'home_admin.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as path;

class AddMoviePage extends StatefulWidget {
  @override
  _AddMoviePageState createState() => _AddMoviePageState();
}

class _AddMoviePageState extends State<AddMoviePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _ticketController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _movieNameController = TextEditingController();
  final TextEditingController _movieDescriptionController =
      TextEditingController();
  final TextEditingController _synopsisController = TextEditingController();
  String _selectedStudio = '1';
  String _selectedGenre = 'Horor';
  String _selectedTime = '13:30';
  final _timeSlots = ['13:30', '14:40', '15:30', '16:30'];
  XFile? _image;

  @override
  void dispose() {
    _dateController.dispose();
    _ticketController.dispose();
    _priceController.dispose();
    _movieNameController.dispose();
    _movieDescriptionController.dispose();
    _synopsisController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = pickedFile;
      });
    }
  }

  String generateRandomId() {
    var random = Random();
    int randomNumber = 10000 + random.nextInt(90000);
    return randomNumber.toString();
  }

  Future<String> uploadImageToFirebase(XFile imageFile) async {
    final fileName = path.basename(imageFile.path);
    firebase_storage.Reference firebaseStorageRef = firebase_storage
        .FirebaseStorage.instance
        .ref()
        .child('assets/images/$fileName');
    await firebaseStorageRef.putFile(File(imageFile.path));
    return await firebaseStorageRef.getDownloadURL();
  }

  Future<void> _saveMovie() async {
    try {
      String imagePath = await uploadImageToFirebase(_image!);
      String movieId = generateRandomId();
      await FirebaseFirestore.instance.collection('movies').add({
        'id_movie': movieId,
        'date': _dateController.text,
        'price': _priceController.text,
        'genre': _selectedGenre,
        'studio': _selectedStudio,
        'movie_name': _movieNameController.text,
        'movie_description': _movieDescriptionController.text,
      });

      // Simpan juga data film di koleksi 'movies' milik pengguna
      await FirebaseFirestore.instance
          .collection('users')
          .doc('userID')
          .collection('movies')
          .doc(movieId)
          .set({
        'id_movies': movieId,
        'date': _dateController.text,
        'price': _priceController.text,
        'genre': _selectedGenre,
        'studio': _selectedStudio,
        'movie_name': _movieNameController.text,
        'movie_description': _movieDescriptionController.text,
        'cover_movie': imagePath,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Movie saved successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save movie: $e')),
      );
    }
  }

  void _resetForm() {
    setState(() {
      _dateController.clear();
      _ticketController.clear();
      _priceController.clear();
      _movieNameController.clear();
      _movieDescriptionController.clear();
      _synopsisController.clear();
      _selectedStudio = '1';
      _selectedGenre = 'Horor';
      _selectedTime = '13:30';
      _image = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1D1D28),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 37, 37, 53),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MovieScreen()),
          ),
        ),
        title: Text('Add Movie', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDateField(),
                        SizedBox(height: 16.0),
                        _buildStudioDropdown(),
                        SizedBox(height: 16.0),
                        _buildTicketField(),
                        SizedBox(height: 16.0),
                      ],
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildPriceField(),
                        SizedBox(height: 16.0),
                        _buildImageUploadField(),
                        SizedBox(height: 16.0),
                        _buildGenreDropdown(),
                        SizedBox(height: 16.0),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              _buildTextField(_movieNameController, 'Movie Name'),
              SizedBox(height: 16.0),
              _buildTextField(_movieDescriptionController, 'Movie Description'),
              SizedBox(height: 16.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTimeField(),
                      SizedBox(height: 16.0),
                    ],
                  )),
                  SizedBox(width: 16),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDurationField(),
                      SizedBox(height: 16.0),
                    ],
                  ))
                ],
              ),
              SizedBox(height: 16.0),
              _buildTextField(_synopsisController, 'Synopsis Film'),
              SizedBox(height: 16.0),
              _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateField() {
    return TextFormField(
      controller: _dateController,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: 'Date',
        labelStyle: TextStyle(color: Colors.white),
        filled: true,
        fillColor: Colors.black26,
        border: OutlineInputBorder(),
        suffixIcon: IconButton(
          icon: Icon(Icons.calendar_today, color: Colors.white),
          onPressed: _selectDate,
        ),
      ),
      readOnly: true,
    );
  }

  Future<void> _selectDate() async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (selectedDate != null) {
      setState(() {
        _dateController.text = DateFormat('dd.MM.yyyy').format(selectedDate);
      });
    }
  }

  Future<String> uploadImageToFirebaseStorage(XFile imageFile) async {
    if (kIsWeb) {
      // Handle web upload
      final fileName = path.basename(imageFile.path);
      firebase_storage.Reference firebaseStorageRef = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child('assets/images/$fileName');
      await firebaseStorageRef.putData(await imageFile.readAsBytes());
      return await firebaseStorageRef.getDownloadURL();
    } else {
      // Handle mobile upload
      final fileName = path.basename(imageFile.path);
      firebase_storage.Reference firebaseStorageRef = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child('assets/images/$fileName');
      await firebaseStorageRef.putFile(File(imageFile.path));
      return await firebaseStorageRef.getDownloadURL();
    }
  }

  Widget _buildStudioDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedStudio,
      onChanged: (newValue) {
        setState(() {
          _selectedStudio = newValue!;
        });
      },
      items: ['1', '2', '3', '4'].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value, style: TextStyle(color: Colors.white)),
        );
      }).toList(),
      decoration: InputDecoration(
        labelText: 'Studio',
        labelStyle: TextStyle(color: Colors.white),
        filled: true,
        fillColor: Colors.black26,
        border: OutlineInputBorder(),
      ),
      dropdownColor: Colors.black,
    );
  }

  Widget _buildTicketField() {
    return TextFormField(
      controller: _ticketController,
      keyboardType: TextInputType.number,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: 'Ticket',
        labelStyle: TextStyle(color: Colors.white),
        filled: true,
        fillColor: Colors.black26,
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildPriceField() {
    return TextFormField(
      controller: _priceController,
      keyboardType: TextInputType.number,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: 'Price',
        labelStyle: TextStyle(color: Colors.white),
        filled: true,
        fillColor: Colors.black26,
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildImageUploadField() {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        color: Colors.black26,
        height: 50,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add_photo_alternate, color: Colors.white),
              SizedBox(width: 8.0),
              Text('Upload Image', style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGenreDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedGenre,
      onChanged: (newValue) {
        setState(() {
          _selectedGenre = newValue!;
        });
      },
      items: ['Horor', 'Action', 'Comedy', 'Drama']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value, style: TextStyle(color: Colors.white)),
        );
      }).toList(),
      decoration: InputDecoration(
        labelText: 'Genre',
        labelStyle: TextStyle(color: Colors.white),
        filled: true,
        fillColor: Colors.black26,
        border: OutlineInputBorder(),
      ),
      dropdownColor: Colors.black,
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return TextFormField(
      controller: controller,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white),
        filled: true,
        fillColor: Colors.black26,
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildTimeField() {
    return DropdownButtonFormField<String>(
      value: _selectedTime,
      onChanged: (newValue) {
        setState(() {
          _selectedTime = newValue!;
        });
      },
      items: _timeSlots.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value, style: TextStyle(color: Colors.white)),
        );
      }).toList(),
      decoration: InputDecoration(
        labelText: 'Time',
        labelStyle: TextStyle(color: Colors.white),
        filled: true,
        fillColor: Colors.black26,
        border: OutlineInputBorder(),
      ),
      dropdownColor: Colors.black,
    );
  }

  Widget _buildDurationField() {
    return TextFormField(
      initialValue: '1j 30m',
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: 'Duration',
        labelStyle: TextStyle(color: Colors.white),
        filled: true,
        fillColor: Colors.black26,
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: _resetForm,
          style: ElevatedButton.styleFrom(primary: Color(0xFFA1F7FF)),
          child: Text('Reset'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _saveMovie();
            }
          },
          style: ElevatedButton.styleFrom(primary: Color(0xFFA1F7FF)),
          child: Text('Save'),
        ),
      ],
    );
  }
}
