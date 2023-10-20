import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/services/snackbar_service.dart';
import '../../core/widgets/custom_text_form_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  static const String routeName = "register";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool isVisable = true;
  bool confirmPasswordIsVisable = true;
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
              local.create_account,
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
                    CustomTextFormField(
                      controller: fullNameController,
                    labelText: local.full_name,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return local.you_must_enter_your_full_name;
                      }
                      return null;
                    },
                  ),
                    const SizedBox(height: 30),
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
                    const SizedBox(height: 30),
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
                      var regex = RegExp(
                          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                      if (!regex.hasMatch(value)) {
                        return local.invalid_password;
                      }
                      return null;
                    },
                    ),
                    const SizedBox(height: 30),
                    CustomTextFormField(
                      obscureText: confirmPasswordIsVisable,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          confirmPasswordIsVisable = !confirmPasswordIsVisable;
                          setState(() {});
                        },
                        child: confirmPasswordIsVisable == true
                          ? const Icon(
                              Icons.visibility_off_outlined,
                              size: 30,
                            )
                          : const Icon(
                              Icons.visibility_outlined,
                              size: 30,
                            ),
                    ),
                    controller: confirmPasswordController,
                    labelText: local.confirm_password,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return local.you_must_enter_your_password;
                      }
                      if (value != passwordController.text) {
                        return local.password_does_not_match_as_above;
                      }
                      return null;
                    },
                  ),
                    const SizedBox(height: 40),
                    MaterialButton(
                      onPressed: () {
                        register();
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
                              local.create_account,
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void register() async {
    if (formKey.currentState!.validate()) {
      EasyLoading.show();
      try {
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        EasyLoading.dismiss();
        SnackBarService.showSuccessMessage("Your account has been registered");
        Navigator.pop(context);

      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          EasyLoading.dismiss();
          SnackBarService.showErrorMessage(
              'The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          EasyLoading.dismiss();
          SnackBarService.showErrorMessage(
              'The account already exists for that email.');
        }
      }
    }
  }
}
