import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/logic/controllers/auth_controller.dart';
import 'package:shop/utils/my_string.dart';
import 'package:shop/utils/theme.dart';
import 'package:shop/veiw/widgets/auth/auth_button.dart';
import 'package:shop/veiw/widgets/auth/auth_text_form_field.dart';

class ForgetPasswordScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final controller=Get.find<AuthController>();
  final TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: context.theme.backgroundColor,
        elevation: 0,
        title: Text(
          'Forget Password',
          style: TextStyle(
            color: Get.isDarkMode ? pinkClr :mainColor ,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Get.isDarkMode ? Colors.white : Colors.black,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      backgroundColor: Get.isDarkMode ? darkGreyClr :Colors.white ,
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(
                        Icons.close_rounded,
                        color: Get.isDarkMode ? Colors.white : Colors.black,
                      )),
                ),
                SizedBox(height: 20,),
                Text('if you want to recover your account, then please provide your email ID below..',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                  color: Get.isDarkMode ? Colors.white : Colors.black,
                    fontSize: 16

                ),),
                SizedBox(height: 50,),
                Image.asset('assets/images/forgetpass copy.png',width: 280),
                SizedBox(height: 50,),
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
                      :Image.asset('assets/images/email.png') ,
                  //suffixIcon: Icon(Icons.remove_red_eye),
                  hintText: 'Email',
                ),
                SizedBox(height: 30,),
                GetBuilder<AuthController>(builder: (x){return AuthButton(text: 'SEND',onPressed: () {
                  if(formKey.currentState!.validate()){
                    controller.resetPassword(emailController.text.trim());
                  }
                });}),
                SizedBox(height: 10,)
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
