import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:learnflutter/firebase_options.dart';
import 'package:learnflutter/views/verifyemail.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _shouldNavigateToVerification = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: Colors.blue[600],
      ),
      body: FutureBuilder(
        future: Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              final user = FirebaseAuth.instance.currentUser;
              if (user?.emailVerified ?? false) {
                print('you are verified user');
              } else {
                _shouldNavigateToVerification = true;
              }
              return const Text('Done');
            default:
              return const Text('Loading');
          }
        },
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_shouldNavigateToVerification) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const EmailVerification()),
      );
    }
  }
}
