import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:learnflutter/firebase_options.dart';
import 'package:learnflutter/views/register_view.dart';
import 'package:learnflutter/views/verifyemail.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: Colors.blue[600],
      ),
      body: FutureBuilder(
        future: Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return Column(
                children: [
                  TextField(
                    controller: _email,
                    autocorrect: false,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: 'Enter your email',
                    ),
                  ),
                  TextField(
                    controller: _password,
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: const InputDecoration(
                      hintText: 'Enter your password',
                    ),
                  ),
                  Center(
                    child: TextButton(
                      onPressed: () async {
                        final email = _email.text;
                        final password = _password.text;
                        try {
                          final userCredential = await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                            email: email,
                            password: password,
                          );
                          print(userCredential);
                        } on FirebaseAuthException catch (e) {
                          // print(e.code);
                          // print(e.runtimeType);
                          // print('something went wrong');
                          if (e.code == 'too-many-request') {
                            print('To many request try again later');
                          } else if (e.code == 'invalid-credential') {
                            print('Invalid Credentials');
                          } else {
                            print(e.runtimeType);
                            print(e.code);
                            print('something else');
                          }
                        } catch (e) {
                          print('An unexpected error occurred: $e');
                        }
                      },
                      child: const Text('Login here'),
                    ),
                  ),
                ],
              );

            default:
              return const Text('Loading');
          }
        },
      ),
      bottomNavigationBar: Row(
        crossAxisAlignment: CrossAxisAlignment.center ,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const RegisterView(),
                ),
              );
            },
            child: const Text('Sign-up'),
          ),
          TextButton(onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EmailVerification(),
                ),
              );
          }, child:const Text('Verify email'))
        ],
      ),
    );
  }
}
