import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/logic/controllers/settings_controller.dart';
import 'package:shop/utils/my_string.dart';
import 'package:shop/utils/theme.dart';
import 'package:shop/veiw/widgets/text_utils.dart';

class LanguageWidget extends StatelessWidget {
  final controller = Get.put(SettingController());
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildIconWidget(),
        Spacer(),
        Container(
          width: 120,
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
              value: en,
              items: [
                DropdownMenuItem(child: Text(english,style: TextStyle(fontSize: 16,
                fontWeight: FontWeight.bold
                ),),value: en,),
                DropdownMenuItem(child: Text(arabic,style: TextStyle(fontSize: 16,
                    fontWeight: FontWeight.bold
                ),),value: ar,),
                DropdownMenuItem(child: Text(france,style: TextStyle(fontSize: 16,
                    fontWeight: FontWeight.bold
                ),),value: fr,),
              ],
              onChanged: (x){},
            ),
          ),
        )
//        Switch(
//            activeTrackColor: Get.isDarkMode?pinkClr:mainColor,
//            activeColor: Get.isDarkMode?pinkClr:mainColor,
//            value: controller.switchValue.value, onChanged: (value){
//          ThemeController().changeTheme();
//          controller.switchValue.value=value;
//        }),
      ],
    );
    ;
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
              color: languageSettings,
            ),
            child: Icon(
              Icons.language,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          TextUtils(
            text: 'Language',
            color: Get.isDarkMode ? Colors.white : Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
    );
  }
}
