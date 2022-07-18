// import 'package:flutter/material.dart';
// import 'package:shop/veiw/widgets/text_utils.dart';
//
// class DeliveryContainerWidget extends StatefulWidget {
//   @override
//   State<DeliveryContainerWidget> createState() =>
//       _DeliveryContainerWidgetState();
// }
//
// class _DeliveryContainerWidgetState extends State<DeliveryContainerWidget> {
//   int radioContainerIndex = 1;
//   bool selectContainerColor=false;
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         buildRadioContainer(
//         name: 'store of the shop',
//         title: 'IChO ShOP',
//         address: 'Cairo-Nasr City',
//         phone: '01152253959',
//         iconWidget: Container(),
//         value: 1,
//         onChanged: (value){
//           setState(() {
//             radioContainerIndex=value;
//             selectContainerColor=!selectContainerColor;
//           });
//         }
//         ,color:selectContainerColor? Colors.white:Colors.grey.shade300,
//         ),
//         SizedBox(height: 10,),
//         buildRadioContainer(
//           name: 'Hesham Ali',
//           title: 'Delivery',
//           address: 'bani suef-sumusta',
//           phone: '34355415340',
//           iconWidget: Icon(Icons.contact_phone),
//           value: 2,
//           onChanged: (value){
//             setState(() {
//               radioContainerIndex=value;
//               selectContainerColor=!selectContainerColor;
//             });
//           }
//           ,color:selectContainerColor?Colors.grey.shade300 :Colors.white,
//         ),
//       ],
//     );
//   }
//
//   Widget buildRadioContainer({
//     required Color color,
//     required int value,
//     required Function onChanged,
//     required String name,
//     required String title,
//     required String phone,
//     required String address,
//     required Widget iconWidget,
//   }) {
//     return Container(
//       height: 120,
//       width: double.infinity,
//       decoration: BoxDecoration(
//         color: color,
//         borderRadius: BorderRadius.circular(15),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.2),
//             spreadRadius: 1,
//             blurRadius: 10,
//           )
//         ],
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Radio(
//             value: value,
//             groupValue: radioContainerIndex,
//             fillColor: MaterialStateColor.resolveWith((states) => Colors.red),
//             onChanged: (value) {
//               onChanged(value);
//             },
//           ),
//           SizedBox(
//             width: 10,
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 10.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisSize: MainAxisSize.max,
//               children: [
//                 TextUtils(
//                     text: title,
//                     color: Colors.black,
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                 ),
//                 SizedBox(height: 5,),
//                 TextUtils(
//                   text: name,
//                   color: Colors.black,
//                   fontSize: 15,
//                   fontWeight: FontWeight.bold,
//                 ),
//                 SizedBox(height: 5,),
//
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Row(
//                       //mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                       Text('🇪🇬+2 ',style: TextStyle(color: Colors.black),)
//                       ,TextUtils(
//                         text: phone,
//                         color: Colors.black,
//                         fontSize: 15,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ],),
//                     Container(child: iconWidget,)
//                   ],
//                 ),
//                 SizedBox(height: 5,),
//                 TextUtils(
//                   text: address,
//                   color: Colors.black,
//                   fontSize: 15,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
