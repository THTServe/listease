import 'package:flutter/material.dart';
import 'package:listease/utilities/constants.dart';

class ItemsListTile extends StatelessWidget {
  final String title;
  final bool isSelected;

  // final Key key;
  final Function(String) mainTileTap;
  final Function(String) deleteTileTap;

  ItemsListTile(
      {@required this.title,
      this.isSelected,
      this.mainTileTap,
      this.deleteTileTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      child: GestureDetector(
        onTap: () => mainTileTap(title),
        child: Container(
          height: 40.0,
          padding: EdgeInsets.all(2.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// Main Tile
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 5.0, right: 5.0),
                  child: Container(
                    height: 35,
                    decoration: BoxDecoration(
                        color: isSelected ? kTextFieldColour : kPrimaryLight,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20.0),
                            bottomLeft: Radius.circular(20.0)),
                        boxShadow: [buildBoxShadow()]),
                    padding: EdgeInsets.only(left: 15.0, top: 8.0, bottom: 8.0),
                    child: Center(
                        child: Text(
                      title,
                      style: isSelected
                          ? TextStyle(
                              fontSize: 17.0,
                              fontWeight: FontWeight.w700,
                              color: kPinkButtonColour)
                          : TextStyle(
                              fontSize: 17.0, fontWeight: FontWeight.w700),
                    )),
                  ),
                ),
              ),

              /// Delete Tile
              InkWell(
                onTap: () => deleteTileTap(title),
                child: Padding(
                  padding: EdgeInsets.only(left: 5.0, right: 5.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: isSelected ? kTextFieldColour : kPrimaryLight,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20.0),
                            bottomLeft: Radius.circular(20.0)),
                        boxShadow: [buildBoxShadow()]),
                    width: 32.0,
                    padding: EdgeInsets.fromLTRB(2.0, 10.0, 0, 10.0),
                    child: Icon(
                      Icons.delete,
                      size: 17.0,
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
}
