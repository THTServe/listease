import 'package:flutter/material.dart';
import 'package:listease/utilities/constants.dart';

class ListListTile extends StatelessWidget {
  final String title;
  final Key key;
  final Function(String) mainTileTap;
  final Function(String) deleteTileTap;
  ListListTile(
      {@required this.title, this.key, this.mainTileTap, this.deleteTileTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      child: GestureDetector(
        onTap: () => mainTileTap(title),
        child: Container(
          height: 47.0,
          padding: EdgeInsets.all(2.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// Main Tile
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 5.0, right: 5.0),
                  child: Container(
                    height: 40,
                    decoration: buildTileDecoration(),
                    padding: EdgeInsets.only(left: 15.0, top: 8.0, bottom: 8.0),
                    child: Center(
                        child: Text(
                      title.replaceAll('_', ' '),
                      style: TextStyle(
                          fontSize: 18.0,
                          // fontFamily: 'ArchitectsDaughter',
                          fontWeight: FontWeight.w900),
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
                    decoration: buildTileDecoration(),
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
