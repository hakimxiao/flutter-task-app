import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    formKey.currentState!.validate();
    super.dispose();
  }

  void signUpUser() {
    if (formKey.currentState!.validate()) {
      // store the user data
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Sign Up.",
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 30),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(hintText: "Your name"),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Name field cannot be empty";
                  }

                  return null;
                },
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(hintText: "Email"),
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty ||
                      !value.trim().contains("@")) {
                    return "Email field cannot be empty!";
                  }

                  return null;
                },
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(hintText: "Password"),
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty ||
                      value.trim().length <= 6) {
                    return "Password field is invalid!";
                  }

                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: signUpUser,
                child: Text(
                  "SIGN UP NOW",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 20),
              RichText(
                text: TextSpan(
                  text: "Alreagy have an account?",
                  style: Theme.of(context).textTheme.titleMedium,
                  children: [
                    TextSpan(
                      text: " Sign In",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
