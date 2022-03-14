import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shop/logic/bindings/main_binding.dart';
import 'package:shop/logic/controllers/theme_controller.dart';
import 'package:shop/utils/theme.dart';
import 'package:shop/veiw/screens/main_screen.dart';

import 'routes/routes.dart';
import 'veiw/screens/welcome_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  MainBinding().dependencies();
  await GetStorage.init();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'My Shop',
      debugShowCheckedModeBanner: false,
      theme: ThemesApp.light,
      darkTheme:ThemesApp.dark,
      themeMode: ThemeController().themeMode,
      //home:  WelcomeScreen()/*MainScreen()*/,
      initialRoute: FirebaseAuth.instance.currentUser !=null || GetStorage().read('auth')==true?
      AppRoutes.mainScreen:GetStorage().read('signInBefore')==true?AppRoutes.loginScreen:AppRoutes.welcome,
      getPages: AppRoutes.routes,
    );

  }
}

