import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shop/model/facebook_model.dart';
import 'package:shop/model/user_model.dart';
import 'package:shop/routes/routes.dart';
import 'package:get_storage/get_storage.dart';

class AuthController extends GetxController {
  bool isVisible = false;
  bool isCheckBox = true;
  var displayUserName = '';
  var displayUserPhoto = '';
  FaceBookModel? faceBookModel;
  var user = FirebaseFirestore.instance.collection("users");
  FirebaseAuth auth = FirebaseAuth.instance;
  var googleSignIn = GoogleSignIn();
  var isSignIn = false;
  var signInBefore = false;
  final GetStorage authBox = GetStorage();
  final GetStorage signInBeforeBox = GetStorage();
  final GetStorage userType= GetStorage();

  void visibility() {
    isVisible = !isVisible;
    update();
  }

  void checkBox() {
    isCheckBox = !isCheckBox;
    update();
  }

  void signUpUsingFirebase({
    required String name,
    required String email,
    required String phone,
    required String address,
    required String type,
    required String password,
  }) async {
    /////////
    try {
      await auth
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) {
        displayUserName = name;
        auth.currentUser!.updateDisplayName(displayUserName);
        // user.doc(auth.currentUser?.uid).set({
        //   "email": email,
        //   "name": name,
        //   "image": name.trim()[0].toUpperCase(),
        // });

        createUserInFirestore(name: name, uId: value.user!.uid, email: email, phone: phone, address: address, type: type, password: password);
      });
      isSignIn = true;
      authBox.write('auth', isSignIn);
      signInBefore = true;
      signInBeforeBox.write('signInBefore', signInBefore);
      update();
      if(type=='buyer'){userType.write('type', 'buyer');Get.offNamed(Routes.mainScreen);}
      else if (type=='seller'){userType.write('type', 'seller');Get.offNamed(Routes.SupplierScreen);}

      print('Success');
    } on FirebaseAuthException catch (e) {
      String title = e.code.replaceAll(RegExp('-'), ' ').capitalize!;
      String message = '';
      if (e.code == 'weak-password') {
        message = 'The password is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = 'This email already is used';
      } else {
        message = e.message.toString();
      }
      Get.snackbar(
        title,
        message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.isDarkMode ? Colors.redAccent : Colors.blueGrey,
        colorText: Colors.white,
      );
      print(e.code.toString());
      print(e.message.toString());
    } catch (error) {
      Get.snackbar(
        'Error',
        error.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.isDarkMode ? Colors.redAccent : Colors.blueGrey,
        colorText: Colors.white,
      );
      print(error.toString());
      print('Error 2');
    }
    //////////
  }

  void createUserInFirestore({
    required String name,
    required String uId,
    required String email,
    required String phone,
    required String address,
    required String type,
    required String password,
  }) async {
    UserModel userModel=UserModel(id: uId, name: name, email: email, phone: phone, address: address, type: type);
    /////////
    try {
      FirebaseFirestore.instance.collection('users').doc(uId).set(userModel.toMap()).then((value) {});
    }  catch (error) {
      print('error in create user in fireStore');
      print('**$error**');
    }
    //////////
  }


  void logInUsingFirebase({
    required String email,
    required String password,
  }) async {
    try {
      var type='cc';
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        displayUserName = auth.currentUser!.displayName!;
       var id= value.user?.uid;
        FirebaseFirestore.instance.collection('users').doc(id).get().then((value){
          type=value.data()!['type'];
          print('typeIs '+value.data()!['type']);
          print('typeInner'+type);

          isSignIn = true;
          authBox.write('auth', isSignIn);
          signInBefore = true;
          signInBeforeBox.write('signInBefore', signInBefore);
          update();print('type'+type);
          if(type=='buyer'){userType.write('type', 'buyer');Get.offNamed(Routes.mainScreen);}
          else if (type=='seller'){userType.write('type', 'seller');Get.offNamed(Routes.SupplierScreen);}

        }).catchError((error){});
       print('hereId'+id!);
        print('typeInner2'+type);
      });


    } on FirebaseAuthException catch (e) {
      String title = e.code.replaceAll(RegExp('-'), ' ').capitalize!;
      String message = '';
      if (e.code == 'user-not-found') {
        message = 'Account not exist for that email.';
      } else if (e.code == 'wrong-password') {
        message = 'Invalid password.';
      } else {
        message = e.message.toString();
      }
      Get.snackbar(
        title,
        message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.isDarkMode ? Colors.redAccent : Colors.blueGrey,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.isDarkMode ? Colors.redAccent : Colors.blueGrey,
        colorText: Colors.white,
      );
    }
  }

  void resetPassword(String email) async {
    try {
      auth.sendPasswordResetEmail(email: email);
      update();
      Get.back();
    } on FirebaseAuthException catch (e) {
      String title = e.code.replaceAll(RegExp('-'), ' ').capitalize!;
      String message = '';
      if (e.code == 'user-not-found') {
        message = 'Account not exist for that email.';
      } else {
        message = e.message.toString();
      }
      Get.snackbar(
        title,
        message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.isDarkMode ? Colors.redAccent : Colors.blueGrey,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.isDarkMode ? Colors.redAccent : Colors.blueGrey,
        colorText: Colors.white,
      );
    }
  }

  void signUpUsingGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      displayUserName = googleUser!.displayName!;
      displayUserPhoto = googleUser.photoUrl!;
      isSignIn = true;
      authBox.write('auth', isSignIn);
      signInBefore = true;
      signInBeforeBox.write('signInBefore', signInBefore);
      update();
      Get.offNamed(Routes.mainScreen);
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.isDarkMode ? Colors.redAccent : Colors.blueGrey,
        colorText: Colors.white,
      );
      print(e.toString());
    }
  }

  void signUpUsingFaceBook() async {
    final LoginResult loginResult = await FacebookAuth.instance.login();
    if (loginResult.status == LoginStatus.success) {
      var data = await FacebookAuth.instance.getUserData();
      faceBookModel = FaceBookModel.fromJson(data);
      print(faceBookModel!.name);
      print(faceBookModel!.email);

      isSignIn = true;
      authBox.write('auth', isSignIn);
      signInBefore = true;
      signInBeforeBox.write('signInBefore', signInBefore);
      update();
      Get.offNamed(Routes.mainScreen);
    }
  }

  void signOut() async {
    try {
      await auth.signOut();
      // try {
      //   await googleSignIn.signOut();
      // } catch (e) {}

      displayUserName = '';
      displayUserPhoto = '';
      isSignIn = false;
      authBox.remove('auth');
      userType.remove('type');
      update();

      Get.offNamed(Routes.LoginScreen);
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.isDarkMode ? Colors.redAccent : Colors.blueGrey,
        colorText: Colors.white,
      );
    }
  }
}

