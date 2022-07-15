import 'package:get/get.dart';
import 'package:shop/logic/bindings/auth_biniding.dart';
import 'package:shop/logic/bindings/cart_binding.dart';
import 'package:shop/logic/bindings/main_binding.dart';
import 'package:shop/logic/bindings/product_binding.dart';
import 'package:shop/veiw/screens/cart_screen.dart';
import 'package:shop/veiw/screens/auth/forget_password_screen.dart';
import 'package:shop/veiw/screens/customers/customer_screen.dart';
import 'package:shop/veiw/screens/payment_screen.dart';
import 'package:shop/veiw/screens/suppliers/dashboard.dart';
import 'package:shop/veiw/screens/suppliers/suppliers_screen.dart';

import '../veiw/screens/auth/login_screen.dart';
import '../veiw/screens/auth/signup_screen.dart';
import '../veiw/screens/place_order.dart';
import '../veiw/screens/welcome_screen.dart';

class AppRoutes{
  static const String welcome=Routes.welcomeScreen;
  static const String mainScreen=Routes.mainScreen;
  static const String loginScreen=Routes.LoginScreen;
  static const String sellerMain=Routes.SupplierScreen;
  static final routes =[
    GetPage(name: Routes.welcomeScreen, page: ()=>WelcomeScreen()),
    GetPage(name: Routes.LoginScreen, page: ()=>LoginScreen(),binding: AuthBinding()),
    GetPage(name: Routes.SignUpScreen, page: ()=>SignUpScreen(),binding: AuthBinding()),
    GetPage(name: Routes.forgetPasswordScreen, page: ()=>ForgetPasswordScreen(),binding: AuthBinding()),
    GetPage(name: Routes.mainScreen, page: ()=>CustomerScreen(),bindings: [AuthBinding(),MainBinding(),ProductBinding()]),
    GetPage(name: Routes.cartScreen, page: ()=>CartScreen(),bindings: [AuthBinding(),ProductBinding(),CartBinding()]),
    GetPage(name: Routes.placeOrder, page: ()=>PlaceOrderScreen(),bindings: [AuthBinding(),ProductBinding(),CartBinding()]),
    GetPage(name: Routes.paymentScreen, page: ()=>PaymentScreen(), bindings: [AuthBinding(),ProductBinding(),MainBinding()]),
    GetPage(name: Routes.SupplierScreen, page: ()=>SupplierScreen(),bindings: [AuthBinding(),MainBinding(),ProductBinding()]),
  ];

}

class Routes{
  static const String welcomeScreen='/welcomeScreen';
  static const String LoginScreen='/LoginScreen';
  static const String SignUpScreen='/SignUpScreen';
  static const String forgetPasswordScreen='/forgetPasswordScreen';
  static const String mainScreen='/CustomerScreen';
  static const String cartScreen='/cartScreen';
  static const String placeOrder='/placeOrder';
  static const String paymentScreen='/paymentScreen';
  static const String dashboardScreen='/paymentScreen';
  static const String SupplierScreen='/SupplierScreen';

}