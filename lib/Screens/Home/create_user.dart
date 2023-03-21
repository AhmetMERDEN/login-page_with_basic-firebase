import 'dart:math';

import 'package:firebase/Screens/Home/home_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class CreateUser extends StatefulWidget {
  const CreateUser({super.key});

  @override
  State<CreateUser> createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  final fb = FirebaseDatabase.instance;
  @override
  Widget build(BuildContext context) {
    var rng = Random();
    var k = rng.nextInt(10000);

    final ref = fb.ref().child('user/$k');
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Create User"),
        backgroundColor: Colors.purple,
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(border: Border.all()),
              child: TextField(
                style: TextStyle(color: Colors.white),
                controller: emailController,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange, width: 4)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.orange)),
                    hintText: 'Email',
                    hintStyle: TextStyle(color: Colors.white),
                    focusColor: Colors.orange),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(border: Border.all()),
              child: TextField(
                style: TextStyle(color: Colors.white),
                controller: passwordController,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange, width: 4)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.orange)),
                    hintText: 'Password',
                    hintStyle: TextStyle(color: Colors.white),
                    focusColor: Colors.orange),
                obscureText: true,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            MaterialButton(
              color: Colors.red,
              onPressed: () {
                ref.set({
                  "Email": emailController.text,
                  "Password": passwordController.text,
                }).asStream();
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => HomeScreen()));
              },
              child: Text(
                "Save",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
