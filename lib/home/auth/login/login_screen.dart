import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp_project/appcolors.dart';
import 'package:todoapp_project/dialog_utils.dart';
import 'package:todoapp_project/firebase_utils.dart';
import 'package:todoapp_project/home/auth/register/custom_text_form_field.dart';
import 'package:todoapp_project/home/auth/register/register_screen.dart';
import 'package:todoapp_project/home/home_screen.dart';
import 'package:todoapp_project/provider/user_provider.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = 'login _screen';
  TextEditingController emailController =
      TextEditingController(text: 'shahd@route.com');
  TextEditingController passwordController =
      TextEditingController(text: '123456');
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log in '),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Form(
              key: formKey, //34an 2wsl le kol 7aga maktoba

              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      'Welcome Back!',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  CustomTextFormField(
                    label: 'Email',
                    controller: emailController,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'Please enter Email';
                      }

                      final bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(text);

                      if (!emailValid) {
                        return 'Please enter valid email';
                      }

                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                  ),
                  CustomTextFormField(
                    label: 'Password',
                    controller: passwordController,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'Please enter Password';
                      }

                      if (text.length < 6) {
                        return 'Password must be at least 6 characters';
                      }

                      return null;
                    },
                    keyboardType: TextInputType.number,
                    obscureText: true,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ElevatedButton(
                        onPressed: () {
                          login(context);
                        },
                        child: Text(
                          'Login',
                          style: Theme.of(context).textTheme.bodyLarge,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(RegisterScreen.routeName);
                      },
                      child: Text(
                        'Or Create Account',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Appcolors.primaryColor, fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ))
        ]),
      ),
    );
  }

  void login(BuildContext context) async {
    if (formKey.currentState?.validate() == true) {
      // todo show loading
      try {
        DialogUtils.showLoading(
            context: context,
            loadingLabel: 'Waiting...',
            barrierDismissible: false);

        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);
        var user = await FirebaseUtils.readUserFromFireStore(
            credential.user?.uid ?? '');
        if (user == null) {
          return;
          //sharedprefernce flutter , bt3ml save be data user authentication email w pass
        }
        var userProvider = Provider.of<UserProvider>(context,
            listen:
                false); //7geb user mra wa7ada wlw et8yr 2w fe update mt2olee4 tlama kman 3mlto btre2a de ely hwa gowa build lazm false
        userProvider.updateUser(user);
        // todo hide loading
        DialogUtils.hideLoading(context);

        // todo show message
        DialogUtils.showMessage(
            context: context,
            content: 'Login Succesfully',
            title: 'Success',
            posActionName: 'ok',
            posAction: () {
              Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
            });

        print(credential.user?.uid ?? ""); //;lw 3nk user tmm lw  m3nk4 mo4kla
      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-credential') {
          // todo hide loading
          DialogUtils.hideLoading(context);

          // todo show message
          DialogUtils.showMessage(
              context: context,
              content:
                  'The supplied auth credential is incorrect,malformed or has expired',
              title: 'Error',
              posActionName: 'ok');
        }
      } catch (e) {
        // todo hide loading

        DialogUtils.hideLoading(context);

        // todo show message
        DialogUtils.showMessage(
            context: context,
            content: e.toString(),
            title: 'Error',
            posActionName: 'ok');
      }
    }
  }
}
