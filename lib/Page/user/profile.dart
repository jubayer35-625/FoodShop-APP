
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final email = FirebaseAuth.instance.currentUser!.email;
  final creationTime = FirebaseAuth.instance.currentUser!.metadata.creationTime;

  User? user = FirebaseAuth.instance.currentUser;

  verifyEmail() async {
    if (user != null && !user!.emailVerified) {
      await user!.sendEmailVerification();
      print('Verification Email has benn sent');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.orangeAccent,
          content: Text(
            'Verification Email has benn sent',
            style: TextStyle(fontSize: 18.0, color: Colors.black),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child:Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child:Column(
              children: [
                Text(
                  'User ID: $uid',
                  style: const TextStyle(fontSize: 18.0),
                ),
                Row(
                  children: [
                    Text(
                      'Email: $email',
                      style: const TextStyle(fontSize: 18.0),
                    ),
                    user!.emailVerified
                        ? const Text(
                      'verified',
                      style: TextStyle(fontSize: 18.0, color: Colors.blueGrey),
                    )
                        : TextButton(
                        onPressed: () => {verifyEmail()},
                        child: const Text('Verify Email'))
                  ],
                ),
                Text(
                  'Created: $creationTime',
                  style: const TextStyle(fontSize: 18.0),
                ),
              ],
            ) ,
          ),
        ),
      )
    );
  }
}