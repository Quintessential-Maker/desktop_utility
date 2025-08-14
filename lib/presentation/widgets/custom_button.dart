import 'package:dsc_utility/helper/custom_method.dart';
import 'package:dsc_utility/helper/resource/colors.dart';
import 'package:flutter/material.dart';

class MyBasicButton extends StatelessWidget {
  const MyBasicButton({
    Key? key,
    required this.buttonText,
    required this.buttonColor,
    this.width,
    this.onTap,
  }) : super(key: key);
  final String buttonText;
  final Color buttonColor;
  final double? width;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        elevation: 10.0,
        borderRadius: BorderRadius.circular(10.0),
        child: InkWell(
          onTap: onTap,
          child: Container(
            height: 35.0,
            width: width,
            decoration: BoxDecoration(
              color: buttonColor,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Center(
              child: Text(
                buttonText,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18,
                    color: hexToColor(CustomColors.whiteColor),
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
