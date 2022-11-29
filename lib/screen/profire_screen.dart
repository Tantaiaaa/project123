import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class profilescreen extends StatelessWidget {
  final auth = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    var email;
    return Scaffold(
        appBar: AppBar(
            title: Text("โปรไฟล์ผู้ใช้งาน", textScaleFactor: 1.5),
            backgroundColor: Color.fromARGB(255, 221, 172, 254)),
        body: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Center(
                child: Column(
              children: [
                Text(
                  auth!.email!,
                  style: TextStyle(
                    fontSize: 30,
                  ),
                )
              ],
            ))));
  }
}
