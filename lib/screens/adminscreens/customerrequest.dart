import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:saranfarms/providers/mainprovider.dart';

// ignore: must_be_immutable
class CustomerRequest extends StatelessWidget {
  CustomerRequest({Key? key}) : super(key: key);
  //String? username, businuess, email;
  //int? type, mobile;
  List<String> type = [
    'Happy Customer',
    'Retailer',
    'Exporter',
    'Producer',
    'MANUFACTURER'
  ];
  @override
  Widget build(BuildContext context) {
    final hgt = MediaQuery.of(context).size.height;
    final wdth = MediaQuery.of(context).size.width;
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('loginrequest')
            .where('approve', isEqualTo: false)
            .snapshots(),
        builder: ((context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: wdth * 0.2, mainAxisExtent: hgt * 0.5),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: snapshot.connectionState == ConnectionState.active
                ? snapshot.data!.docs.length
                : 0,
            itemBuilder: (context, index) => SizedBox(
              width: wdth * 0.4,
              height: hgt * 0.4,
              child: Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircleAvatar(
                        backgroundColor: Colors.white,
                        //backgroundImage: AssetImage('assets/bog.png'),
                        child: IconButton(
                          icon: const Icon(Icons.delete_forever_rounded,
                              color: Colors.red),
                          onPressed: () {
                            Provider.of<MainProvider>(context, listen: false)
                                .deleteuser(snapshot.data!.docs[index]['id']);
                          },
                        )),
                    Text(snapshot.data!.docs[index]['name'],
                        textAlign: TextAlign.center,
                        style: GoogleFonts.openSans(
                            letterSpacing: 0.6,
                            wordSpacing: 2,
                            fontSize: 16,
                            fontWeight: FontWeight.w400)),
                    Text(snapshot.data!.docs[index]['businuess'],
                        textAlign: TextAlign.center,
                        style: GoogleFonts.openSans(
                            letterSpacing: 0.6,
                            wordSpacing: 2,
                            fontSize: 16,
                            fontWeight: FontWeight.w400)),
                    Text(snapshot.data!.docs[index]['email'],
                        textAlign: TextAlign.center,
                        style: GoogleFonts.openSans(
                            letterSpacing: 0.6,
                            wordSpacing: 2,
                            fontSize: 16,
                            fontWeight: FontWeight.w400)),
                    Text(snapshot.data!.docs[index]['mobile'].toString(),
                        textAlign: TextAlign.center,
                        style: GoogleFonts.openSans(
                            letterSpacing: 0.6,
                            wordSpacing: 2,
                            fontSize: 16,
                            fontWeight: FontWeight.w400)),
                    Text(
                      type[snapshot.data!.docs[index]['type']],
                      style: const TextStyle(
                          letterSpacing: 2, color: Colors.green),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Provider.of<MainProvider>(context, listen: false)
                            .deleteuser(snapshot.data!.docs[index]['id']);
                        Provider.of<MainProvider>(context, listen: false)
                            .approveuser(snapshot.data!.docs[index]['id']);
                        // Navigator.of(context).pushReplacement(
                        //     MaterialPageRoute(
                        //         fullscreenDialog: true,
                        //         builder: (context) => Home(
                        //             Provider.of<MainProvider>(context,
                        //                     listen: false)
                        //                 .auth)));
                      },
                      child: const Text(
                        'Approve',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }));
  }
}
