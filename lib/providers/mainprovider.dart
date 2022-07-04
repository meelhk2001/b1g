import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainProvider with ChangeNotifier {
  bool home = false;
  String typetext = 'I am a...';
  String? uid;
  String? username, businuess;
  String? email;
  String? imageUrl;
  int? mobile, type;
  bool auth = false;

  void authscreen() {
    home = !home;
    notifyListeners();
  }

  String typetextchange(String value) {
    typetext = value;
    notifyListeners();
    return value;
  }

  dynamic adddata(String type, String name, String description, double price,
      String imageurl) async {
    try {
      //dynamic fr = await FirebaseFirestore.instance;
      DocumentReference db = await FirebaseFirestore.instance
          .collection('retailprice')
          .add({
        'name': name,
        'description': description,
        'price': price,
        'imageurl': imageurl
      });
      db.update({'id': db.id});

      // await FirebaseFirestore.instance.collection('price').
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  dynamic addlogindata(double type, String name, String businuess, String email,
      int mobile) async {
    try {
      //dynamic fr = await FirebaseFirestore.instance;
      DocumentReference db =
          await FirebaseFirestore.instance.collection('loginrequest').add({
        'name': name,
        'businuess': businuess,
        'email': email,
        'mobile': mobile,
        'type': type,
        'approve': false,
        'comment': 'You are not varified by Admin yet'
      });
      db.update({'id': db.id});

      // await FirebaseFirestore.instance.collection('price').
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<User?> userdata() async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    await Firebase.initializeApp();
    User? user;
    try {
      user = _auth.currentUser;
    } catch (e) {
      print(e);
    }

    if (user != null) {
      QuerySnapshot<Map<String, dynamic>> data = await FirebaseFirestore
          .instance
          .collection('loginrequest')
          .where('email', isEqualTo: email)
          .get();
      auth = true;
      mobile = data.docs[0]['mobile'];
      uid = user.uid;
      username = data.docs[0]['name'];
      email = user.email!;
      imageUrl = user.photoURL!;

      type = data.docs[0]['type'];
      businuess = data.docs[0]['businuess'];

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('auth', true);
      prefs.setString('name', username!);
      prefs.setString('email', email!);
      prefs.setString('imageUrl', imageUrl!);
      prefs.setString('uid', uid!);
      prefs.setInt('mobile', mobile!);
      prefs.setInt('type', type!);
      prefs.setString('businuess', businuess!);
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.clear();
      prefs.setBool('auth', false);
    }
    notifyListeners();
    return user;
  }
}
