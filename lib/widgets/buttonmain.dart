import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:saranfarms/providers/mainprovider.dart';
import 'package:saranfarms/screens/adminscreen.dart';
import 'package:saranfarms/screens/authscreen.dart';
import 'package:saranfarms/screens/homescreen.dart';
import 'package:saranfarms/screens/retailscreen.dart';
import 'package:saranfarms/screens/userscreen.dart';

class ButtonMain extends StatefulWidget {
  final String text;
  bool hover;
  double code;
  ButtonMain(this.text, this.hover, this.code, {Key? key}) : super(key: key);

  @override
  State<ButtonMain> createState() => _ButtonMainState();
}

class _ButtonMainState extends State<ButtonMain> {
  @override
  //bool hover = false;
  Widget build(BuildContext context) {
    bool auth = Provider.of<MainProvider>(context).auth;
    Function authscreen =
        Provider.of<MainProvider>(context, listen: true).authscreen;
    return MouseRegion(
      child: GestureDetector(
        child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(widget.text,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.openSans(
                        letterSpacing: 0.6,
                        wordSpacing: 2,
                        fontSize: 16,
                        fontWeight: FontWeight.w400)),
              ],
            ),
            //width: MediaQuery.of(context).size.width * 0.10,
            height: double.maxFinite,
            color: widget.hover ? Colors.green : Colors.white),
        onTap: () {
          if (widget.code == 0) {
            if (auth) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (context) => UserScreen(),
                ),
              );
            } else {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (context) => const AuthScreen(),
                ),
              );
            }
          } else if (widget.code == 1) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              fullscreenDialog: true,
              builder: (context) => const RetailScreen(),
            ));
          } else if (widget.code == 2) {
            Navigator.of(context).push(MaterialPageRoute(
              fullscreenDialog: true,
              builder: (context) => const Admin(),
            ));
          }
          authscreen;
        },
      ),
      onEnter: (details) {},
      onHover: (details) {
        setState(() {
          widget.hover = true;
        });
      },
      onExit: (details) {
        setState(() {
          widget.hover = widget.code < 1 ? true : false;
        });
      },
      cursor: SystemMouseCursors.click,
    );
  }
}
