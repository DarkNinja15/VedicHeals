// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Color bottomNavBarColor = Colors.transparent;

const textColor = Color.fromRGBO(150, 222, 191, 1);

const errorColor = Colors.red;

imagepicker(ImageSource source) async {
  ImagePicker imagePicker = ImagePicker();
  XFile? _file = await imagePicker.pickImage(
    source: source,
  );
  if (_file != null) {
    return await _file.readAsBytes();
  }
  if (kDebugMode) {
    print('No Image Selected');
  }
}

// const bottomNavBarColor = LinearGradient(
//   colors: [
//     Colors.white,
//     Colors.black,
//   ],
//   stops: [0.5, 1.0],
// );
// const Color bottomNavBarColor = Color.fromRGBO(188, 229, 203, 1);
