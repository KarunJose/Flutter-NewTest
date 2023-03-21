import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({super.key});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          const Text('Please Verify your email'),
          TextButton(
          onPressed: () async {
            final user = FirebaseAuth.instance.currentUser;
           await user?.sendEmailVerification();
          },
           child: const Text('Send Verification')),
        ],
      );
  }
}