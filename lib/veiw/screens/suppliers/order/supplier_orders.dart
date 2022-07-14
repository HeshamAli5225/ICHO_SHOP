import 'package:flutter/material.dart';
import 'package:shop/utils/theme.dart';
import 'package:shop/veiw/screens/suppliers/order/preparing_orders.dart';
import 'package:shop/veiw/screens/suppliers/order/shipping_orders.dart';

import '../../../widgets/payment/green_button.dart';
import 'delivered_orders.dart';

class SupplierOrders extends StatelessWidget {
  const SupplierOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: AppBarBackButton(),
          title: Text('Orders'),
          bottom: const TabBar(
              indicatorColor: mainColor,
              indicatorWeight: 8,
              tabs: [
                RepeatedTab(label: 'Preparing'),
                RepeatedTab(label: 'Shipping'),
                RepeatedTab(label: 'Delivered'),
              ]),
        ),
        body: TabBarView(children: [
          Preparing(),
          Shipping(),
          Delivered(),
        ]),
      ),
    );
  }
}

class RepeatedTab extends StatelessWidget {
  final String label;

  const RepeatedTab({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Center(
          child: Text(
        label,
        style: const TextStyle(color: Colors.grey),
      )),
    );
  }
}
