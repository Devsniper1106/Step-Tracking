import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.onTap,
    required this.icon,
  }) : super(key: key);
  final Icon icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 196, 196, 196),
          borderRadius: const BorderRadius.all(
            Radius.circular(25.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.9),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(0, 2),
            )
          ]),
      child: IconButton(
        iconSize: 32,
        onPressed: onTap,
        icon: icon,
      ),
    );
  }
}
