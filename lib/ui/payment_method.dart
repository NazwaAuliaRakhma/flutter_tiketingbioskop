import 'package:flutter/material.dart';

class PaymentApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PaymentMethodScreen(),
    );
  }
}

class PaymentMethodScreen extends StatelessWidget {
  final List<Map<String, String>> paymentMethods = [
    {'name': 'Dana', 'image': 'assets/images/image 10.png'},
    {'name': 'LinkAja', 'image': 'assets/images/image 13.png'},
    {'name': 'OVO', 'image': 'assets/images/image 12.png'},
    {'name': 'GoPay', 'image': 'assets/images/image 11.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Method'),
      ),
      body: ListView.builder(
        itemCount: paymentMethods.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.asset(paymentMethods[index]['image']!),
            title: Text(paymentMethods[index]['name']!),
            onTap: () {
              // Handle payment method selection
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PaymentDetailScreen(
                    paymentMethod: paymentMethods[index]['name']!,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class PaymentDetailScreen extends StatelessWidget {
  final String paymentMethod;

  PaymentDetailScreen({required this.paymentMethod});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$paymentMethod Payment'),
      ),
      body: Center(
        child: Text('Proceed with $paymentMethod payment.'),
      ),
    );
  }
}
