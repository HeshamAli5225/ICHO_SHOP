import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/logic/controllers/settings_controller.dart';
import 'package:shop/logic/controllers/theme_controller.dart';
import 'package:shop/utils/theme.dart';
import 'package:shop/veiw/widgets/text_utils.dart';

import '../../../utils/my_string.dart';

class DarkModeWidget extends StatelessWidget {
  final controller=Get.put(SettingController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildIconWidget(),
        Switch(
            activeTrackColor: Get.isDarkMode?pinkClr:mainColor,
            activeColor: Get.isDarkMode?pinkClr:mainColor,
            value: controller.switchValue.value, onChanged: (value){
          ThemeController().changeTheme();
          controller.switchValue.value=value;
        }),
      ],
    );});
  }

  Widget buildIconWidget() {
    return Material(
      color: Colors.transparent,
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: darkSettings,
            ),
            child: Icon(
              Icons.dark_mode,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          TextUtils(
              text:  tr(StringManger.darkMode),
              color: Get.isDarkMode ?Colors.white:Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.bold,
          ),
        ],
      ),
    );
  }
}
