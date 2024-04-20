import 'package:flutter/material.dart';
import 'package:learnflutter/views/login_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
    ),
    home: const LoginView(),
    debugShowCheckedModeBanner: false,
  ));
}


