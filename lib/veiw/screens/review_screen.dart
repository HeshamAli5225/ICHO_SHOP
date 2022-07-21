import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shop/veiw/widgets/payment/green_button.dart';

class ReviewScreen extends StatefulWidget {
  final dynamic order;

  const ReviewScreen({Key? key, required this.order}) : super(key: key);

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  late double rate;

  late String comment;
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RatingBar.builder(
                initialRating: 1,
                minRating: 1,
                allowHalfRating: true,
                itemBuilder: (context, _) {
                  return Icon(
                    Icons.star,
                    color: Colors.amber,
                  );
                },
                onRatingUpdate: (double value) {
                  rate = value;
                },
              ),
              TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: "Enter your review ",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onChanged: (value) {
                  comment = value;
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GreenButton(
                      label: "cancel",
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      width: .3),
                  SizedBox(width: 6),
                  GreenButton(
                      label: "Ok",
                      onPressed: () async {
                        final collRev = FirebaseFirestore.instance
                            .collection("products")
                            .doc(widget.order["proid"])
                            .collection("reviews");
                        await collRev
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .set({
                          "name": widget.order["custname"],
                          "email": widget.order["email"],
                          "rate": rate,
                          "comment": comment,
                          "image": widget.order["custname"][0]
                              .toString()
                              .toUpperCase()
                        }).whenComplete(() async {
                          await FirebaseFirestore.instance
                              .runTransaction((transaction) async {
                            DocumentReference documentReference =
                                FirebaseFirestore.instance
                                    .collection("orders")
                                    .doc(widget.order["orderid"]);
                            transaction.update(documentReference, {
                              "orderreview":true
                            });
                          });
                          Navigator.pop(context);
                        });
                      },
                      width: .3),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
