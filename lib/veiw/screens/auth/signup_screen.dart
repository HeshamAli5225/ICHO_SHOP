import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/logic/controllers/auth_controller.dart';
import 'package:shop/routes/routes.dart';
import 'package:shop/utils/my_string.dart';
import 'package:shop/veiw/widgets/auth/auth_button.dart';
import 'package:shop/veiw/widgets/auth/container_under.dart';
import 'package:shop/utils/my_string.dart';
import '../../../utils/theme.dart';
import '../../widgets/auth/auth_text_form_field.dart';
import '../../widgets/auth/check_widget.dart';
import '../../widgets/text_utils.dart';
import '';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController addressController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final controller = Get.find<AuthController>();

  final formKey = GlobalKey<FormState>();

  final appBar=AppBar(
    backgroundColor: Get.isDarkMode ? darkGreyClr :Colors.white ,
    elevation: 0,
  );
  var registerType=StringManger.buyer;
  @override
  Widget build(BuildContext context) {
    final appBarHeight=appBar.preferredSize.height;
    final statusBarHeight=MediaQuery.of(context).padding.top;
    final screenHeight=MediaQuery.of(context).size.height-appBarHeight-statusBarHeight;
    final screenWidth=MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Get.isDarkMode ? darkGreyClr : Colors.white,
          elevation: 0,
        ),
        backgroundColor: context.theme.backgroundColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 25, right: 25, top: 40),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          TextUtils(
                            text: tr(StringManger.sign),
                            color: Get.isDarkMode ? pinkClr : mainColor,
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          TextUtils(
                            text: tr(StringManger.up),
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
                              !RegExp(StringManger.validationName)
                                  .hasMatch(value)) {
                            return tr(StringManger.validName);
                          } else {
                            return null;
                          }
                        },
                        prefixIcon: Get.isDarkMode
                            ? Icon(
                          Icons.person,
                          size: 30,
                          color: pinkClr,
                        )
                            : Image.asset('assets/images/user.png'),
                        //suffixIcon: Icon(Icons.remove_red_eye),
                        hintText: tr(StringManger.userName),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      AuthTextFormField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        obsecureText: false,
                        validator: (value) {
                          // if (! value.toString().isPhoneNumber ) {
                          //   return tr(StringManger.validName);
                          // } else {
                          //   return null;
                          // }
                        },
                        prefixIcon: Get.isDarkMode
                            ? Icon(
                          Icons.phone,
                          size: 30,
                          color: pinkClr,
                        )
                            : Icon(
                          Icons.phone,
                          size: 30,
                          color: mainColor,
                        ), hintText: 'phone',
                        //suffixIcon: Icon(Icons.remove_red_eye),
                        //hintText: tr(StringManger.userName),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      AuthTextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (!RegExp(StringManger.validationEmail)
                              .hasMatch(value)) {
                            return tr(StringManger.validEmail);
                          } else {
                            return null;
                          }
                        },
                        prefixIcon: Get.isDarkMode
                            ? Icon(
                                Icons.email,
                                size: 30,
                                color: pinkClr,
                              )
                            : Image.asset('assets/images/email.png'),
                        //suffixIcon: Icon(Icons.remove_red_eye),
                        hintText: tr(StringManger.email),
                      ),

                      SizedBox(
                        height: 10,
                      ),
                      AuthTextFormField(
                        controller: addressController,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          // if (!RegExp(StringManger.validationEmail)
                          //     .hasMatch(value)) {
                          //   return tr(StringManger.validEmail);
                          // } else {
                          //   return null;
                          // }
                        },
                        prefixIcon: Get.isDarkMode
                            ? Icon(
                          Icons.home,
                          size: 30,
                          color: pinkClr,
                        )
                            : Icon(
                          Icons.home,
                          size: 30,
                          color: mainColor,
                        ),
                        //suffixIcon: Icon(Icons.remove_red_eye),
                        hintText: 'Address',
                        //hintText: tr(StringManger.email),
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
                              return tr(StringManger.validPassword);
                            } else {
                              return null;
                            }
                          },
                          prefixIcon: Get.isDarkMode
                              ? Icon(
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
                          hintText: tr(StringManger.password),
                        );
                      }),
                      SizedBox(
                        height: 50,
                      ),
                      Row(
                        children: [
                          TextUtils(text: 'registration type', color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
                          Spacer(),
                          Container(
                            width: screenWidth*0.3,
                            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(13),
                              border: Border.all(
                                  color: Get.isDarkMode ? Colors.white : Colors.black,
                                  width: 2),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                iconSize: 25,
                                icon: Icon(Icons.arrow_drop_down,
                                  color:Get.isDarkMode? Colors.white:Colors.black,
                                ),
                                value: registerType,
                                items: [
                                  DropdownMenuItem(child: Text('buyer',style: TextStyle(fontSize: 16,
                                      fontWeight: FontWeight.bold
                                  ),),value: StringManger.buyer,),
                                  DropdownMenuItem(child: Text('seller',style: TextStyle(fontSize: 16,
                                      fontWeight: FontWeight.bold
                                  ),),value: StringManger.seller,),
                                ],
                                onChanged: (value){
                                  setState(() {
                                    print(value);
                                    registerType=value!;
                                  });

                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      CheckWidget(),
                      SizedBox(height: 50,),
                      //Checkbox(value: false, onChanged: (x){})
                      GetBuilder<AuthController>(
                          init: AuthController(),
                          builder: (x) {
                            return AuthButton(
                                text: tr(StringManger.signUp),
                                onPressed: () {
                                  if (formKey.currentState!.validate() &&
                                      controller.isCheckBox) {
                                    controller.signUpUsingFirebase(
                                      name: nameController.text.trim(),
                                      email: emailController.text.trim(),
                                      password: passwordController.text,
                                    );
                                  } else if (!controller.isCheckBox) {
                                    Get.snackbar(
                                      tr(StringManger.checkBox),
                                      tr(StringManger.acceptTerm),
                                      snackPosition: SnackPosition.BOTTOM,
                                      backgroundColor: Get.isDarkMode
                                          ? Colors.blueGrey
                                          : Colors.redAccent,
                                      colorText: Colors.white,
                                    );
                                  }
                                });
                          }),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              ContainerUnder(
                  text: tr(StringManger.haveAccount),
                  textType: tr(StringManger.login),
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
