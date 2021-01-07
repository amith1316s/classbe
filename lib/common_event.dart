import 'dart:io';

import 'package:classbe/domain/data.dart';
import 'package:classbe/domain/firestore_collection.dart';
import 'package:classbe/domain/user_profile.dart';
import 'package:classbe/screens/home/home_screen.dart';
import 'package:classbe/screens/profile/add_profile/add_profile_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class CommonEvent {
  static void isUserProfileInFirestore(BuildContext context) {
    User user = FirebaseAuth.instance.currentUser;
    String collection = FirestoreCollection.users;
    String doc = user.uid;
    FirebaseFirestore.instance
        .collection(collection)
        .doc(doc)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      Data _data = Data();
      if (documentSnapshot.exists) {
        _data.userProfile = UserProfile.fromFirestore(documentSnapshot.data());
        Navigator.pushNamed(context, HomeScreen.routeName, arguments: _data);
      } else {
        Navigator.pushNamed(context, AddProfileScreen.routeName,
            arguments: _data);
      }
    });
  }

  static Future<String> uploadFile(PickedFile _file, Data _data) async {
    FirebaseStorage _firebaseStorage =
        FirebaseStorage.instanceFor(bucket: "url here");
    var uid = _data.userProfile.uid;
    var image = _data.userProfile.uid + '.png';
    var ref = '$uid/profile/$image';

    await _firebaseStorage.ref(ref).putFile(File(_file.path));

    String downloadUrl = await _firebaseStorage.ref(ref).getDownloadURL();

    _data.userProfile.imageUrl = downloadUrl;

    String collection = FirestoreCollection.users;
    String doc = _data.userProfile.uid;

    await FirebaseFirestore.instance
        .collection(collection)
        .doc(doc)
        .update(_data.userProfile.toFirestore())
        .then((value) => {
              //TODO:
            })
        .catchError((error) => print("Failed to add profile image: $error"));

    return downloadUrl;
  }
}
