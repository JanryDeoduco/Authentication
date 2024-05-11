import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpState();
}

class _SignUpState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  String? fname;
  String? lname;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
            margin: const EdgeInsets.all(30),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [heading, firstNameField, lastNameField, emailField, passwordField, submitButton],
              ),
            )),
      ),
    );
  }

  Widget get heading => const Padding(
        padding: EdgeInsets.only(bottom: 30),
        child: Text(
          "Sign Up",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      );

  Widget get firstNameField => Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: TextFormField(
        decoration: const InputDecoration(
            border: OutlineInputBorder(),
            label: Text("First Name"),
            hintText: "Enter a valid name"),
        onSaved: (value) => setState(() => fname = value),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please enter your first name";
          }
          return null;
        },
      ),
    );

    Widget get lastNameField => Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: TextFormField(
        decoration: const InputDecoration(
            border: OutlineInputBorder(),
            label: Text("Last Name"),
            hintText: "Enter a valid name"),
        onSaved: (value) => setState(() => lname = value),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please enter your last name";
          }
          return null;
        },
      ),
    );

  Widget get emailField => Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: TextFormField(
        decoration: const InputDecoration(
            border: OutlineInputBorder(),
            label: Text("Email"),
            hintText: "Enter a valid email"),
        onSaved: (value) => setState(() => email = value),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please enter a valid email format";
          }
          return null;
        },
      ),
    );

  Widget get passwordField => Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: TextFormField(
          decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text("Password"),
              hintText: "At least 6 characters"),
          obscureText: true,
          onSaved: (value) => setState(() => password = value),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter a valid password";
            }
            return null;
          },
        ),
      );

  Widget get submitButton => ElevatedButton(
    onPressed: () async {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        String? message = await context
          .read<UserAuthProvider>()
          .authService
          .signUp(email!, password!, fname!, lname!);
        print(message);

       
        if (message == "invalid-email") {
          // print("invalid email");
          
          String errorMessage = "Invalid email: Please eneter a valid one";

          
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(errorMessage),
              backgroundColor: Colors.red, 
            ),
          );
        }
        else if (message == "weak-password"){
          String errorMessage = "Invalid password: Please enter at least 6 characters of password";
          
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(errorMessage),
              backgroundColor: Colors.red, 
            ),
          );
        }

        else if (message == "email-already-in-use"){
          String errorMessage = "Email already in use: Please enter another email adddress";
          
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(errorMessage),
              backgroundColor: Colors.red, 
            ),
          );
        }

        else{
          if (mounted) Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Welcome User!"),
              backgroundColor: Color.fromARGB(255, 0, 255, 42), 
            ),
          );
        }
      }
    },
    child: const Text("Sign Up"),
    
  );

}
