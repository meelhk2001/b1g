import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:saranfarms/providers/mainprovider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:saranfarms/screens/homescreen.dart';
import 'package:saranfarms/screens/userscreen.dart';
import 'package:saranfarms/widgets/appbar.dart';
import 'package:saranfarms/widgets/loading.dart';
import 'package:saranfarms/widgets/slider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  //get signInWithGoogle => null;
  String typetext = 'I am a...';
  @override
  Widget build(BuildContext context) {
    //Firebase.initializeApp();
    final hgt = MediaQuery.of(context).size.height;
    final wdth = MediaQuery.of(context).size.width;
    // final GoogleSignIn googleSignIn = GoogleSignIn();
    final FirebaseAuth _auth = FirebaseAuth.instance;

    String? name, uid, email, businuess;
    String? imageUrl;
    int type = 0;
    int? mobile = 91;
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    Future<User?> signInWithGoogle() async {
      // Initialize Firebase
      await Firebase.initializeApp();
      //Firebase.initializeApp();
      User? user;

      // The `GoogleAuthProvider` can only be used while running on the web
      GoogleAuthProvider authProvider = GoogleAuthProvider();

      try {
        final UserCredential userCredential =
            await _auth.signInWithPopup(authProvider);

        user = userCredential.user;
      } catch (e) {
        // print(e);
      }

      if (user != null) {
        uid = user.uid;
        name = user.displayName;
        email = user.email;
        imageUrl = user.photoURL;

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool('auth', true);
      }

      return user;
    }

    return Scaffold(
        appBar: PreferredSize(
          child: const Appbar(),
          preferredSize: Size(wdth, hgt),
        ),
        body: Provider.of<MainProvider>(context).tryauth
            ? const Loading()
            : SingleChildScrollView(
                child: Stack(
                  children: [
                    const ImageSlider(),
                    Row(
                      children: [
                        Form(
                          key: _formKey,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            color: Colors.black.withOpacity(0.09),
                            //Colors.green.withOpacity(0.6),
                            width: wdth * 0.3,
                            height: hgt * 0.907,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              style: BorderStyle.solid,
                                              color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white),
                                      child: Text(
                                        ' Register Yourself ',
                                        style: GoogleFonts.lato(
                                            fontSize: 20, color: Colors.black),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: hgt * 0.05,
                                ),
                                TextFormField(
                                  decoration: const InputDecoration(
                                    hintText: 'Enter your Name*',
                                    hintStyle: TextStyle(color: Colors.white),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                  ),
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                  cursorColor: Colors.white,
                                  style: const TextStyle(color: Colors.white),
                                  onChanged: (value) {
                                    name = value;
                                  },
                                ),
                                SizedBox(
                                  height: hgt * 0.03,
                                ),
                                TextFormField(
                                  cursorColor: Colors.white,
                                  style: const TextStyle(color: Colors.white),
                                  decoration: const InputDecoration(
                                    hintStyle: TextStyle(color: Colors.white),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                    hintText:
                                        'Enter the name of your Businuess (optional)',
                                  ),
                                  validator: (String? value) {
                                    // if (value == null || value.isEmpty) {
                                    //   return 'Please enter some text';
                                    // }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    businuess = value;
                                  },
                                ),
                                SizedBox(
                                  height: hgt * 0.03,
                                ),
                                TextFormField(
                                  cursorColor: Colors.white,
                                  style: const TextStyle(color: Colors.white),
                                  decoration: const InputDecoration(
                                    hintText: 'Enter your Email*',
                                    hintStyle: TextStyle(color: Colors.white),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                  ),
                                  validator: (String? value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        !value.contains('@')) {
                                      return 'Please enter a valid email address';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    email = value;
                                  },
                                ),
                                SizedBox(
                                  height: hgt * 0.03,
                                ),
                                TextFormField(
                                  cursorColor: Colors.white,
                                  style: const TextStyle(color: Colors.white),
                                  decoration: const InputDecoration(
                                    hintText: 'Enter Your Mobile number*',
                                    hintStyle: TextStyle(color: Colors.white),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                  ),
                                  validator: (String? value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        (int.tryParse(value) == null)) {
                                      return 'Please enter valid number';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    mobile = int.tryParse(value);
                                  },
                                ),
                                SizedBox(
                                  height: hgt * 0.05,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    DropdownButton<String>(
                                        iconEnabledColor: Colors.white,
                                        hint: Text(
                                          typetext,
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                        items: <String>[
                                          'I am a Retailer',
                                          'I am an Exporter',
                                          'I am a Farmer/Producer',
                                          'I am a Manufacturer'
                                        ].map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          typetext = value!;
                                          if (typetext == 'I am a Retailer') {
                                            type = 1;
                                          }
                                          if (typetext == 'I am an Exporter') {
                                            type = 2;
                                          }
                                          if (typetext ==
                                              'I am a Farmer/Producer') {
                                            type = 3;
                                          }
                                          if (typetext ==
                                              'I am a Manufacturer') {
                                            type = 4;
                                          }
                                        }
                                        //value: typetext,
                                        ),
                                    ElevatedButton(
                                      onPressed: () {
                                        // Validate will return true if the form is valid, or false if
                                        // the form is invalid.

                                        if (_formKey.currentState!.validate() &&
                                            typetext != 'I am a...') {
                                          try {
                                            Provider.of<MainProvider>(context,
                                                    listen: false)
                                                .addlogindata(
                                                    type.toDouble(),
                                                    name!,
                                                    businuess!,
                                                    email!,
                                                    mobile!);
                                          } catch (e) {
                                            //print(e.toString());
                                            return;
                                          }
                                          _formKey.currentState?.reset();
                                          showDialog<String>(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                AlertDialog(
                                              title: const Text(
                                                  'Request Sent Successfully'),
                                              content: const Text(
                                                  'Please Try login after 24 hours'),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(
                                                        context, 'OK');
                                                    Navigator.of(context)
                                                        .pushReplacement(
                                                      MaterialPageRoute(
                                                        fullscreenDialog: true,
                                                        builder: (context) =>
                                                            Home(Provider.of<
                                                                        MainProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .auth),
                                                      ),
                                                    );
                                                  },
                                                  child: const Text('OK'),
                                                ),
                                              ],
                                            ),
                                          );
                                        }
                                      },
                                      child: const Text('Submit'),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        SizedBox(
                                          height: hgt * 0.07,
                                        ),
                                        const CircleAvatar(
                                            child: Text(
                                              'OR',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                            backgroundColor: Colors.white),
                                        SizedBox(
                                          height: hgt * 0.07,
                                        ),
                                        SignInButton(
                                          Buttons.Google,
                                          text: "Sign in with Google",
                                          onPressed: () async {
                                            await signInWithGoogle()
                                                .then((result) async {
                                              QuerySnapshot check =
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection(
                                                          'loginrequest')
                                                      .where('email',
                                                          isEqualTo:
                                                              result?.email)
                                                      .get();
                                              if (result != null &&
                                                  (check.docs.isNotEmpty) &&
                                                  check.docs[0]['approve'] ==
                                                      true) {
                                                await Provider.of<MainProvider>(
                                                        context,
                                                        listen: false)
                                                    .userdata();
                                                // Navigator.of(context).pop();
                                                Navigator.of(context)
                                                    .pushReplacement(
                                                  MaterialPageRoute(
                                                    fullscreenDialog: true,
                                                    builder: (context) =>
                                                        UserScreen(),
                                                  ),
                                                );
                                              } else {
                                                try {
                                                  _auth.currentUser?.delete();
                                                  if (check.docs.isEmpty) {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                            const SnackBar(
                                                                content: Text(
                                                                    'Register Yourself first')));
                                                  }
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                          content: Text(check
                                                                          .docs[0]
                                                                      [
                                                                      'approve'] ==
                                                                  false
                                                              ? check.docs[0][
                                                                      'comment']
                                                                  .toString()
                                                              : 'Register Yourself first')));
                                                } catch (_) {}
                                              }
                                            }).catchError((error) {
                                              //
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: hgt * (0.907 / 2) - hgt * 0.0907,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ));
  }
}
