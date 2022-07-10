import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:saranfarms/models/product.dart';
import 'package:saranfarms/providers/mainprovider.dart';
import 'package:saranfarms/screens/userscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? name, uid, email;
  String? imageUrl;
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
      // ignore: empty_catches
    } catch (e) {}

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

  void sgnin(BuildContext context) async {
    signInWithGoogle().then((result) async {
      QuerySnapshot check = await FirebaseFirestore.instance
          .collection('loginrequest')
          .where('email', isEqualTo: result?.email)
          .get();
      if (result != null &&
          (check.docs.isNotEmpty) &&
          check.docs[0]['approve'] == true) {
        await Provider.of<MainProvider>(context, listen: false).userdata();
        // Navigator.of(context).pop();
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) => UserScreen(),
          ),
        );
      } else {
        try {
          _auth.currentUser?.delete();
          if (check.docs.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Register Yourself first')));
          }
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(check.docs[0]['approve'] == false
                  ? check.docs[0]['comment'].toString()
                  : 'Register Yourself first')));
        } catch (_) {}
      }
    });
  }

  void pdtadddiag(BuildContext context, bool edit, String typecode,
      [Product? pdt]) {
    String? name, description, imageurl;
    double? price;
    final hgt = MediaQuery.of(context).size.height;
    final wdth = MediaQuery.of(context).size.width;
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: Colors.white,
        title: const Text('Enter The details of the  product'),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                initialValue: edit ? pdt!.title : null,
                onChanged: (value) => name = value,
                decoration: const InputDecoration(
                  label: Text('Name or title*'),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  } else {
                    name = value;
                  }
                  return null;
                },
              ),
              SizedBox(
                height: hgt * 0.03,
              ),
              TextFormField(
                initialValue: edit ? pdt!.description : null,
                decoration: const InputDecoration(
                  label: Text('Description*'),
                ),
                onChanged: (value) => description = value,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  } else {
                    description = value;
                  }
                  return null;
                },
              ),
              SizedBox(
                height: hgt * 0.03,
              ),
              TextFormField(
                initialValue: edit ? pdt!.price.toString() : null,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[0-9.,]+')),
                ],
                decoration: const InputDecoration(
                  label: Text('Price in INR*'),
                ),
                onChanged: (value) {
                  double prc = double.tryParse(value) ?? 0;
                  price = prc;
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter valid number';
                  } else {
                    price = double.tryParse(value);
                  }
                  return null;
                },
              ),
              SizedBox(
                height: hgt * 0.03,
              ),
              TextFormField(
                initialValue: edit ? pdt!.imageUrl : null,
                decoration: const InputDecoration(
                  label: Text('Product image link*'),
                ),
                onChanged: (value) => imageurl = value,
                validator: (String? value) {
                  if (value == null || value.isEmpty || !value.contains('.')) {
                    return 'Please enter a valid link';
                  } else {
                    imageurl = value;
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        actions: <Widget>[
          Center(
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState?.reset();
                  Navigator.pop(context, 'OK');
                  showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                            backgroundColor: Colors.white,
                            title: const Text('Varify you Image'),
                            content: Stack(
                              children: [
                                const Center(
                                    child: CircularProgressIndicator()),
                                Image.network(imageurl!),
                              ],
                            ),
                            actions: [
                              Center(
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (edit) {
                                      Provider.of<MainProvider>(context,
                                              listen: false)
                                          .editpdt(
                                              Product(
                                                  id: pdt!.id,
                                                  title: name!,
                                                  description: description!,
                                                  imageUrl: imageurl!,
                                                  price: price!),
                                              typecode);
                                    } else {
                                      Provider.of<MainProvider>(context,
                                              listen: false)
                                          .adddata(name!, description!, price!,
                                              imageurl!, typecode);
                                    }
                                    Navigator.pop(context, 'OK');
                                  },
                                  child: const Icon(Icons.done_outlined),
                                ),
                              )
                            ],
                          ));
                }
              },
              child: const Text('OK'),
            ),
          ),
        ],
      ),
    );
  }
}
