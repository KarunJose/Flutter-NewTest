import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:new_test/firebase_options.dart';
import 'package:new_test/view/login_view.dart';
import 'package:new_test/view/verify_email.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: const Text('HomePage'),
      ),
      body: FutureBuilder(future:  Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform,
             ),
             builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
      final user = FirebaseAuth.instance.currentUser;
     if (user != null) {
      if (user.emailVerified) {
        print('Email is verified');
      } else {
        return const VerifyEmail();
      }
     } else {
      return const LoginView();
     } 
     return const Text('Done');
      // if (user?.emailVerified ?? false) {
      //  return const Text('Done');
      // } else {
      //  return const LoginView();
      // }

          
           default: return const CircularProgressIndicator();
        }
      },),
    
    );
  }
}