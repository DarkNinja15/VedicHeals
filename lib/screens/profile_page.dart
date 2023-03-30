import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vedic_heals/models/user_model.dart';
import 'package:vedic_heals/provider/user_provider.dart';
import 'package:vedic_heals/screens/auth%20Screens/signup_page.dart';
import 'package:vedic_heals/screens/edit_profile_page.dart';
import 'package:vedic_heals/services/auth_service.dart';
import 'package:vedic_heals/widgets/custom_button.dart';
import 'package:vedic_heals/widgets/loading.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import '../constants/global_variables.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isLoading = false;
  late UserModel userModel;
  @override
  void initState() {
    isLoading = true;

    super.initState();
  }

  @override
  void didChangeDependencies() {
    userModel = Provider.of<UserProvider>(context).getUser;
    isLoading = false;
    if (kDebugMode) {
      print(userModel);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Image(
          image: AssetImage(
            'assets/images/ayurLogo.png',
          ),
          fit: BoxFit.cover,
        ),
        title: const Text(
          'Your Profile',
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Card(
                        color: textColor,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                userModel.avatar == ""
                                    ? const CircleAvatar(
                                        radius: 64,
                                        backgroundImage: AssetImage(
                                          'assets/images/yoga.png',
                                        ),
                                      )
                                    : CircleAvatar(
                                        radius: 64,
                                        backgroundImage: NetworkImage(
                                          userModel.avatar,
                                        ),
                                      ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          const Text(
                                            "Name: ",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Expanded(
                                            child: Text(
                                              userModel.name == ""
                                                  ? "Data Unavailable"
                                                  : userModel.name,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            "Email: ",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Expanded(
                                            child: Text(
                                              userModel.email == ""
                                                  ? "Data Unavailable"
                                                  : userModel.email,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            "Phone: ",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Expanded(
                                            child: Text(
                                              userModel.phoneNo == ""
                                                  ? "Data Unavailable"
                                                  : userModel.phoneNo,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const EditProfilePage(),
                            ),
                          );
                        },
                        child: const CustomButton(
                          text: 'Edit Profile',
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          AwesomeDialog(
                            dismissOnTouchOutside: true,
                            context: context,
                            btnOkOnPress: () async {
                              await AuthService().logOut(context).then((value) {
                                Navigator.of(context).pop();
                              }).then(
                                (value) {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const SignUpScreen(),
                                    ),
                                  );
                                },
                              );
                            },
                            btnCancelOnPress: () {},
                            animType: AnimType.leftSlide,
                            btnOkColor: textColor,
                            btnCancelColor: Colors.grey,
                            buttonsTextStyle: const TextStyle(
                              color: Colors.black,
                            ),
                            dialogType: DialogType.question,
                            headerAnimationLoop: false,
                            title:
                                'Are You sure you want to Log out of the app?',
                          ).show();
                        },
                        child: const CustomButton(
                          text: 'Log Out',
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(),
                      const Text(
                        'Quote of the Day',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
