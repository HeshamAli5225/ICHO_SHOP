import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/veiw/widgets/setting/dark_mode_widget.dart';
import 'package:shop/veiw/widgets/setting/language_widget.dart';
import 'package:shop/veiw/widgets/setting/log_out_widget.dart';
import 'package:shop/veiw/widgets/setting/profile_image.dart';
import 'package:shop/veiw/widgets/text_utils.dart';

import '../../utils/my_string.dart';
import '../../utils/theme.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ListView(

          children: [
            ProfileImage(),
            SizedBox(
              height: 10,
            ),
            Divider(
              color: Get.isDarkMode ? Colors.white : Colors.grey,
              thickness: 2,
            ),
            SizedBox(
              height: 20,
            ),
            TextUtils(
                text: tr(StringManger.general),
              color: Get.isDarkMode ? pinkClr : mainColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
            ),
            SizedBox(height: 20,),
            DarkModeWidget(),
            SizedBox(height: 20,),
            LanguageWidget(),
            SizedBox(height: 20,),
            LogOutWidget(),
          ],
        ),
      ),
//      body: Center(
//        child: Column(
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: [
//            TextButton(child: Text('Change Mode'),
//            onPressed: (){
//            ThemeController().changeTheme();
//      },
//      ),
//            SizedBox(height: 20,),
//            GetBuilder<AuthController>(
//              builder: (controller) {return TextButton(child: Text('logOut'),
//                onPressed: (){
//                Get.defaultDialog(
//                  backgroundColor: Colors.grey,
//                  title: 'LogOut',
//                  titleStyle: TextStyle(
//                    fontSize: 18,
//                    fontWeight: FontWeight.bold,
//                  ),
//                  middleText: 'are you sure you wan to logOut',
//                  middleTextStyle: TextStyle(
//                    fontSize: 18,
//                    fontWeight: FontWeight.bold,
//                  ),
//                  textCancel: 'No',
//                  cancelTextColor: Colors.white,
//                  onCancel: (){Get.back();},
//                    textConfirm: 'Yes',
//                  confirmTextColor: Colors.white,
//                  onConfirm: (){controller.signOut();},
//                  buttonColor: Get.isDarkMode?pinkClr:mainColor
//                );
//                },
//              );},
//            ),
//          ],
//        ),),
    );
  }
}
