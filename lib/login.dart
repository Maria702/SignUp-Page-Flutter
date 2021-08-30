import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'register.dart';

class Login extends StatelessWidget {
  @override
  void _navigateToNextScreen(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => Register()));
  }

  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    void login() async {
      Map<dynamic, dynamic> UserData = {};
      FirebaseAuth auth = FirebaseAuth.instance;
      FirebaseFirestore db = FirebaseFirestore.instance;

      final String email = emailController.text;
      final String password = passwordController.text;
      print("email: " + email);
      print("password: " + password);
      try {
        final UserCredential user = await auth.signInWithEmailAndPassword(
            email: email, password: password);

        final DocumentSnapshot snapshot =
            await db.collection('user').doc(user.user!.uid).get();

        final data = snapshot.data();
        //   setState(() {
        //   UserData = data;
        //   UserData['provider'] = 'Email';
        // });
        Navigator.of(context).pushNamed("/home");

        print(
            '=========================User is Login...=============================');

        print("Name =====> $data?.email");

        print("Name =====> ${UserData["username"]}");
        print("Email =====> ${UserData["email"]}");
        print("Email =====> ${UserData["provider"]}");

        print("User is Logged");
      } catch (e) {
        print("error");
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Text("$e"),
              );
            });

        print(e);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Login Details'),
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              // border: Border.all(color: Colors.black, width: 2),
              gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.lightBlue.shade400,
              Colors.pink.shade600,
            ],
          )),
          child: Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: Center(
              child: Column(
                children: [
                  Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 80, right: 80, top: 5),
                    child: Column(
                      children: [
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
                            onPressed: login,
                            style: ElevatedButton.styleFrom(
                                primary: Colors.teal[300],
                                onPrimary: Colors.deepOrangeAccent[50],
                                onSurface: Colors.deepPurple,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 10),
                                textStyle: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold)),
                            child: Text(
                              'Login',
                            ),
                          ),
                        ),
                        Container(
                            child: Padding(
                          padding: const EdgeInsets.only(
                            top: 5,
                          ),
                          child: Text("----------or----------",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black)),
                        )),
                        Container(
                            child: Padding(
                          padding: const EdgeInsets.only(
                            top: 5,
                          ),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Forgot your password?',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline),
                                  // recognizer: TapGestureRecognizer()
                                  //   ..onTap = Register() as GestureTapCallback?,
                                ),
                              ],
                            ),
                          ),
                        )),
                        Container(
                            child: Padding(
                          padding: const EdgeInsets.only(
                            top: 10,
                          ),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                    text: 'New to RiaChat? ',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black)),
                                TextSpan(
                                    text: 'SignUp',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.blue,
                                        decoration: TextDecoration.underline),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Register(),
                                          ),
                                        );
                                      })
                              ],
                            ),
                          ),
                        )),
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
