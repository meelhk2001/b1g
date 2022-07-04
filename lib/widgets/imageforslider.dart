import 'package:flutter/material.dart';

class ImageForSlider extends StatelessWidget {
  final String url;
  // ignore: use_key_in_widget_constructors
  const ImageForSlider(this.url);

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.all(6.0),
      decoration: BoxDecoration(
          //borderRadius: BorderRadius.circular(8.0),
          image: DecorationImage(image: NetworkImage(url), fit: BoxFit.cover)),
    );
  }
}
