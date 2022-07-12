import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'dart:ui';

import 'package:shop/utils/theme.dart';
import 'package:shop/veiw/screens/suppliers/edit_business.dart';
import 'package:shop/veiw/screens/suppliers/my_store.dart';
import 'package:shop/veiw/screens/suppliers/preparing_orders.dart';
import 'package:shop/veiw/screens/suppliers/supplier_balance.dart';
import 'package:shop/veiw/screens/suppliers/supplier_orders.dart';
import 'package:shop/veiw/screens/suppliers/supplier_statics.dart';

import '../../../logic/controllers/auth_controller.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthController());
    return Scaffold(
      appBar: AppBar(
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: mainColor,
          title: Text("DashBoard"),
          actions: [
            IconButton(
              onPressed: () {
                controller.signOut();
              },
              icon: Icon(Icons.logout),
            ),
          ]),
      body: GridView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.all(12),
        itemCount: data.length,
        itemBuilder: (context, index) {
          var dashData =
              DashData(icon: data[index].icon, title: data[index].title);
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return screens[index];
                  },
                ),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        dashData.icon,
                        size: 30,
                        color: Colors.deepOrange,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        dashData.title,
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: mainColor.withOpacity(.5),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      style: BorderStyle.solid,
                      width: 20,
                      color: Colors.white60.withOpacity(.1),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
        ),
      ),
    );
  }
}

class DashData {
  final String title;
  final IconData icon;

  DashData({
    required this.title,
    required this.icon,
  });
}

List<DashData> data = [
  DashData(title: "My Store", icon: Icons.store),
  DashData(title: "Orders", icon: Icons.shopping_bag),
  DashData(title: "Edit Products", icon: Icons.edit),
  DashData(title: "Manage Products", icon: Icons.settings),
  DashData(title: "balance", icon: Icons.attach_money),
  DashData(title: "analytics", icon: Icons.analytics),
];
List<Widget> screens = [
  MyStore(),
  SupplierOrders(),
  EditBusiness(),
  Preparing(),
  Balance(),
  Statics(),
];
