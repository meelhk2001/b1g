import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:saranfarms/providers/mainprovider.dart';
import 'package:saranfarms/widgets/appbar.dart';
import 'package:saranfarms/widgets/slider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    Provider.of<MainProvider>(context, listen: false).userdata();
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    final hgt = MediaQuery.of(context).size.height;
    final wdth = MediaQuery.of(context).size.width;
    // bool home = Provider.of<MainProvider>(context, listen: true).home;

    return Scaffold(
      appBar:
          PreferredSize(child: const Appbar(), preferredSize: Size(wdth, hgt)),
      body: SingleChildScrollView(
          child: Column(
        children: [
          const ImageSlider(),
          Container(
            width: wdth,
            height: hgt * 0.6,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'YOUR ACCOUNT',
                  style: GoogleFonts.lato(
                      color: Colors.green,
                      fontSize: 25,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: hgt * 0.04,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FlatButton(
                      onPressed: () {},
                      color: Colors.green,
                      child: const Text(
                        'Sign In',
                        style: TextStyle(color: Colors.white, letterSpacing: 1),
                      ),
                    ),
                    SizedBox(
                      width: wdth * 0.01,
                    ),
                    FlatButton(
                      onPressed: () {},
                      color: Colors.green,
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(color: Colors.white, letterSpacing: 1),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: hgt * 0.1,
                ),
                Text(
                  'ABOUT US',
                  style: GoogleFonts.lato(
                      color: Colors.green,
                      fontSize: 25,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: hgt * 0.04,
                ),
                SizedBox(
                  width: wdth * 0.8,
                  child: const Text(
                    'Since its inception, Buy One Gram has grown to become Jaipur’s largest retailer delivering superior value to its customers, suppliers and shareholders. Our' +
                        ' nationwide network of retail outlets delivers a world-class shopping environment and unmatched customer experience powered by our state-of-the-art technology and seamless' +
                        ' supply-chain infrastructure.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        letterSpacing: 0.6,
                        wordSpacing: 2,
                        fontSize: 16,
                        fontWeight: FontWeight.w100),
                  ),
                )
              ],
            ),
          ),
          Container(
            width: wdth,
            height: hgt * 0.44,
            color: Colors.black.withOpacity(0.05),
          ),
          Container(
            width: wdth,
            height: hgt * 0.058,
            color: Colors.green,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  '©' +
                      DateTime.now().year.toString() +
                      ' Buy One Gram. All rights reserved.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      letterSpacing: 0.6,
                      wordSpacing: 2,
                      fontSize: 16,
                      fontWeight: FontWeight.w100,
                      color: Colors.white),
                ),
                const Text(
                  'Privacy Policy',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      letterSpacing: 0.6,
                      wordSpacing: 2,
                      fontSize: 16,
                      fontWeight: FontWeight.w100,
                      color: Colors.white),
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}
