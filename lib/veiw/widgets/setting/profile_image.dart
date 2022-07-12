import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:shop/utils/theme.dart';
import 'package:shop/veiw/widgets/text_utils.dart';

class ProfileImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var user = FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        ;
    return FutureBuilder<DocumentSnapshot>(
      future: user.get(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
          snapshot.data!.data() as Map<String, dynamic>;
          return Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.teal,
                //child:
                minRadius: 30,
                maxRadius: 45,
                child: Text("${data["image"]}",style: TextStyle(fontSize: 30),),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextUtils(
                    text: data["name"],
                    color: Get.isDarkMode ? Colors.white : Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  TextUtils(
                    text: data["email"],
                    color: Get.isDarkMode ? Colors.white : Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
            ],
          );
        }
        return const Center(
          child: CircularProgressIndicator(
            color: mainColor,
          ),
        );
      }
    );
  }
}

