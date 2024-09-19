import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp_project/dialog_utils.dart';
import 'package:todoapp_project/firebase_utils.dart';
import 'package:todoapp_project/home/auth/register/custom_text_form_field.dart';
import 'package:todoapp_project/home/home_screen.dart';
import 'package:todoapp_project/model/my_user.dart';

import '../../../provider/user_provider.dart';

class RegisterScreen extends StatelessWidget {
  static const String routeName = 'register_screen';
  TextEditingController nameController = TextEditingController(text: 'Shahd');
  TextEditingController emailController =
      TextEditingController(text: 'shahd@route.com');
  TextEditingController passwordController =
      TextEditingController(text: '123456');
  TextEditingController confirmPasswordController =
      TextEditingController(text: '123456');
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Account '),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Form(
              key: formKey, //34an 2wsl le kol 7aga maktoba

              child: Column(
                children: [
                  CustomTextFormField(
                      label: 'User Name',
                      controller: nameController,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Please enter User Name';
                        }

                        return null;
                      }),
                  //call back function btdeny el text el user ktbo) ,

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

                  CustomTextFormField(
                    label: 'Confirm password',
                    controller: confirmPasswordController,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'Please enter ConfirmPassword';
                      }

                      if (text != passwordController.text) {
                        return 'Confirm Password does not match password';
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
                          register(context);
                        },
                        child: Text(
                          'Create Account',
                          style: Theme.of(context).textTheme.bodyLarge,
                        )),
                  )
                ],
              ))
        ]),
      ),
    );
  }

  void register(BuildContext context) async {
    // todo: show Loading
    if (formKey.currentState?.validate() == true) {
      DialogUtils.showLoading(
          context: context,
          loadingLabel: 'loading ...',
          barrierDismissible: false);

      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        // todo hide loading
        MyUser myUser = MyUser(
            id: credential.user?.uid ?? '',
            name: nameController.text,
            email: emailController.text);
        await FirebaseUtils.addUserToFireStore(myUser);
        var userProvider = Provider.of<UserProvider>(context,
            listen:
                false); //7geb user mra wa7ada wlw et8yr 2w fe update mt2olee4 tlama kman 3mlto btre2a de ely hwa gowa build lazm false
        userProvider.updateUser(myUser);
        DialogUtils.hideLoading(context);
        // todo show message
        DialogUtils.showMessage(
            context: context,
            content: 'Register Successfully',
            title: 'Success ',
            posActionName: 'ok',
            posAction: () {
              Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
            });
        print('register Succesfully');
        print(credential.user?.uid ?? "");
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          // todo hide loading
          DialogUtils.hideLoading(context);
          // todo show message
          DialogUtils.showMessage(
              context: context,
              content: 'The password provided is too weak.',
              title: 'Error',
              posActionName: 'ok');
        } else if (e.code == 'email-already-in-use') {
          // todo hide loading
          DialogUtils.hideLoading(context);
          // todo show message
          DialogUtils.showMessage(
              context: context,
              content: 'The account already exists for that email.');
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
