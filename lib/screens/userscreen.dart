import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:saranfarms/providers/mainprovider.dart';
import 'package:saranfarms/widgets/appbar.dart';

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
        body: Center(
          child: SizedBox(
            width: wdth * 0.4,
            height: hgt * 0.4,
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/bog.png'),
                    child: CircleAvatar(
                        //backgroundColor: Colors.green,

                        backgroundImage: NetworkImage(
                            Provider.of<MainProvider>(context, listen: false)
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
                  RaisedButton(
                    onPressed: () {},
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
        ));
  }
}
