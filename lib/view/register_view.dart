
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../firebase_options.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {

  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
     _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: FutureBuilder(
        future:  Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform,
             ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
          
            case ConnectionState.done:

              return Column(
          children: [
            TextField(
              controller: _emailController,
              enableSuggestions: false,
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: 'Enter your email'
              ),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
               decoration: const InputDecoration(
                hintText: 'Enter your password'
              ),
            ),
            TextButton(
              onPressed: () async {
      
               
             final email = _emailController.text;
                final password = _passwordController.text;
            try {
               final createUserAuth =  await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: email, 
              password: password);
              print(createUserAuth);
            } on FirebaseAuthException catch (e) {
              if (e.code == 'weak-password') {
                const snackBar = SnackBar(
                  content: Text('Weak Password'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              } else if (e.code == 'email-already-in-use') {
                const snackBar = SnackBar(
                  content: Text('Email already in use'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              } else if (e.code == 'invalid-email') {
                const snackBar = SnackBar(
                  content: Text('Invalid Email'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            };
       
        },
            child: const Text('Register'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context, '/login/', (route) => false);
              }, 
              child: const Text('Already Registered? Login here!'))
          ],
        );
              
        default: return const CircularProgressIndicator();
          }
        
        },
        
      ),
    );
  }
}