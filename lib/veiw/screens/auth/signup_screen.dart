import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/logic/controllers/auth_controller.dart';
import 'package:shop/routes/routes.dart';
import 'package:shop/utils/my_string.dart';
import 'package:shop/veiw/widgets/auth/auth_button.dart';
import 'package:shop/veiw/widgets/auth/container_under.dart';

import '../../../utils/theme.dart';
import '../../widgets/auth/auth_text_form_field.dart';
import '../../widgets/auth/check_widget.dart';
import '../../widgets/text_utils.dart';

class SignUpScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final controller = Get.find<AuthController>();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Get.isDarkMode ? darkGreyClr :Colors.white ,
          elevation: 0,
        ),
        backgroundColor: context.theme.backgroundColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 1.3,
                child: Padding(
                  padding: EdgeInsets.only(left: 25, right: 25, top: 40),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            TextUtils(
                              text: 'SIGN',
                              color: Get.isDarkMode ?  pinkClr: mainColor,
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            TextUtils(
                              text: 'UP',
                              color:
                                  Get.isDarkMode ? Colors.white : Colors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        AuthTextFormField(
                          controller: nameController,
                          keyboardType: TextInputType.text,
                          obsecureText: false,
                          validator: (value) {
                            if (value.toString().length <= 2 ||
                                !RegExp(validationName).hasMatch(value)) {
                              return 'Enter a valid Name';
                            } else {
                              return null;
                            }
                          },
                          prefixIcon: Get.isDarkMode
                              ?Icon(
                            Icons.person,
                            size: 30,
                            color: pinkClr,
                          )
                              : Image.asset('assets/images/user.png'),
                          //suffixIcon: Icon(Icons.remove_red_eye),
                          hintText: 'User Name',
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        AuthTextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (!RegExp(validationEmail).hasMatch(value)) {
                              return 'Enter a valid Email';
                            } else {
                              return null;
                            }
                          },
                          prefixIcon: Get.isDarkMode
                              ?Icon(
                            Icons.email,
                            size: 30,
                            color: pinkClr,
                          )
                              : Image.asset('assets/images/email.png'),
                          //suffixIcon: Icon(Icons.remove_red_eye),
                          hintText: 'Email',
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GetBuilder<AuthController>(
                            //init: AuthController(),
                            builder: (x) {
                          return AuthTextFormField(
                            controller: passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            obsecureText: controller.isVisible ? false : true,
                            validator: (value) {
                              if (value.toString().length < 6) {
                                return 'Password is too short';
                              } else {
                                return null;
                              }
                            },
                            prefixIcon: Get.isDarkMode
                                ?Icon(
                              Icons.lock,
                              size: 30,
                              color: pinkClr,
                            )
                                : Image.asset('assets/images/lock.png'),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  controller.visibility();
                                },
                                icon: controller.isVisible
                                    ? Icon(
                                        Icons.visibility_off,
                                        color: Colors.black,
                                      )
                                    : Icon(
                                        Icons.visibility,
                                        color: Colors.black,
                                      )),
                            hintText: 'Password',
                          );
                        }),
                        SizedBox(
                          height: 50,
                        ),
                        CheckWidget(),
                        //Checkbox(value: false, onChanged: (x){})
                        SizedBox(
                          height: 50,
                        ),
                        GetBuilder<AuthController>(init: AuthController(),builder: (x) {
                          return AuthButton(text: 'SIGN UP',onPressed: () {
                            if(formKey.currentState!.validate() && controller.isCheckBox){
                            controller.signUpUsingFirebase(
                            name: nameController.text.trim(),
                            email: emailController.text.trim(),
                            password: passwordController.text,

                            );
                            }
                            else if (!controller.isCheckBox){
                            Get.snackbar('Check Box', 'Please accept terms && conditions',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Get.isDarkMode?Colors.blueGrey:Colors.redAccent,
                            colorText: Colors.white,);
                            }
                          });
                        }),
                      ],
                    ),
                  ),
                ),
              ),
              ContainerUnder(
                  text: 'Already have an Account? ',
                  textType: 'Log IN',
                  onPressed: () {
                    Get.offNamed(Routes.LoginScreen);
                  })
            ],
          ),
        ),
      ),
    );
  }
}
