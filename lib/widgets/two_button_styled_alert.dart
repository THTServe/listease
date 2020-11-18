import 'package:flutter/material.dart';
import 'package:listease/utilities/constants.dart';

/// Builds a Styled Dialog
/// if Button text is not passed leftButton will show cancel right Delete

class TwoButtonStyledAlert extends StatelessWidget {
  final String titleText;
  final String messageText;
  final String leftButtonText;
  final String rightButtonText;

  TwoButtonStyledAlert(
      {this.titleText,
      this.messageText,
      this.leftButtonText,
      this.rightButtonText});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(40.0),
                bottomLeft: Radius.circular(40.0))),
        title: Center(
            child: Text(
          titleText,
          style: TextStyle(
              color: kPinkButtonColour,
              fontWeight: FontWeight.bold,
              fontSize: 40.0),
        )),
        elevation: 40.0,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              messageText,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context, false),
                    child: Container(
                      width: 100.0,
                      height: 25.0,
                      color: kBlackButtonColour,
                      child: Center(
                        child: Text(
                          leftButtonText != null ? leftButtonText : 'Cancel',
                          style: TextStyle(
                            color: kTextPrimaryColour,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 20.0,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context, true),
                    child: Container(
                      width: 100.0,
                      height: 25.0,
                      color: kPinkButtonColour,
                      child: Center(
                        child: Text(
                          rightButtonText != null ? rightButtonText : 'Delete',
                          style: TextStyle(
                            color: kTextPrimaryColour,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
