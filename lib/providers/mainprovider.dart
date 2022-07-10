import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:saranfarms/models/product.dart';
import 'package:saranfarms/screens/homescreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainProvider with ChangeNotifier {
  bool home = false;
  String typetext = 'I am a...';
  String? uid;
  String? username, businuess;
  String? email;
  String? imageUrl;
  int? mobile, type;
  bool auth = false, tryauth = true, admin = false;

  void authscreen() {
    home = !home;
    notifyListeners();
  }

  String typetextchange(String value) {
    typetext = value;
    notifyListeners();
    return value;
  }

  dynamic adddata(String name, String description, double price,
      String imageurl, String typecode) async {
    try {
      //dynamic fr = await FirebaseFirestore.instance;
      DocumentReference db =
          await FirebaseFirestore.instance.collection(typecode).add({
        'name': name,
        'description': description,
        'price': price,
        'imageurl': imageurl,
        'id': ''
      });
      db.update({'id': db.id});

      // await FirebaseFirestore.instance.collection('price').
      notifyListeners();
    } catch (e) {
      //
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
      //
    }
  }

  Future<User?> userdata() async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    User? user;
    try {
      user = _auth.currentUser;
      if (user != null) {
        auth = true;
        notifyListeners();
        if (user.email == 'meelhk2001@gmail.com') {
          admin = true;
          notifyListeners();
        }
      }
    } catch (_) {}
    await Firebase.initializeApp();

    try {
      user = _auth.currentUser;
    } catch (e) {
      //print(e);
    }

    if (user != null) {
      auth = true;
      if (user.email == 'meelhk2001@gmail.com') {
        admin = true;
        notifyListeners();
      }
      QuerySnapshot<Map<String, dynamic>> data = await FirebaseFirestore
          .instance
          .collection('loginrequest')
          .where('email', isEqualTo: email)
          .get();

      tryauth = false;
      notifyListeners();
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
      tryauth = false;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.clear();
      prefs.setBool('auth', false);
    }
    notifyListeners();
    return user;
  }

  void signout() async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    await Firebase.initializeApp();
    try {
      await _auth.signOut();
      admin = false;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.clear();
      prefs.setBool('auth', false);
      auth = false;
      notifyListeners();
    } catch (_) {}
  }

  void tryloading(BuildContext context) async {
    await Firebase.initializeApp();
    await userdata();
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => Home(auth),
    ));
  }

  Future<void> editpdt(Product pdt, String typecode) async {
    try {
      //dynamic fr = await FirebaseFirestore.instance;
      await FirebaseFirestore.instance.collection(typecode).doc(pdt.id).update({
        'name': pdt.title,
        'description': pdt.description,
        'price': pdt.price,
        'imageurl': pdt.imageUrl
      });

      // await FirebaseFirestore.instance.collection('price').
      notifyListeners();
    } catch (e) {
      //print(e.toString());
    }
  }

  Future<void> deletepdt(Product pdt, String typecode) async {
    try {
      await FirebaseFirestore.instance
          .collection(typecode)
          .doc(pdt.id)
          .delete();
    } catch (_) {}
  }
}
