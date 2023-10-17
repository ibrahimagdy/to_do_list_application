import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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
              "Create Account",
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
                      labelText: "Full Name",
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "You must enter your Full Name";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),
                    CustomTextFormField(
                      controller: emailController,
                      labelText: "Email",
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "You must enter your email";
                        }
                        var regex = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                        if (!regex.hasMatch(value)) {
                          return "Invalid Email";
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
                      labelText: "Password",
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "You must enter your password";
                        }
                        var regex = RegExp(
                            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                        if (!regex.hasMatch(value)) {
                          return "Invalid Password";
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
                      labelText: "Confirm Password",
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "You must enter your password";
                        }
                        if (value != passwordController.text) {
                          return "Password must be same as above";
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
                              "Create Account  ",
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
          )),
    );
  }

  void register() async {
    if (formKey.currentState!.validate()) {
      EasyLoading.show();

      print(emailController.text);
      print(passwordController.text);
      try {
        var userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        EasyLoading.dismiss();
        SnackBarService.showSuccessMessage("Your account has been registered");
        Navigator.pop(context);
        print(userCredential.user?.uid);

        // userCredential.user.ui
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          EasyLoading.dismiss();
          SnackBarService.showErrorMessage(
              'The password provided is too weak.');
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          EasyLoading.dismiss();
          SnackBarService.showErrorMessage(
              'The account already exists for that email.');
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
    }
  }
}
