import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/logic/controllers/cart_controller.dart';
import 'package:shop/logic/controllers/main_controller.dart';
import 'package:shop/routes/routes.dart';
import 'package:shop/utils/theme.dart';
class SupplierScreen extends StatelessWidget {
 // final controller = Get.find<MainController>();
  final controller = Get.put(SupplierController());
  final cartController = Get.put(CartController());
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Obx(() {
        return SafeArea(
          child: Scaffold(
            // appBar: AppBar(
            //   title: Text(controller.titles[controller.currentIndex.value]),
            //   centerTitle: true,
            //   elevation: 0,
            //   backgroundColor: Get.isDarkMode ?darkGreyClr : mainColor ,
            //   actions: [
            //     Obx((){
            //       if(cartController.productMap.isEmpty){
            //         return IconButton(
            //           onPressed: () {
            //             Get.toNamed(Routes.cartScreen);
            //           },
            //           icon: Image.asset('assets/images/shop.png'));}
            //
            //       else{
            //         return Badge(
            //           position: BadgePosition.topEnd(top: 0, end: 3),
            //           animationDuration: Duration(milliseconds: 300),
            //           animationType: BadgeAnimationType.slide,
            //           badgeContent: Text(
            //             '${cartController.productMap.length}',
            //             style: TextStyle(color: Colors.white),
            //           ),
            //           child: IconButton(
            //               onPressed: () {
            //                 Get.toNamed(Routes.cartScreen);
            //               },
            //               icon: Image.asset('assets/images/shop.png')),
            //         );
            //       }
            //       })
            //     ,
            //
            //   ],
            //   leading: Text(''),
            // ),
            backgroundColor: context.theme.backgroundColor,
            body: SafeArea(
              child: IndexedStack(
                index: controller.currentIndex.value,
                children: controller.tabs.value,
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Get.isDarkMode?darkGreyClr:Colors.white,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home,
                    color: Get.isDarkMode?Colors.white:Colors.black,
                  ),
                  activeIcon: Icon(Icons.home,
                    color: Get.isDarkMode?pinkClr:mainColor,

                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.category,
                    color: Get.isDarkMode?Colors.white:Colors.black,

                  ),
                  activeIcon: Icon(Icons.category,
                    color: Get.isDarkMode?pinkClr:mainColor,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.dashboard,
                    color: Get.isDarkMode?Colors.white:Colors.black,
                  ),
                  activeIcon: Icon(Icons.dashboard,
                    color: Get.isDarkMode?pinkClr:mainColor,

                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.upload,
                    color: Get.isDarkMode?Colors.white:Colors.black,

                  ),
                  activeIcon: Icon(Icons.upload,
                    color: Get.isDarkMode?pinkClr:mainColor,
                  ),
                  label: '',
                ),
              ],
              currentIndex: controller.currentIndex.value,
              type: BottomNavigationBarType.fixed,
              onTap: (index) {
                controller.currentIndex.value = index;
              },
            ),
          ),
        );
      }),
    );
  }
}
