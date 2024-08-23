import 'package:flutter/material.dart';
import 'package:laundry_app/screens/order_history_screen.dart'; // Import halaman riwayat order

class NotificationScreen extends StatelessWidget {
  final String message;

  NotificationScreen({required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notification"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Navigate to OrderHistoryScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderHistoryScreen(),
                    ),
                  );
                },
                child: Text("OK"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
