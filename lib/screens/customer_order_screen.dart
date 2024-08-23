import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:laundry_app/services/auth_service.dart';
import 'package:laundry_app/screens/notification_screen.dart';
import 'package:laundry_app/models/order.dart';
import 'package:laundry_app/services/order_service.dart';

class CustomerOrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Place Your Order",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          OrderForm(), // Menampilkan form order di sini
        ],
      ),
    );
  }
}

class OrderForm extends StatefulWidget {
  @override
  _OrderFormState createState() => _OrderFormState();
}

class _OrderFormState extends State<OrderForm> {
  String _selectedService = 'Cuci Kering'; // Default selected service
  List<String> _services = ['Cuci Kering', 'Cuci Setrika', 'Dry Cleaning'];
  bool _isExpressService = false;
  bool _isSpecialFragrance = false;
  TextEditingController _addressController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _postalController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _placeOrder() async {
    if (_formKey.currentState!.validate()) {
      // Only proceed if the form is valid
      String? userId = await AuthService().getCurrentUserId();

      if (userId != null) {
        // Prepare data to be saved
        Map<String, dynamic> orderData = {
          'service': _selectedService,
          'expressService': _isExpressService,
          'specialFragrance': _isSpecialFragrance,
          'pickupAddress': {
            'streetAddress': _addressController.text,
            'city': _cityController.text,
            'postalCode': _postalController.text,
          },
          'orderStatus': 'pending',
          'userId': userId,
          'createdAt': FieldValue.serverTimestamp(),
        };

        try {
          await OrderService().createOrder(OrderModel.fromMap(orderData));
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NotificationScreen(
                message: "Your laundry will be picked up soon.",
              ),
            ),
          );
        } catch (e) {
          print("Error placing order: $e");
          // Handle error scenario
        }
      } else {
        print("User ID is null. Unable to place order.");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DropdownButtonFormField<String>(
            value: _selectedService,
            items: _services.map((String service) {
              return DropdownMenuItem(
                value: service,
                child: Text(service),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedService = value!;
              });
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[200],
              labelText: "Service",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Checkbox(
                value: _isExpressService,
                onChanged: (value) {
                  setState(() {
                    _isExpressService = value!;
                  });
                },
              ),
              Text("Express Service"),
            ],
          ),
          Row(
            children: [
              Checkbox(
                value: _isSpecialFragrance,
                onChanged: (value) {
                  setState(() {
                    _isSpecialFragrance = value!;
                  });
                },
              ),
              Text("Special Fragrance"),
            ],
          ),
          SizedBox(height: 20),
          Text(
            "Pickup Address",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          TextFormField(
            controller: _addressController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter street address';
              }
              return null;
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[200],
              labelText: "Street Address",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _cityController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter city';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
                    labelText: "City",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: TextFormField(
                  controller: _postalController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter postal code';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
                    labelText: "Postal Code",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _placeOrder,
            child: Text("Place Order"),
          ),
        ],
      ),
    );
  }
}
