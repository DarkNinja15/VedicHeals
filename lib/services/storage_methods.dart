import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageMethods {
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // add image to firebase storage
  Future<String> uploadImageToStorage(String childname, Uint8List file) async {
    // create folder name childname and inside that created a folder of userid in which file is stored
    Reference ref =
        firebaseStorage.ref().child(childname).child(_auth.currentUser!.uid);

    // putting file in uid folder.
    UploadTask uploadTask = ref.putData(file);
    // await the uploadtask
    TaskSnapshot snap = await uploadTask;
    // getting downloadUrl
    String downloadUrl = (await snap.ref.getDownloadURL()).toString();
    return downloadUrl;
  }
}
