import 'package:get/get.dart';
import 'package:shop/utils/my_string.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shop/veiw/screens/category_screen.dart';
import 'package:shop/veiw/screens/favorites_screen.dart';
import 'package:shop/veiw/screens/home_screen.dart';
import 'package:shop/veiw/screens/settings_screen.dart';
import 'package:shop/veiw/screens/suppliers/dashboard.dart';
import 'package:shop/veiw/screens/suppliers/upload.dart';

class MainController extends GetxController {
  RxInt currentIndex = 0.obs;
  final tabs = [
    HomeScreen(),
    CategoryScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ].obs;

  final titles = [
    tr(StringManger.iShop),
    tr(StringManger.categories),
    tr(StringManger.favorites),
    tr(StringManger.settings),
  ].obs;
}
class SupplierController extends GetxController {
  RxInt currentIndex = 0.obs;
  final tabs = [
    HomeScreen(),
    CategoryScreen(),
    DashboardScreen(),
    UploadProductScreen(),
  ].obs;

  final titles = [
    tr(StringManger.iShop),
    tr(StringManger.categories),
    "dashboard",
    'upload'
  ].obs;
}
