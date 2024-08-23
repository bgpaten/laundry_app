import 'package:flutter/material.dart';
import 'package:laundry_app/services/auth_service.dart';
import 'package:laundry_app/widgets/custom_button.dart';
import 'package:laundry_app/widgets/custom_textfield.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  String _selectedRole = 'customer';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.local_laundry_service,
                size: 100,
                color: Colors.blue,
              ),
              SizedBox(height: 30),
              Text(
                "Create an Account",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              CustomTextField(
                labelText: "Email",
                controller: _emailController,
              ),
              SizedBox(height: 20),
              CustomTextField(
                labelText: "Password",
                controller: _passwordController,
                isPassword: true,
              ),
              SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _selectedRole,
                items: [
                  DropdownMenuItem(
                    value: 'customer',
                    child: Text("Customer"),
                  ),
                  DropdownMenuItem(
                    value: 'partner',
                    child: Text("Partner"),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedRole = value!;
                  });
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  labelText: "Role",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 30),
              CustomButton(
                text: "Register",
                onPressed: () async {
                  final email = _emailController.text;
                  final password = _passwordController.text;
                  final user = await _authService.registerWithEmailAndPassword(email, password, _selectedRole);
                  if (user != null) {
                    Navigator.pushReplacementNamed(context, '/home');
                  } else {
                    // Handle error
                  }
                },
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: Text(
                  "Already have an account? Login",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
