
import 'package:get/get.dart';
import 'package:shop/veiw/screens/category_screen.dart';
import 'package:shop/veiw/screens/favorites_screen.dart';
import 'package:shop/veiw/screens/home_screen.dart';
import 'package:shop/veiw/screens/settings_screen.dart';
class MainController extends GetxController{
  RxInt currentIndex=0.obs;
  final tabs=[
    HomeScreen(),
    CategoryScreen(),
    FavoritesScreen(),

    SettingsScreen(),
  ].obs;

  final titles=[
    'ICHOShop',
    'Categories',
    'Favorites',
    'Settings'
  ].obs;

}