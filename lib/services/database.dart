import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vedic_heals/models/blog_model.dart';
import 'package:vedic_heals/models/disease_model.dart';
import 'package:vedic_heals/provider/user_provider.dart';
import 'package:vedic_heals/services/storage_methods.dart';

class Database {
  // update user Profile
  Future<void> updateProfile({
    required String name,
    required String phoneNo,
    required String age,
    required String dob,
    required Uint8List image,
    required BuildContext context,
  }) async {
    try {
      String userId =
          Provider.of<UserProvider>(context, listen: false).getUser.id;
      String photoUrl = await StorageMethods().uploadImageToStorage(
        'profilePics',
        image,
      );
      await FirebaseFirestore.instance
          .collection('AppUsers')
          .doc(userId)
          .update({
        'name': name,
        'phoneNo': phoneNo,
        'age': age,
        'dob': dob,
        'avatar': photoUrl,
      }).then(
        (value) async {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Changes Saved!!',
              ),
            ),
          );
          await Provider.of<UserProvider>(context, listen: false).refreshUser();
        },
      );
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }
  }

  // retrive diseases
  Stream<List<DiseaseModel>> get diseases {
    return FirebaseFirestore.instance
        .collection('diseases')
        .snapshots()
        .map((QuerySnapshot querySnapshot) => querySnapshot.docs
            .map(
              (DocumentSnapshot documentSnapshot) => DiseaseModel(
                id: (documentSnapshot.data()! as Map<String, dynamic>)['id'],
                Disease_Name: (documentSnapshot.data()!
                    as Map<String, dynamic>)['Disease_Name'],
                Remidies: (documentSnapshot.data()!
                    as Map<String, dynamic>)['Remidies'],
              ),
            )
            .toList());
  }

  // retrive blogs
  Stream<List<BlogModel>> get bolgs {
    return FirebaseFirestore.instance
        .collection('Blogs')
        .snapshots()
        .map((QuerySnapshot querySnapshot) => querySnapshot.docs
            .map(
              (DocumentSnapshot documentSnapshot) => BlogModel(
                heading: (documentSnapshot.data()!
                    as Map<String, dynamic>)['heading'],
                desc:
                    (documentSnapshot.data()! as Map<String, dynamic>)['desc'],
                image:
                    (documentSnapshot.data()! as Map<String, dynamic>)['image'],
              ),
            )
            .toList());
  }
}
