import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:new_test/firebase_options.dart';

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

      if (user?.emailVerified ?? false) {
        print('you are a verified user');
      } else {
        print('you need to be verified');
      }

          return const Text('Done');
           default: return const Text('Loading...');
        }
      },),
    
    );
  }
}