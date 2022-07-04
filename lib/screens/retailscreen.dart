import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saranfarms/providers/mainprovider.dart';
import 'package:saranfarms/widgets/appbar.dart';
import 'package:saranfarms/widgets/retailtile.dart';

class RetailScreen extends StatefulWidget {
  const RetailScreen({Key? key}) : super(key: key);

  @override
  State<RetailScreen> createState() => _RetailScreenState();
}

class _RetailScreenState extends State<RetailScreen> {
  @override
  Widget build(BuildContext context) {
    final hgt = MediaQuery.of(context).size.height;
    final wdth = MediaQuery.of(context).size.width;
    bool RetailScreen = Provider.of<MainProvider>(context, listen: true).home;
    return Scaffold(
      appBar: PreferredSize(
        child: Appbar(),
        preferredSize: Size(wdth, hgt),
      ),
      body: SingleChildScrollView(
        child: Retail(),
      ),
    );
  }
}

class Retail extends StatefulWidget {
  Retail({Key? key}) : super(key: key);

  @override
  State<Retail> createState() => _RetailState();
}

class _RetailState extends State<Retail> {
  String name = 'Moong Daal',
      description = 'Eat and Enjoy',
      price = '92 INR',
      imageurl =
          'https://images.unsplash.com/photo-1624564529789-e9d219b826d5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=423&q=80';

  int length = 3;
  CollectionReference dbd =
      FirebaseFirestore.instance.collection('retailprice');

  @override
  void initState() {
    dynamic db = FirebaseFirestore.instance
        .collection('retailprice')
        .snapshots()
        .length
        .whenComplete(() => null);
    // length = await db.length;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final hgt = MediaQuery.of(context).size.height;
    final wdth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Column(
        children: [
          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection('retailprice')
                  .snapshots(),
              builder: (context, snapshot) {
                return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: snapshot.connectionState ==
                            ConnectionState.active
                        ? snapshot.data?.docs.length
                        : 0,
                    itemBuilder: ((context, index) =>
                        snapshot.connectionState == ConnectionState.waiting
                            ? const CircularProgressIndicator()
                            : RetailTile(
                                snapshot.data?.docs[index]['name'] ?? name,
                                snapshot.data?.docs[index]['description'] ??
                                    description,
                                snapshot.data?.docs[index]['price']
                                        .toString() ??
                                    price,
                                snapshot.data?.docs[index]['imageurl'] ??
                                    imageurl)));
              }),
        ],
      ),
    );
  }
}
