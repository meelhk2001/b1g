import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:saranfarms/widgets/imageforslider.dart';

class ImageSlider extends StatelessWidget {
  const ImageSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const url1 =
        'https://images.unsplash.com/photo-1654462809274-60a8391fd945?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80';
    const url2 =
        'https://images.unsplash.com/photo-1572455323333-6facea9b5169?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80';
    const url3 =
        'https://images.unsplash.com/photo-1602339752474-f77aa7bcaecd?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1173&q=80';

    return CarouselSlider(
      items: const [
        ImageForSlider(url1),
        ImageForSlider(url2),
        ImageForSlider(url3)
      ],

      //Slider Container properties
      options: CarouselOptions(
        height: MediaQuery.of(context).size.height * 0.907,
        enlargeCenterPage: true,
        autoPlay: true,
        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        viewportFraction: 1,
      ),
    );
  }
}

class WidgetSlider extends StatelessWidget {
  const WidgetSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream:
            FirebaseFirestore.instance.collection('slidingimages').snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          List<Widget> _image = [];
          if (snapshot.connectionState == ConnectionState.active) {
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              _image.add(ImageForSlider(snapshot.data!.docs[i]['link']));
            }
          }
          if (snapshot.hasData) {
            return CarouselSlider(
              items: [..._image],
              options: CarouselOptions(
                height: MediaQuery.of(context).size.height * 0.907,
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                viewportFraction: 1,
              ),
            );
          } else {
            return const CircularProgressIndicator();
          }
        }); //Slider Container properties
  }
}
