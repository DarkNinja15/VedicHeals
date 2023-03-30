// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:vedic_heals/screens/auth%20Screens/signin_page.dart';
import 'package:vedic_heals/services/auth_service.dart';

import '../../constants/global_variables.dart';
import 'package:vedic_heals/widgets/customTextField.dart';
import 'package:vedic_heals/widgets/custom_button.dart';
import 'package:vedic_heals/widgets/loading.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
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
          'VedicHeals',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: textColor,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Image(
                    image: AssetImage(
                      'assets/images/ayurLogo.png',
                    ),
                    fit: BoxFit.cover,
                  ),
                  const Text(
                    'Sign Up Here',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    hintText: 'Rahul',
                    isObscure: false,
                    labelText: 'Name',
                    textInputType: TextInputType.text,
                    controller: nameController,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    hintText: 'example@gmail.com',
                    isObscure: false,
                    labelText: 'Email',
                    textInputType: TextInputType.emailAddress,
                    controller: emailController,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    hintText: 'password@123',
                    isObscure: true,
                    labelText: 'Password',
                    textInputType: TextInputType.visiblePassword,
                    controller: passwordController,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          isLoading = true;
                        });
                        await AuthService()
                            .signUpUserEmailandPassword(
                          name: nameController.text.trim(),
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),
                          context: context,
                        )
                            .then((value) {
                          setState(() {
                            isLoading = false;
                          });
                        });
                      }
                    },
                    child: isLoading
                        ? const Loading()
                        : const CustomButton(
                            text: 'Sign Up',
                          ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already a User? '),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const SignInScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          'LogIn here',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            width: 0.5,
                          ),
                          borderRadius: BorderRadius.circular(25)),
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: 30,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/Google.png',
                            width: 20,
                          ),
                          const Text(
                            '   Sign Up With Google',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
