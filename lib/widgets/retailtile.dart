import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:saranfarms/models/product.dart';
import 'package:saranfarms/providers/authprovider.dart';
import 'package:saranfarms/providers/mainprovider.dart';

// ignore: must_be_immutable
class RetailTile extends StatelessWidget {
  Product pdt;
  String typecode;
  RetailTile(this.pdt, this.typecode, {Key? key}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? name, description, imageurl;
  double? price;

  @override
  Widget build(BuildContext context) {
    final hgt = MediaQuery.of(context).size.height;
    final wdth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Card(
            child: SizedBox(
          height: hgt * 0.45,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                    height: wdth * 0.1,
                    width: wdth * 0.2,
                    child: CachedNetworkImage(
                      imageUrl: pdt.imageUrl,
                      fit: BoxFit.cover,
                      placeholder: (_, value) =>
                          LoadingAnimationWidget.fourRotatingDots(
                        color: Colors.green,
                        size: 20,
                      ),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  pdt.title,
                  style: GoogleFonts.lato(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              //Text(description),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '₹ ' + pdt.price.toString(),
                  style: GoogleFonts.lato(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RaisedButton(
                    color: Colors.green,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Add to Cart',
                            style: GoogleFonts.lato(color: Colors.white),
                          ),
                          SizedBox(
                            width: wdth * 0.1,
                          ),
                          Text(
                            '+',
                            style: GoogleFonts.lato(
                                color: Colors.white, fontSize: 15),
                          )
                        ],
                      ),
                    ),
                    onPressed: () async {
                      bool _admin =
                          Provider.of<MainProvider>(context, listen: false)
                              .admin;
                      if (_admin) {
                        Provider.of<AuthProvider>(context, listen: false)
                            .pdtadddiag(context, true, typecode, pdt);
                      }
                    },
                    onLongPress: () {
                      bool _admin =
                          Provider.of<MainProvider>(context, listen: false)
                              .admin;
                      if (_admin) {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                                  title: const Text(
                                      'Do you really want to delete this product from server?'),
                                  content: ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('No, Please Cancel')),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Provider.of<MainProvider>(context,
                                                  listen: false)
                                              .deletepdt(pdt, typecode);
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text(
                                          'Yes, Delete it',
                                          style: TextStyle(color: Colors.red),
                                        )),
                                  ],
                                ));
                      } else {
                        //
                      }
                    },
                  ),
                ],
              )
            ],
          ),
        )),
      ],
    );
  }
}
