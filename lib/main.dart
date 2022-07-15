import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shop/logic/bindings/main_binding.dart';
import 'package:shop/logic/controllers/theme_controller.dart';
import 'package:shop/utils/theme.dart';
import 'package:shop/veiw/screens/customers/customer_orders.dart';
import 'package:shop/veiw/screens/payment_screen.dart';
import 'package:shop/veiw/screens/suppliers/dashboard.dart';
import 'package:shop/veiw/screens/suppliers/suppliers_screen.dart';
import 'package:shop/veiw/screens/suppliers/upload.dart';


import 'firebase_options.dart';
import 'routes/routes.dart';
import 'veiw/screens/welcome_screen.dart';
const String stripePublishableKey =
    "pk_test_51L7tTkF5uinudAWIE2bMsmYQz7iIZqudpAls9tJeR6NONi1ihRq71PCFfa5mzQPdAfck3dWPIFysLM9XCzkfLQ40003ZeFrqhX";
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // set the publishable key for Stripe - this is mandatory
  Stripe.publishableKey = stripePublishableKey;
  WidgetsFlutterBinding.ensureInitialized();

  MainBinding().dependencies();
  await EasyLocalization.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(
    EasyLocalization(
        supportedLocales: [ Locale('ar', 'SA'),Locale('en', 'US'),],
        path: 'assets/translations',

        child: Phoenix(child: MyApp())),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: 'My Shop',
      debugShowCheckedModeBanner: false,
      theme: ThemesApp.light,
      darkTheme: ThemesApp.dark,
      themeMode: ThemeController().themeMode,
      initialRoute: FirebaseAuth.instance.currentUser != null ||
              GetStorage().read('auth') == true
          ? GetStorage().read('type') == 'seller'?AppRoutes.sellerMain:AppRoutes.mainScreen
          : GetStorage().read('signInBefore') == true
              ? AppRoutes.loginScreen
              : AppRoutes.welcome,
      getPages: AppRoutes.routes,
    );
  }
}
