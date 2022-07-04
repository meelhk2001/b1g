import 'package:flutter/material.dart';

// ignore: must_be_immutable
class RetailTile extends StatelessWidget {
  String name = 'Item Name',
      description = 'Description',
      price = 'Price in INR',
      imageurl =
          'https://images.unsplash.com/photo-1624564529789-e9d219b826d5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=423&q=80';
  RetailTile(this.name, this.description, this.price, this.imageurl, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hgt = MediaQuery.of(context).size.height;
    final wdth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Container(
            height: hgt * 0.1,
            width: wdth,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.white.withOpacity(1),
                  width: 5,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(20))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.network(imageurl),
                Text(name),
                Text(description),
                Text(price + '  '),
              ],
            )),
        SizedBox(
          height: hgt * 0.01,
        )
      ],
    );
  }
}
