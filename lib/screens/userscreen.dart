// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:saranfarms/providers/mainprovider.dart';
import 'package:saranfarms/screens/homescreen.dart';
import 'package:saranfarms/widgets/appbar.dart';

// ignore: must_be_immutable
class UserScreen extends StatelessWidget {
  UserScreen({Key? key}) : super(key: key);
  String? uid;
  String? username;
  String? email;
  String? imageUrl, businuess;
  int? mobile, type;
  @override
  Widget build(BuildContext context) {
    final hgt = MediaQuery.of(context).size.height;
    final wdth = MediaQuery.of(context).size.width;
    uid;

    username = Provider.of<MainProvider>(context, listen: false).username;
    email = Provider.of<MainProvider>(context, listen: false).email;
    imageUrl = Provider.of<MainProvider>(context, listen: false).imageUrl;
    mobile = Provider.of<MainProvider>(context, listen: false).mobile;
    type = Provider.of<MainProvider>(context, listen: false).type;
    businuess = Provider.of<MainProvider>(context, listen: false).businuess;
    return Scaffold(
        appBar: PreferredSize(
          child: const Appbar(),
          preferredSize: Size(wdth, hgt),
        ),
        body: Stack(
          children: [
            SizedBox(
              height: hgt,
              width: wdth,
              child: const Image(
                  image: NetworkImage(
                      'https://images.unsplash.com/photo-1511537190424-bbbab87ac5eb?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80'),
                  fit: BoxFit.fitWidth),
            ),
            Center(
              child: SizedBox(
                width: wdth * 0.4,
                height: hgt * 0.4,
                child: Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage: const AssetImage('assets/bog.png'),
                        child: CircleAvatar(
                            backgroundColor: Colors.green.withOpacity(0),
                            backgroundImage: NetworkImage(
                                Provider.of<MainProvider>(context,
                                        listen: false)
                                    .imageUrl
                                    .toString())),
                      ),
                      Text(username!,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.openSans(
                              letterSpacing: 0.6,
                              wordSpacing: 2,
                              fontSize: 16,
                              fontWeight: FontWeight.w400)),
                      Text(businuess!,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.openSans(
                              letterSpacing: 0.6,
                              wordSpacing: 2,
                              fontSize: 16,
                              fontWeight: FontWeight.w400)),
                      Text(email!,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.openSans(
                              letterSpacing: 0.6,
                              wordSpacing: 2,
                              fontSize: 16,
                              fontWeight: FontWeight.w400)),
                      Text(mobile.toString(),
                          textAlign: TextAlign.center,
                          style: GoogleFonts.openSans(
                              letterSpacing: 0.6,
                              wordSpacing: 2,
                              fontSize: 16,
                              fontWeight: FontWeight.w400)),
                      Text(
                        type == 1
                            ? 'Retailer'
                            : type == 2
                                ? 'Exporter'
                                : type == 3
                                    ? 'Producer'
                                    : type == 4
                                        ? 'MANUFACTURER'
                                        : 'Happy Customer',
                        style: const TextStyle(
                            letterSpacing: 2, color: Colors.green),
                      ),
                      RaisedButton(
                        onPressed: () {
                          Provider.of<MainProvider>(context, listen: false)
                              .signout();
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  fullscreenDialog: true,
                                  builder: (context) => Home(
                                      Provider.of<MainProvider>(context,
                                              listen: false)
                                          .auth)));
                        },
                        color: Colors.green,
                        child: const Text(
                          'Sign Out',
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
