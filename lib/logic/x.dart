import 'package:flutter/material.dart';

Widget buildElement(matrixController) {
  return ListView.separated(
    itemBuilder: (context, index) => TextField(
      controller: matrixController[index],
    ),
    separatorBuilder: (context, index) => const SizedBox(
      height: 8,
    ),
    itemCount: matrixController.length,

  );
}
