import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String phoneNo;
  final String age;
  final String avatar;
  final String city;
  final String country;
  final String dob;
  final String gender;
  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNo,
    required this.age,
    required this.avatar,
    required this.city,
    required this.country,
    required this.dob,
    required this.gender,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'email': email});
    result.addAll({'phoneNo': phoneNo});
    result.addAll({'age': age});
    result.addAll({'avatar': avatar});
    result.addAll({'city': city});
    result.addAll({'country': country});
    result.addAll({'dob': dob});
    result.addAll({'gender': gender});

    return result;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phoneNo: map['phoneNo'] ?? '',
      age: map['age'] ?? '',
      avatar: map['avatar'] ?? '',
      city: map['city'] ?? '',
      country: map['country'] ?? '',
      dob: map['dob'] ?? '',
      gender: map['gender'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  static UserModel fromSnap(DocumentSnapshot snap) {
    Map<String, dynamic> snapshot = snap.data() as Map<String, dynamic>;
    return UserModel(
      id: snapshot['id'] ?? "",
      name: snapshot['name'] ?? "",
      email: snapshot['email'] ?? "",
      phoneNo: snapshot['phoneNo'] ?? "",
      age: snapshot['age'] ?? "",
      avatar: snapshot['avatar'] ?? "",
      city: snapshot['city'] ?? "",
      country: snapshot['country'] ?? "",
      dob: snapshot['dob'] ?? "",
      gender: snapshot['gender'] ?? "",
    );
  }
}
