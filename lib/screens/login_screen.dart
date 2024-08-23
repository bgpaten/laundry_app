import 'package:flutter/material.dart';
import 'package:laundry_app/services/auth_service.dart';
import 'package:laundry_app/widgets/custom_button.dart';
import 'package:laundry_app/widgets/custom_textfield.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

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
                "Welcome Back!",
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
              SizedBox(height: 30),
              CustomButton(
                text: "Login",
                onPressed: () async {
                  final email = _emailController.text;
                  final password = _passwordController.text;
                  final user = await _authService.signInWithEmailAndPassword(email, password);
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
                  Navigator.pushNamed(context, '/register');
                },
                child: Text(
                  "Don't have an account? Register",
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
