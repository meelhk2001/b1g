import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as fs;
import 'package:flutter/material.dart';

class GeneralProvider with ChangeNotifier {
  Future<void> addsupdateliderimage(String link, [String? id]) async {
    if (link.trim().toLowerCase() == 'delete') {
      await FirebaseFirestore.instance
          .collection('sliderimage')
          .doc(id)
          .delete();
    } else if (id == null) {
      var db = await FirebaseFirestore.instance
          .collection('sliderimage')
          .add({'imageurl': link, 'id': ''});
      await db.update({'id': db.id});
    } else {
      await FirebaseFirestore.instance
          .collection('sliderimage')
          .doc(id)
          .update({'imageurl': link});
    }
  }

  Future uploadsliderimage(BuildContext context, String name) async {
    // PickedFile? _image =
    //     await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    var _image = await FilePicker.platform.pickFiles(type: FileType.image);
    fs.Reference ref =
        fs.FirebaseStorage.instance.ref().child('slidingimage').child(name);

    Uint8List? imagebyte = _image!.files[0].bytes;
    fs.FirebaseStorage _storage =
        fs.FirebaseStorage.instanceFor(bucket: 'gs://saranfarms-m.appspot.com');

    fs.UploadTask ut;
    String filePath = 'slidingimages/$name.jpg';
    ut = _storage.ref().child(filePath).putData(imagebyte!);
    ut.whenComplete(() async {
      showDialog(
          context: context,
          builder: (ctx) => const AlertDialog(
                content: Text('Image Uploaded Successfully'),
              ));
      String link = await _storage.ref().child(filePath).getDownloadURL();
      var db = await FirebaseFirestore.instance
          .collection('slidingimages')
          .add({'name': name, 'link': link, 'id': ''});
      db.update({'id': db.id});
    });
  }

  Future deleteslidingimage(String docid, String name) async {
    String filePath = 'slidingimages/$name.jpg';
    try {
      fs.FirebaseStorage.instanceFor(bucket: 'gs://saranfarms-m.appspot.com')
          .ref()
          .child(filePath)
          .delete();
      await FirebaseFirestore.instance
          .collection('slidingimages')
          .doc(docid)
          .delete();
    } catch (e) {
      //
    }
  }
}
