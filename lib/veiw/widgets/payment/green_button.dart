import 'package:flutter/material.dart';

import '../../../utils/theme.dart';

class AppBarBackButton extends StatelessWidget {
  const AppBarBackButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.arrow_back_ios_new,
        color: Colors.black,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}
class GreenButton extends StatelessWidget {
  final String label;
  final Function() onPressed;
  final double width;
  const GreenButton(
      {Key? key,
      required this.label,
      required this.onPressed,
      required this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: MediaQuery.of(context).size.width * width,
      decoration: BoxDecoration(
          color: mainColor, borderRadius: BorderRadius.circular(25)),
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(
          label,
        ),
      ),
    );
  }
}

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
          color: Colors.black,
          fontFamily: 'Acme',
          fontSize: 28,
          letterSpacing: 1.5),
    );
  }
}

