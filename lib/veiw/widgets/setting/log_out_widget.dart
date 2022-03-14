import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/logic/controllers/auth_controller.dart';
import 'package:shop/logic/controllers/settings_controller.dart';
import 'package:shop/utils/theme.dart';
import 'package:shop/veiw/widgets/text_utils.dart';

class LogOutWidget extends StatelessWidget {
  final controller=Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (x){return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Get.isDarkMode?Colors.pink[200]:Colors.teal[100],
        onTap: (){

          Get.defaultDialog(
                  backgroundColor: Colors.grey,
                  title: 'LogOut',
                  titleStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  middleText: 'are you sure you wan to logOut',
                  middleTextStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textCancel: 'No',
                  cancelTextColor: Colors.white,
                  onCancel: (){Get.back();},
                    textConfirm: 'Yes',
                  confirmTextColor: Colors.white,
                  onConfirm: (){controller.signOut();},
                  buttonColor: Get.isDarkMode?pinkClr:mainColor
                );

        },
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: logOutSettings,
              ),
              child: Icon(
                Icons.logout,
                color: Colors.white,
              ),
            ),
            SizedBox(
              width: 20,
            ),
            TextUtils(
              text: 'Logout',
              color: Get.isDarkMode ?Colors.white:Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
      ),
    );});
  }
}
