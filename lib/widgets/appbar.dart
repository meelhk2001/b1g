import 'package:flutter/material.dart';
import 'package:saranfarms/screens/homescreen.dart';
import 'package:saranfarms/widgets/buttonmain.dart';

class Appbar extends StatelessWidget {
  const Appbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 1,
      child: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height * 0.093,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () =>
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                //settings: RouteSettings(),
                fullscreenDialog: true,
                builder: (context) => const Home(),
              )),
              child: Image.asset('assets/bog.png'),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.25,
            ),
            ButtonMain('Your Profile', true, 0),
            ButtonMain('Price Index', false, 1),
            ButtonMain('Admin Page', false, 2)
          ],
        ),
      ),
    );
  }
}
