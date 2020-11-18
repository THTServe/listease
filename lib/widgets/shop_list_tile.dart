import 'package:flutter/material.dart';

// import 'package:listease/Screens/edit_SLE_screen.dart';
import 'package:listease/utilities/constants.dart';

class ShopListTile extends StatelessWidget {
  final String title;
  final String quantity;
  final int position;
  final Key key;
  final bool isSelected;

  final Function(String) mainTileTap;
  final Function(List<dynamic>) mainTileDoubleTap;
  final Function(String) deleteTileTap;

  ShopListTile(
      {@required this.title,
      this.quantity,
      this.position,
      this.key,
      this.mainTileTap,
      this.mainTileDoubleTap,
      this.deleteTileTap,
      this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      child: GestureDetector(
        onTap: () {
          mainTileTap(title);
        },
        onDoubleTap: () {
          mainTileDoubleTap([title, quantity, position, isSelected]);
        },
        child: Container(
          height: 40.0,
          padding: EdgeInsets.all(2.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// Quantity
              Padding(
                padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: isSelected ? kPrimaryLight : kTextFieldColour,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20.0),
                          bottomLeft: Radius.circular(20.0)),
                      boxShadow: [buildBoxShadow()]),
                  width: 80.0,
                  padding: EdgeInsets.all(8.0),
                  // color: kTextFieldColour,
                  child: Center(
                    child: Text(
                      quantity,
                      style: isSelected
                          ? checkedTextStyle()
                          : uncheckedTextStyle(),
                    ),
                  ),
                ),
              ),

              /// Title
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 5.0, right: 5.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: isSelected ? kPrimaryLight : kTextFieldColour,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20.0),
                            bottomLeft: Radius.circular(20.0)),
                        boxShadow: [buildBoxShadow()]),
                    padding: EdgeInsets.only(left: 15.0, top: 8.0, bottom: 8.0),
                    child: Text(title,
                        style: isSelected
                            ? checkedTextStyle()
                            : uncheckedTextStyle()),
                  ),
                ),
              ),

              /// Delete
              InkWell(
                onTap: () => deleteTileTap(title),
                child: Padding(
                  padding: EdgeInsets.only(left: 5.0, right: 5.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: isSelected ? kPrimaryLight : kTextFieldColour,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20.0),
                            bottomLeft: Radius.circular(20.0)),
                        boxShadow: [buildBoxShadow()]),
                    width: 32.0,
                    padding: EdgeInsets.fromLTRB(2.0, 10.0, 0, 10.0),
                    child: Icon(
                      Icons.delete,
                      size: 17.0,
                      color: isSelected ? Colors.grey : kBlackButtonColour,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextStyle checkedTextStyle() {
    return TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
        decoration: TextDecoration.lineThrough,
        color: Colors.grey);
  }

  TextStyle uncheckedTextStyle() {
    return TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold);
  }
}
