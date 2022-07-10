import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saranfarms/models/product.dart';
import 'package:saranfarms/providers/authprovider.dart';
import 'package:saranfarms/providers/mainprovider.dart';
import 'package:saranfarms/widgets/appbar.dart';
import 'package:saranfarms/widgets/retailtile.dart';

// ignore: must_be_immutable
class RetailScreen extends StatefulWidget {
  String typecode;
  RetailScreen(this.typecode, {Key? key}) : super(key: key);

  @override
  State<RetailScreen> createState() => _RetailScreenState();
}

class _RetailScreenState extends State<RetailScreen> {
  late String name, description, price, imageurl, search = '';

  @override
  Widget build(BuildContext context) {
    final hgt = MediaQuery.of(context).size.height;
    final wdth = MediaQuery.of(context).size.width;
    //bool RetailScreen = Provider.of<MainProvider>(context, listen: true).home;
    return Scaffold(
      appBar: PreferredSize(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Appbar(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Provider.of<MainProvider>(context).admin
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                Provider.of<AuthProvider>(context,
                                        listen: false)
                                    .pdtadddiag(
                                        context, false, widget.typecode);
                              },
                              child: const Text('Add Product')),
                          TextButton(
                              onPressed: () {}, child: const Text('Retail')),
                          TextButton(
                              onPressed: () {}, child: const Text('Farm')),
                          TextButton(
                              onPressed: () {}, child: const Text('EX-IM')),
                          TextButton(
                              onPressed: () {}, child: const Text('Manuf.')),
                          SizedBox(
                            width: wdth / 100,
                          )
                        ],
                      )
                    : const SizedBox(),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(40))),
                  padding: const EdgeInsets.only(left: 8),
                  width: wdth * 0.3,
                  child: TextField(
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search products name here',
                        suffixIcon: Icon(Icons.search)),
                    onChanged: (value) {
                      search = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            )
          ],
        ),
        preferredSize: Size(wdth, hgt),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection(widget.typecode)
              .orderBy('name')
              .snapshots(),
          builder: (context, snapshot) {
            List<Product> dataji = [];

            if (snapshot.connectionState == ConnectionState.active) {
              for (int i = 0; i < snapshot.data!.docs.length; i++) {
                String? s1 =
                    snapshot.data?.docs[i]['name'].toString().toLowerCase();
                if (search != '' && s1!.contains(search.toLowerCase())) {
                  print(search);
                  dataji.add(Product(
                      id: snapshot.data!.docs[i]['id'],
                      title: snapshot.data!.docs[i]['name'],
                      description: snapshot.data!.docs[i]['description'],
                      imageUrl: snapshot.data!.docs[i]['imageurl'],
                      price: snapshot.data!.docs[i]['price']));
                  //dataji.add();
                } else if (search == '') {
                  dataji.add(Product(
                      id: snapshot.data!.docs[i]['id'],
                      title: snapshot.data!.docs[i]['name'],
                      description: snapshot.data!.docs[i]['description'],
                      imageUrl: snapshot.data!.docs[i]['imageurl'],
                      price: snapshot.data!.docs[i]['price']));
                }
              }
            }

            return GridView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: snapshot.connectionState == ConnectionState.active
                  ? dataji.length
                  : 0,
              itemBuilder: ((context, index) =>
                  snapshot.connectionState == ConnectionState.waiting
                      ? const CircularProgressIndicator()
                      : RetailTile(dataji[index], widget.typecode)),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: wdth * 0.2, mainAxisExtent: hgt * 0.5),
            );
          }),
      //floatingActionButton: FloatingActionButton(onPressed: () {}),
    );
  }
}
