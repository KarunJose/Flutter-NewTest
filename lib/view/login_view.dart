import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../firebase_options.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

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
        title: const Text('Login'),
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
             final loginUserAuth =  await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: email, 
              password: password);
              print(loginUserAuth);
           } on FirebaseAuthException catch (e) {
            if (e.code == 'user-not-found') {
            const snackBar = SnackBar(content: 
            Text('User not found'),);
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            } else if (e.code == 'wrong-password'){
               const snackBar = SnackBar(content: 
            Text('Wrong Password'),);
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
           }
       
        },
            child: const Text('Login'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil('/register/', (route) => false);
              }, 
              child: const Text('Not Registered yet? Register here!'),)
          ],
        );
              
        default: return const CircularProgressIndicator();
          }
        
        },
        
      ),
    );
  }
}