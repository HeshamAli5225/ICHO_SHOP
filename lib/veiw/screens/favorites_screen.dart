import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shop/logic/controllers/product_controller.dart';
import 'package:shop/model/wish_model.dart';
import 'package:shop/providers/favorite_provider.dart';
import 'package:shop/veiw/widgets/text_utils.dart';

import '../../utils/my_string.dart';
import '../widgets/payment/green_button.dart';

class FavoritesScreen extends StatefulWidget {

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final GlobalKey<ScaffoldMessengerState> scaffoldKey =
  GlobalKey<ScaffoldMessengerState>();
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Scaffold(

          backgroundColor: Colors.grey.shade200,

          body: context.watch<Favorite>().getWishItems.isNotEmpty
              ? const FavoriteItem()
              : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 100,
                  width: 100,
                  child: Image.asset('assets/images/heart.png'),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  tr(StringManger.noFavYet),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Get.isDarkMode ? Colors.white : Colors.black),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}



class FavoriteItem extends StatelessWidget {
  const FavoriteItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Favorite>(
      builder: (context, fav, child) {
        return ListView.builder(
            itemCount: fav.count,
            itemBuilder: (context, index) {
              final product = fav.getWishItems[index];
              return FavoriteModel(
                product: product,
              );
            });
      },
    );
  }
}
