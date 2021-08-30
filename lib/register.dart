import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    void register() async {
      FirebaseAuth auth = FirebaseAuth.instance;
      FirebaseFirestore db = FirebaseFirestore.instance;

      final String username = usernameController.text;
      final String email = emailController.text;
      final String password = passwordController.text;
      print("username: " + username);

      try {
        final UserCredential user = await auth.createUserWithEmailAndPassword(
            email: email, password: password);

        await db.collection('user').doc(user.user!.uid).set({
          "email": email,
          "username": username,
        });

        print('User is now registered');
      } catch (e) {
        print('Error');
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Text("$e"),
              );
            });
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Account Details'),
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.blue,
              Colors.red,
            ],
          )),
          child: Padding(
            padding: const EdgeInsets.only(
              top: 30,
            ),
            child: Center(
              child: Column(
                children: [
                  Text(
                    'Create Account',
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 80, right: 80, top: 30),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: usernameController,
                          decoration: InputDecoration(
                            hintText: "Enter user name",
                            prefixIcon: Padding(
                              padding: EdgeInsets.all(00),
                              child: Icon(Icons.usb_rounded),
                            ),
                          ),
                        ),
                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            hintText: "Enter Email Id",
                            prefixIcon: Padding(
                              padding: EdgeInsets.all(00),
                              child: Icon(Icons.email),
                            ),
                          ),
                        ),
                        TextFormField(
                          controller: passwordController,
                          decoration: InputDecoration(
                            hintText: "Enter Password",
                            prefixIcon: Padding(
                              padding: EdgeInsets.all(00),
                              child: Icon(Icons.lock),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: ElevatedButton(
                            onPressed: register,
                            style: ElevatedButton.styleFrom(
                                primary: Colors.teal[300],
                                onPrimary: Colors.deepOrangeAccent[50],
                                onSurface: Colors.deepPurple,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 20),
                                textStyle: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            child: Text(
                              'SignUp',
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
