import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  Color color;
  String? label;
  Function onPressed;

  MyButton(
      {Key? key,
        required this.color,
        required this.label,
        required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Material(
        elevation: 5,
        shadowColor: Colors.red[900]!,
        color: color,
        borderRadius: BorderRadius.circular(15),
        child: MaterialButton(
          minWidth: width - 50,
          onPressed: () => onPressed(),
          child: Text(
            label!,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: Colors.grey[200]),
          ),
        ));
  }
}
