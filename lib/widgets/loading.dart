import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:saranfarms/providers/mainprovider.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    Provider.of<MainProvider>(context, listen: false).tryloading(context);

    // setState(() {});
    //Provider.of<MainProvider>(context, listen: false).tryloading(context);
    return Scaffold(
      body: Center(
        child: LoadingAnimationWidget.fourRotatingDots(
          // leftDotColor: Colors.green,
          // rightDotColor: Colors.black12,
          color: Colors.green,
          // secondRingColor: Colors.black12,
          // thirdRingColor: Colors.black12,
          size: 100,
        ),
      ),
    );
  }
}
