import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:to_do_application/core/widgets/custom_text_form_field.dart';
import 'package:to_do_application/pages/register/register_screen.dart';

import '../../core/services/snackbar_service.dart';
import '../../layout/home_layout.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const String routeName = "login";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isVisable = true;
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var local = AppLocalizations.of(context)!;
    return Container(
      decoration: BoxDecoration(
          color: theme.colorScheme.background,
          image: const DecorationImage(
            image: AssetImage("assets/images/login_pattern.png"),
            fit: BoxFit.cover,
          )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          centerTitle: true,
            backgroundColor: Colors.transparent,
            title: Text(
              local.login,
            style: theme.textTheme.titleLarge,
          ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.15),
                    Text(
                      local.welcome_back,
                    textAlign: TextAlign.start,
                    style: theme.textTheme.titleLarge!.copyWith(
                      color: Colors.black,
                    ),
                  ),
                    const SizedBox(height: 40),
                    CustomTextFormField(
                      controller: emailController,
                    labelText: local.email,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return local.you_must_enter_your_email;
                      }
                      var regex = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                      if (!regex.hasMatch(value)) {
                        return local.invalid_email;
                      }
                      return null;
                    },
                    ),
                    const SizedBox(height: 20),
                    CustomTextFormField(
                      obscureText: isVisable,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          isVisable = !isVisable;
                          setState(() {});
                        },
                        child: isVisable == true
                          ? const Icon(
                              Icons.visibility_off_outlined,
                              size: 30,
                            )
                          : const Icon(
                              Icons.visibility_outlined,
                              size: 30,
                            ),
                    ),
                    controller: passwordController,
                    labelText: local.password,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return local.you_must_enter_your_password;
                      }
                      return null;
                    },
                  ),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          local.forget_password,
                        textAlign: TextAlign.start,
                        style: theme.textTheme.bodyMedium!.copyWith(
                          color: Colors.black,
                        ),
                      ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    MaterialButton(
                      onPressed: () {
                        login();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        height: 55,
                        decoration: BoxDecoration(
                          color: theme.primaryColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              local.login,
                            style: theme.textTheme.titleLarge,
                          ),
                            const Icon(
                              Icons.arrow_forward,
                              size: 30,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, RegisterScreen.routeName);
                      },
                      child: Text(
                        local.or_create_new_account,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyMedium!.copyWith(
                        color: theme.primaryColor,
                      ),
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
  login() async {
    if (formKey.currentState!.validate()) {
      EasyLoading.show();
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        EasyLoading.dismiss();

        SnackBarService.showSuccessMessage("You Successfully signed in");
        Navigator.pushReplacementNamed(context, HomeLayout.routeName);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          EasyLoading.dismiss();
          SnackBarService.showErrorMessage('No user found for that email');
        } else if (e.code == 'wrong-password') {
          EasyLoading.dismiss();
          SnackBarService.showErrorMessage(
              'Wrong password provided for that user');
        }
      }
    }
  }
}
