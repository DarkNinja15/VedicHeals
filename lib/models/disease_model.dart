// ignore_for_file: unnecessary_null_in_if_null_operators

import 'dart:convert';

// ignore_for_file: non_constant_identifier_names

class DiseaseModel {
  final String id;
  final String Disease_Name;
  final dynamic Remidies;
  DiseaseModel({
    required this.id,
    required this.Disease_Name,
    required this.Remidies,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'Disease_Name': Disease_Name});
    result.addAll({'Remidies': Remidies});

    return result;
  }

  factory DiseaseModel.fromMap(Map<String, dynamic> map) {
    return DiseaseModel(
      id: map['id'] ?? '',
      Disease_Name: map['Disease_Name'] ?? '',
      Remidies: map['Remidies'] ?? null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DiseaseModel.fromJson(String source) =>
      DiseaseModel.fromMap(json.decode(source));
}
