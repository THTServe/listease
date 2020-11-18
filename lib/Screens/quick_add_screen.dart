import 'package:flutter/material.dart';
import 'package:listease/utilities/constants.dart';
import 'package:listease/widgets/items_list_tile.dart';
import 'package:listease/widgets/two_button_styled_alert.dart';
import 'package:listease/database/database_helper.dart';

class QuickAddScreen extends StatefulWidget {
  @override
  _QuickAddScreenState createState() => _QuickAddScreenState();
}

class _QuickAddScreenState extends State<QuickAddScreen> {
  List<String> allItems;
  List<bool> allItemsShowStatus;
  DatabaseHelper dbHelper = DatabaseHelper();

  @override
  void initState() {
    // print('initstate run');
    initialGetItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: (Text('Quick Add',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: kTextPrimaryColour,
                ))),
          ),
        ),
        Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: (Text('Select Items to add to this list',
                style: TextStyle(
                  letterSpacing: 2.0,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: kTextPrimaryColour,
                ))),
          ),
        ),
        SizedBox(
          height: 4.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Container(
            child: (Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  child: GestureDetector(
                    // --------------------------------------------------------- Cancel Button <<<
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 100.0,
                      height: 25.0,
                      color: kBlackButtonColour,
                      child: Center(
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            color: kTextPrimaryColour,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  child: GestureDetector(
                    // --------------------------------------------------------- Done Button <<<
                    onTap: () {
                      Navigator.pop(context, filterAndReturn());
                    },
                    child: Container(
                      width: 100.0,
                      height: 25.0,
                      color: kPinkButtonColour,
                      child: Center(
                        child: Text(
                          'Done',
                          style: TextStyle(
                            color: kTextPrimaryColour,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )),
          ),
        ),
        Divider(
          thickness: 2.0,
          indent: 27.0,
          endIndent: 27.0,
        ),
        Container(
          height: 400,
          child: FutureBuilder(
            future: refreshList(),
            //this gets the data for use in Future Builder
            // When the Future returns the result will be available inside aSnapshot
            // Initially the data may be Null so deal with this first.
            builder: (BuildContext context, AsyncSnapshot aSnapshot) {
              if (aSnapshot.data == null) {
                return Container(
                  child: Center(
                    child: Text('Loading...'),
                  ),
                );
              } else {
                allItems = aSnapshot.data;
                return ListView.builder(
                  itemCount: allItems.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ItemsListTile(
                      title: allItems[index],
                      // isSelected: true,
                      isSelected: allItemsShowStatus[index] == null
                          ? false
                          : allItemsShowStatus[index],
                      // ------------------------------------------------------- toggle status <<<
                      mainTileTap: (tileTitle) => toggleTileState(tileTitle),
                      // ------------------------------------------------------- delete button <<<
                      deleteTileTap: (tileTitle) => deleteItem(tileTitle),
                    );
                  },
                );
              }
            },
          ),
        ),
      ],
    );
  }

  /// METHODS

  deleteItem(String _value) {
    // print('Delete $_value Pressed');
    TwoButtonStyledAlert deleteAlert = TwoButtonStyledAlert(
      titleText: 'Warning',
      messageText: 'Permanently remove $_value?',
    );
    showDialog(context: context, builder: (_) => deleteAlert).then((response) {
      if (response == true) {
        dbHelper.deleteFrmItemsList(_value).then((value) {
          for (int i = 0; i < allItems.length; i++) {
            if (allItems[i] == _value) {
              setState(() {
                allItems.removeAt(i);
              });
            }
          }
        });
      }
    });
  }

  toggleTileState(String name) {
    int i;
    // print('Toggle tile: $name');
    // print('${allItems.length} items in list');
    if (name != null) {
      for (i = 0; i < allItems.length; i++) {
        // find the index first then reverse value at that index in
        // allItemsShowStatus
        if (allItems[i] == name) {
          setState(() {
            allItemsShowStatus[i] = !allItemsShowStatus[i];
          });
        }
      }
    }
  }

  /// Check if the item is checked and should be added to the current list
  /// if yes add to a new temp list then pop the screen and return the new items
  List<String> filterAndReturn() {
    List<String> itemsToAdd = [];
    for (int i = 0; i < allItems.length; i++) {
      if (allItemsShowStatus[i] == true) {
        itemsToAdd.add(allItems[i]);
      }
    }
    return itemsToAdd;
  }

  Future<List> refreshList() async {
    List<String> dbItems = [];
    //Get List of all items.
    var fList = await dbHelper.getItemList();
    int _count = fList.length;
    // add to a list and sort
    for (int i = 0; i < _count; i++) {
      dbItems.add(fList[i].name);
      dbItems.sort((a, b) => a.compareTo(b));
    }
    // print('getAllItemsList Complete');
    return dbItems;
  }

  Future<List> initialGetItems() async {
    List<String> dbItems = [];
    List<bool> dbListState = [];
    //Get List of all items.
    var fList = await dbHelper.getItemList();
    int _count = fList.length;
    // add to a list and sort
    for (int i = 0; i < _count; i++) {
      dbListState.add(false);
      dbItems.add(fList[i].name);
      dbItems.sort((a, b) => a.compareTo(b));
    }
    allItemsShowStatus = dbListState;
    return dbItems;
  }
}
