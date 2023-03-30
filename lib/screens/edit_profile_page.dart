// ignore_for_file: no_leading_underscores_for_local_identifiers, use_build_context_synchronously, non_constant_identifier_names
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vedic_heals/models/user_model.dart';
import 'package:vedic_heals/provider/user_provider.dart';
import 'package:vedic_heals/services/database.dart';
import 'package:vedic_heals/widgets/customTextField.dart';
import 'package:vedic_heals/widgets/custom_button.dart';
import 'package:vedic_heals/widgets/loading.dart';
import 'package:intl/intl.dart';
import '../constants/global_variables.dart';
import 'package:image_picker/image_picker.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool setData = true;
  bool isLoadingSaved = false;
  String selectedDate = "";
  late UserModel user;
  String url = 'https://cdn-icons-png.flaticon.com/512/3135/3135715.png';
  Uint8List? _pickedImage;
  @override
  void initState() {
    isLoading = true;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    user = Provider.of<UserProvider>(context, listen: false).getUser;

    isLoading = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    nameController.dispose();
    dateController.dispose();
    ageController.dispose();
    phoneController.dispose();
    emailController.dispose();
    super.dispose();
  }

  void chooseImage0() async {
    Uint8List im = await imagepicker(ImageSource.camera);
    setState(() {
      _pickedImage = im;
    });
    Navigator.of(context).pop();
  }

  void chooseImage1() async {
    Uint8List im = await imagepicker(ImageSource.gallery);
    setState(() {
      _pickedImage = im;
    });
    Navigator.of(context).pop();
  }

  void showForm(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      elevation: 5,
      isScrollControlled: true,
      builder: (_) => Container(
        padding: EdgeInsets.only(
          top: 15,
          left: 15,
          right: 15,
          // this will prevent the soft keyboard from covering the text fields
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Center(
              child: GestureDetector(
                onTap: () {
                  chooseImage0();
                },
                child: Container(
                  margin: const EdgeInsets.all(10),
                  height: 35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: textColor,
                  ),
                  child: const Center(
                      child: Text(
                    'Open Camera',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                ),
              ),
            ),
            const Divider(
              thickness: 1.5,
              height: 15,
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  chooseImage1();
                },
                child: Container(
                  margin: const EdgeInsets.all(10),
                  height: 35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: textColor,
                  ),
                  child: const Center(
                      child: Text(
                    'Choose from Gallery',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1940, 8),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: textColor, // header background color
              onPrimary: Colors.black, // header text color
              onSurface: Colors.black, // body text color
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      dateController.text =
          (DateFormat('yyyy-MM-dd').format(picked)).toString();
      int age = DateTime.now().year - picked.year;
      int month1 = DateTime.now().month;
      int month2 = picked.month;
      if (month2 > month1) {
        age--;
      } else if (month1 == month2) {
        int day1 = DateTime.now().day;
        int day2 = picked.day;
        if (day2 > day1) {
          age--;
        }
      }
      ageController.text = age.toString();
      if (kDebugMode) {
        print(selectedDate);
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (setData) {
      nameController.text = user.name;
      phoneController.text = user.phoneNo;
      emailController.text = user.email;
      ageController.text = user.age;
      dateController.text = user.dob;
      setData = false;
    }
    return Scaffold(
      appBar: AppBar(
        leading: const Image(
          image: AssetImage(
            'assets/images/ayurLogo.png',
          ),
          fit: BoxFit.cover,
        ),
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: textColor,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
      ),
      body: isLoading
          ? const Loading()
          : SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            user.avatar != ""
                                ? CircleAvatar(
                                    radius: 64,
                                    backgroundImage: NetworkImage(
                                      user.avatar,
                                    ),
                                  )
                                : _pickedImage == null
                                    ? const CircleAvatar(
                                        radius: 64,
                                        backgroundImage: AssetImage(
                                          'assets/images/yoga.png',
                                        ),
                                      )
                                    : CircleAvatar(
                                        radius: 64,
                                        backgroundImage: MemoryImage(
                                          _pickedImage!,
                                        ),
                                      ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  showForm(context);
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: CustomButton(
                                    text: 'Change Profile Pic',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                          labelText: 'Email',
                          hintText: 'example@gmail.com',
                          isObscure: false,
                          textInputType: TextInputType.emailAddress,
                          controller: emailController,
                          isEnabled: false,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                          labelText: 'Name',
                          hintText: 'Rahul',
                          isObscure: false,
                          textInputType: TextInputType.text,
                          controller: nameController,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                          labelText: 'Phone Number',
                          hintText: '123456789',
                          isObscure: false,
                          textInputType: TextInputType.phone,
                          controller: phoneController,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                labelText: 'Age',
                                hintText: '23',
                                isObscure: false,
                                textInputType: TextInputType.number,
                                isEnabled: false,
                                controller: ageController,
                              ),
                            ),
                            Expanded(
                              child: CustomTextField(
                                labelText: 'DOB',
                                hintText: '23-12-1999',
                                isObscure: false,
                                isEnabled: false,
                                textInputType: TextInputType.number,
                                controller: dateController,
                              ),
                            ),
                            Expanded(
                              child: IconButton(
                                onPressed: () {
                                  _selectDate(context);
                                },
                                icon: const Icon(
                                  Icons.date_range,
                                ),
                                color: textColor,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        isLoadingSaved
                            ? const Loading()
                            : GestureDetector(
                                onTap: () async {
                                  setState(() {
                                    isLoadingSaved = true;
                                  });
                                  if (_pickedImage == null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Pick an image',
                                        ),
                                      ),
                                    );
                                    setState(() {
                                      isLoadingSaved = false;
                                    });
                                    return;
                                  }
                                  if (_formKey.currentState!.validate()) {
                                    await Database().updateProfile(
                                      name: nameController.text.trim(),
                                      phoneNo: phoneController.text.trim(),
                                      age: ageController.text.trim(),
                                      dob: dateController.text.trim(),
                                      image: _pickedImage!,
                                      context: context,
                                    );
                                  }
                                  setState(() {
                                    isLoadingSaved = false;
                                  });
                                },
                                child: const CustomButton(
                                  text: 'Save Changes',
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
