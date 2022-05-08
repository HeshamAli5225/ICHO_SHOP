import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get.dart';
import 'package:shop/logic/controllers/settings_controller.dart';
import 'package:shop/utils/my_string.dart';
import 'package:shop/utils/theme.dart';
import 'package:shop/veiw/widgets/text_utils.dart';

class LanguageWidget extends StatefulWidget {
  @override
  State<LanguageWidget> createState() => _LanguageWidgetState();
}

class _LanguageWidgetState extends State<LanguageWidget> {
  final languages = [
    tr(StringManger.english),
    tr(StringManger.arabic),
  ];
  String? value;
  bool isEnglish = true;

  final controller = Get.put(SettingController());

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildIconLanguageWidget(),
        Container(
          width: 120,
          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13),
            border: Border.all(
                color: Get.isDarkMode ? Colors.white : Colors.black, width: 2),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              // onTap: () {
              //   if(value == languages[0]){
              //   setState(() {
              //     Locale('en', 'US');
              //     Phoenix.rebirth(context);
              //   });
              //   }
              //   else{
              //     setState(() {
              //       Locale('ar', 'SA');
              //       Phoenix.rebirth(context);
              //     });
              //
              //   }
              // },
              iconSize: 25,
              icon: Icon(
                Icons.arrow_drop_down,
                color: Get.isDarkMode ? Colors.white : Colors.black,
              ),
              value: value,
              items: languages.map(buildMenuItem).toList(),
              hint: Text(tr(StringManger.english)),
              onChanged: (value) => setState(() {
                print ("equal value$value");
                this.value = value;
                if (this.value == languages[1]) {
                  isEnglish = false;

                }
              }),
            ),
          ),
        ),
//        Switch(
//            activeTrackColor: Get.isDarkMode?pinkClr:mainColor,
//            activeColor: Get.isDarkMode?pinkClr:mainColor,
//            value: controller.switchValue.value, onChanged: (value){
//          ThemeController().changeTheme();
//          controller.switchValue.value=value;
//        }),
      ],
    );

  }

  DropdownMenuItem<String> buildMenuItem(String item) {
    return DropdownMenuItem(
      onTap: () async {
        if (item==tr(StringManger.english)) {
          await context.setLocale(Locale('en', 'US'));
          Phoenix.rebirth(context);
        } else  {
          await context.setLocale(Locale('ar', 'SA'));
          Phoenix.rebirth(context);
        }
      },
      value: item,
      child: Text(
        item,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

_buildIconLanguageWidget() {
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
          text: tr(StringManger.language),
          color: Get.isDarkMode ? Colors.white : Colors.black,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ],
    ),
  );
}
