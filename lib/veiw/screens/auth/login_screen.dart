import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/logic/controllers/auth_controller.dart';
import 'package:shop/routes/routes.dart';
import 'package:shop/utils/my_string.dart';
import 'package:shop/utils/theme.dart';
import 'package:shop/veiw/widgets/auth/auth_button.dart';
import 'package:shop/veiw/widgets/auth/auth_text_form_field.dart';
import 'package:shop/veiw/widgets/auth/check_widget.dart';
import 'package:shop/veiw/widgets/auth/container_under.dart';
import 'package:shop/veiw/widgets/text_utils.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final controller = Get.find<AuthController>();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        appBar: AppBar(
          backgroundColor: Get.isDarkMode ?darkGreyClr  :Colors.white ,
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
                              text: 'LOG',
                              color: Get.isDarkMode ? pinkClr :mainColor ,
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            TextUtils(
                              text: 'IN',
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
                          height: 20,
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
                                :Image.asset('assets/images/lock.png') ,
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
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                              onPressed: () {
                                Get.toNamed(Routes.forgetPasswordScreen);
                              },
                              child: TextUtils(
                                text: 'Forget Password?',
                                color: Get.isDarkMode
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              )),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        GetBuilder<AuthController>(builder:(x){return AuthButton(text: 'LOG IN', onPressed: () {
                          if(formKey.currentState!.validate()){
                            controller.logInUsingFirebase(email: emailController.text.trim(), password: passwordController.text,);
                          }
                        });}),
                        SizedBox(
                          height: 20,
                        ),
                        TextUtils(
                          text: 'OR',
                          color: Get.isDarkMode ? Colors.white : Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GetBuilder<AuthController>(builder: (x){return InkWell(
                                onTap: () {
                                  controller.signUpUsingFaceBook();
                                },
                                child:
                                Image.asset('assets/images/facebook.png'));}),
                            const SizedBox(
                              width: 10,
                            ),
                            GetBuilder<AuthController>(builder:(x){return InkWell(
                              onTap: () {
                                controller.signUpUsingGoogle();
                              },
                              child: Image.asset('assets/images/google.png'),
                            );}),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              ContainerUnder(
                  text: 'Don\'t have an Account? ',
                  textType: 'SIGN UP',
                  onPressed: () {
                    Get.offNamed(Routes.SignUpScreen);
                  })
            ],
          ),
        ),
      ),
    );
  }
}
