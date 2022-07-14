import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:saranfarms/providers/generalprovider.dart';
import 'package:saranfarms/screens/adminscreens/customerrequest.dart';

class Admin extends StatefulWidget {
  // static State<StatefulWidget>? of(BuildContext context) =>
  //     context.findAncestorStateOfType<_AdminState>();
  //(const TypeMatcher<_AdminState>());
  const Admin({Key? key}) : super(key: key);

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  double progress = 0;
  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 4);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hgt = MediaQuery.of(context).size.height;
    final wdth = MediaQuery.of(context).size.width;
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    String name = 'name',
        //content = 'content',
        imageurl = 'https://bit.ly/3NduB8J',
        description = 'description';
    double price = 0;

    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Welcome Admin',
            style: GoogleFonts.lato(fontSize: 20, color: Colors.white),
          ),
          leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop()),
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(
                icon: Icon(FontAwesomeIcons.home),
                text: 'Home Page',
              ),
              Tab(
                icon: Icon(FontAwesomeIcons.universalAccess),
                text: 'Custmer Requests',
              ),
              Tab(
                icon: Icon(Icons.import_export),
                text: 'Exporters and wholesellers',
              ),
              Tab(
                icon: Icon(Icons.factory),
                text: 'Manufacturers and Factories',
              ),
            ],
          )),
      body: TabBarView(
        controller: _tabController,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton.icon(
                  icon: const Icon(FontAwesomeIcons.plus),
                  label: Text(
                    'upload an image for Slide',
                    style: GoogleFonts.lato(fontSize: 20, color: Colors.black),
                  ),
                  onPressed: () async {
                    await Provider.of<GeneralProvider>(context, listen: false)
                        .uploadsliderimage(context,
                            DateTime.now().millisecondsSinceEpoch.toString());
                  }),
              StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection('slidingimages')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  return Flexible(
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount:
                            snapshot.connectionState == ConnectionState.active
                                ? snapshot.data!.docs.length
                                : 0,
                        itemBuilder: (context, index) => Column(
                              children: [
                                SizedBox(
                                  height: hgt * 0.7,
                                  child: CachedNetworkImage(
                                    imageUrl: snapshot.data!.docs[index]
                                        ['link'],
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      Provider.of<GeneralProvider>(context,
                                              listen: false)
                                          .deleteslidingimage(
                                              snapshot.data!.docs[index]['id'],
                                              snapshot.data!.docs[index]
                                                  ['name']);
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Text('Delete'),
                                      ],
                                    )),
                                const Divider(
                                  thickness: 1,
                                  color: Colors.black,
                                ),
                                SizedBox(
                                  height: hgt * 0.1,
                                )
                              ],
                            )),
                  );
                },
              )
            ],
          ),
          CustomerRequest(),
          const Center(),
          const Center()
        ],
      ),
    );
  }
}
