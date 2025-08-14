import 'package:dsc_utility/helper/custom_method.dart';
import 'package:dsc_utility/helper/resource/colors.dart';
import 'package:dsc_utility/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String title, description, pButtonText, nButtonText;
  final Image? image;


  final Function()? pButtonOnTap;
  final Function()? nButtonOnTap;

  CustomDialog({
    required this.title,
    required this.description,
    required this.pButtonText,
    required this.nButtonText,
     this.pButtonOnTap,
     this.nButtonOnTap,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final dialogWidth = screenWidth * 0.8; // Screen ka 80% le
    final maxDialogWidth = 400.0; // Max width limit

    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          width: dialogWidth > maxDialogWidth ? maxDialogWidth : dialogWidth,
          padding: const EdgeInsets.only(
            top: 50 + 16,
            bottom: 16,
            left: 16,
            right: 16,
          ),
          margin: const EdgeInsets.only(top: 50),
          decoration: BoxDecoration(
            color: hexToColor(CustomColors.whiteColor),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10.0,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(title, style: themeVariable.titleStyle),
              const SizedBox(height: 16.0),
              Text(
                description,
                textAlign: TextAlign.center,
                style: themeVariable.subTitleStyle,
              ),
              const SizedBox(height: 24.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MyBasicButton(
                    width: 100,
                    buttonText: pButtonText,
                    onTap: pButtonOnTap,
                    buttonColor: hexToColor(CustomColors.secondaryColor),
                  ),
                  MyBasicButton(
                    width: 100,
                    buttonText: nButtonText,
                    onTap: nButtonOnTap,
                    buttonColor: hexToColor(CustomColors.dangerColorBg),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          top: 0,
          child: Container(
            height: 100,
            width: 100,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: hexToColor(CustomColors.primaryColor),
                width: 1,
              ),
              color: hexToColor(CustomColors.whiteColor),
            ),
            child: Center(
              child: Image.asset('assets/images/app_logo_transparent.png'),
            ),
          ),
        ),
      ],
    );
  }

}