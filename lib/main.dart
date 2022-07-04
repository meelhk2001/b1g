import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saranfarms/firebase_options.dart';
import 'package:saranfarms/providers/authprovider.dart';
import 'package:saranfarms/providers/mainprovider.dart';
import 'package:saranfarms/screens/authscreen.dart';
import 'package:saranfarms/screens/homescreen.dart';
import 'package:saranfarms/screens/retailscreen.dart';
import 'package:saranfarms/screens/userscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MainProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Buy One Gram',
        theme: ThemeData(
            primarySwatch: Colors.green, primaryColor: Colors.green[200]),
        home: Home(),
      ),
    );
  }
}
