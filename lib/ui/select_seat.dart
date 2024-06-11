import 'package:flutter/material.dart';
import 'payment_method.dart';

class ReservationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ReservationScreen(),
    );
  }
}

class ReservationScreen extends StatefulWidget {
  @override
  _ReservationScreenState createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  int selectedDateIndex = 2;
  int selectedTimeIndex = 2;
  List<bool> seatSelection = List.generate(40, (index) => false);

  int getTotalPayment() {
    int selectedSeats = seatSelection.where((seat) => seat).length;
    return selectedSeats * 40000;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Column(
            children: [
              PreferredSize(
                preferredSize: Size.fromHeight(40.0),
                child: AppBar(
                  backgroundColor: Color.fromRGBO(54, 55, 70, 1.0),
                  elevation: 0,
                  title: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "Reservation",
                      style:
                          TextStyle(color: Color.fromRGBO(120, 121, 131, 1.0)),
                    ),
                  ),
                  centerTitle: true,
                  leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Color.fromRGBO(161, 247, 255, 1.0),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  actions: [
                    IconButton(
                      icon: Image.asset(
                        'assets/images/ticket.png',
                        height: 80,
                      ), // Menggunakan gambar tiket sebagai ikon
                      onPressed: null,
                    ),
                  ],
                  iconTheme: IconThemeData(color: Colors.white),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/images/bioskop.png',
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(height: 50.0),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 8,
                            childAspectRatio: 1.0,
                            crossAxisSpacing: 8.0,
                            mainAxisSpacing: 8.0,
                          ),
                          itemCount: 40,
                          itemBuilder: (context, index) {
                            bool isChosen = seatSelection[index];
                            bool isFilled = index % 2 == 0;
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  seatSelection[index] = !seatSelection[index];
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: isChosen
                                      ? Color.fromRGBO(161, 247, 255, 1.0)
                                      : isFilled
                                          ? Color.fromRGBO(54, 55, 64, 1.0)
                                          : Color.fromRGBO(54, 55, 64, 1.0),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 16.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            LegendItem(
                              color: Color.fromRGBO(54, 55, 64, 1.0),
                              text: 'Empty',
                            ),
                            LegendItem(
                              color: Color.fromRGBO(161, 247, 255, 1.0),
                              text: 'Chosen',
                            ),
                            LegendItem(
                              color: Colors.white,
                              text: 'Filled',
                            ),
                          ],
                        ),
                        SizedBox(height: 100.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Time and Date",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Container(
                              height: 80,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 5,
                                itemBuilder: (context, index) {
                                  bool isSelected = selectedDateIndex == index;
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedDateIndex = index;
                                      });
                                    },
                                    child: Container(
                                      width: 60,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 8.0),
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? Color.fromRGBO(161, 247, 255, 1.0)
                                            : Color.fromRGBO(54, 55, 64, 1.0),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Jun",
                                              style: TextStyle(
                                                color: isSelected
                                                    ? Colors.black
                                                    : Colors.white,
                                              ),
                                            ),
                                            Text(
                                              "${27 + index}",
                                              style: TextStyle(
                                                color: isSelected
                                                    ? Colors.black
                                                    : Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.0),
                        Container(
                          height: 60,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              bool isSelected = selectedTimeIndex == index;
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedTimeIndex = index;
                                  });
                                },
                                child: Container(
                                  width: 80,
                                  margin: EdgeInsets.symmetric(horizontal: 8.0),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? Color.fromRGBO(161, 247, 255, 1.0)
                                        : Color.fromRGBO(54, 55, 64, 1.0),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "${11 + index}:30",
                                      style: TextStyle(
                                        color: isSelected
                                            ? Colors.black
                                            : Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                padding: EdgeInsets.all(16.0),
                                constraints: BoxConstraints(maxWidth: 200),
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(64, 64, 64, 1),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Text(
                                  "Total Payment: Rp ${getTotalPayment()}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            SizedBox(width: 8.0),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PaymentMethodScreen(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Color.fromRGBO(161, 247, 255, 1.0),
                                padding: EdgeInsets.symmetric(
                                    vertical: 25.0, horizontal: 40.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  side: BorderSide(
                                    color: Color.fromRGBO(42, 112, 119, 1),
                                    width: 0.0,
                                  ),
                                ),
                              ),
                              child: Text(
                                "Payment",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LegendItem extends StatelessWidget {
  final Color color;
  final String text;

  LegendItem({required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
