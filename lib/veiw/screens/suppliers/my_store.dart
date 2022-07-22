import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop/veiw/screens/suppliers/manage_product/visit_store.dart';

import '../../widgets/payment/green_button.dart';

class MyStore extends StatelessWidget {
  const MyStore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        elevation: 0,
        backgroundColor: Colors.white,
        leading: AppBarBackButton(),
        title: Text('MyStore'),


      ),
      body: VisitStore(suppId: FirebaseAuth.instance.currentUser!.uid,),
    );
  }
}
