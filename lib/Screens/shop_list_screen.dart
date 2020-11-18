import 'package:flutter/material.dart';
import 'package:listease/Screens/add_item_screen.dart';
import 'package:listease/Screens/edit_SLE_screen.dart';
import 'package:listease/Screens/quick_add_screen.dart';
import 'package:listease/database/database_helper.dart';
import 'package:listease/models/shoplist_class.dart';
import 'package:listease/utilities/constants.dart';
import 'package:listease/widgets/shop_list_tile.dart';
import 'package:listease/widgets/reorderablelist_elevation_adjust.dart';
import 'package:listease/widgets/two_button_styled_alert.dart';

/// 1. Init State goes to DB and gets a list(getInitialList) of all items in the
/// table for this list.  This is used to build the local list -  userShopList
/// 2. userShopList is used to build the screen with reorderableListView

class ShopListScreen extends StatefulWidget {
  final String listTitle;

  ShopListScreen({this.listTitle});

  @override
  _ShopListScreenState createState() => _ShopListScreenState();
}

class _ShopListScreenState extends State<ShopListScreen> {
  List<ShopListEntry> userShopList;
  DatabaseHelper dbHelper = DatabaseHelper();
  int count = 0;
  String listTitle; //With Underscores
  String listTitleCorrected; //Without underscores

  /// Get initial User shop list which comprises all items
  /// later filter based on in shop list or not
  @override
  void initState() {
    getInitialList(widget.listTitle);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (userShopList == null) {
      userShopList = List<ShopListEntry>();
      listTitleCorrected = widget.listTitle.replaceAll('_', ' ');
      listTitle = widget.listTitle;
      // print('Build Start - Listtitle: $listTitle as Null');
      refreshList(listTitle);
    }

    return WillPopScope(
      onWillPop: () {
        goBack();
      },
      child: Scaffold(
        backgroundColor: kPrimaryDark,
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: kPinkButtonColour,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
          ),
          label: Text(
            'Add Item',
            style: TextStyle(
                color: kTextPrimaryColour,
                fontSize: 15.0,
                fontWeight: FontWeight.w900),
          ),
          elevation: 5.0,
          onPressed: () {
            //---------------------------------------------------------------- Add Button <<<
            showModalBottomSheet(
                    isDismissible: false,
                    isScrollControlled: true,
                    backgroundColor: kPrimaryDark,
                    context: context,
                    builder: (context) => SingleChildScrollView(
                          child: Container(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
                            child: AddItemScreen(),
                          ),
                        ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40.0),
                      ),
                    ),
                    elevation: 2.0)
                .then(
              (value) {
                if (value != null) {
                  // print('Value back from add = ${value[0]}');
                  // print('Value back from add = ${value[1]}');
                  addToShopList(itemName: value[0], quantity: value[1]);
                } else {
                  // print('Value = $value');
                }
              },
            );
          },
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(25.0, 70.0, 25.0, 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 32.0,
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            listTitleCorrected,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: kTextPrimaryColour,
                              fontSize: 40.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          //-------------------------------------------------- Quick Add Button <<<
                          // print('Burger Button Clicked');
                          showModalBottomSheet(
                                  isScrollControlled: true,
                                  backgroundColor: kPrimaryDark,
                                  context: context,
                                  builder: (context) => SingleChildScrollView(
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              bottom: MediaQuery.of(context)
                                                  .viewInsets
                                                  .bottom),
                                          child: QuickAddScreen(),
                                        ),
                                      ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      // topLeft: Radius.circular(30.0),
                                      topRight: Radius.circular(40.0),
                                    ),
                                  ),
                                  elevation: 2.0)
                              .then((listOfEntries) => multiAddToShopList(
                                  listOfItemNames: listOfEntries));
                        },
                        child: Container(
                          child: Icon(
                            Icons.dehaze,
                            color: Colors.white,
                            size: 32.0,
                          ),
                          width: 30.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                  decoration: BoxDecoration(
                    color: kPrimaryLight,
                    borderRadius: BorderRadius.only(
                      // topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(40.0),
                    ),
                  ),
                  child: buildShopList(listTitle, userShopList)),
            ),
          ],
        ),
      ),
    );
  }

  Theme buildShopList(String _listTitle, List<ShopListEntry> _itemList) {
    //Removed(BuildContext context)
    return Theme(
      data: ThemeData(canvasColor: Colors.transparent),
      child: ReorderableListViewNoShadow(
        header: SizedBox(
          height: 18.0,
        ),
        children: [
          /// Main Tile
          for (final entry in userShopList)
            ShopListTile(
              key: ValueKey(entry),
              title: entry.name,
              quantity: entry.quantity,
              position: entry.position,
              isSelected: entry.isCheckedStatus,
              // - Toggle Status Here -------------------------------------------<<<
              mainTileTap: (String _value) => toggleState(_value),
              // - Edit Here ----------------------------------------------------<<<
              mainTileDoubleTap: (List<dynamic> itemData) {
                showModalBottomSheet(
                        isDismissible: false,
                        isScrollControlled: true,
                        backgroundColor: kPrimaryDark,
                        context: context,
                        builder: (context) => SingleChildScrollView(
                              child: Container(
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom),
                                child: EditShopListEntry(
                                  currentItem: itemData,
                                ),
                              ),
                            ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(40.0),
                          ),
                        ),
                        elevation: 2.0)
                    .then(
                  (editedItem) {
                    if (editedItem != null) {
                      // print('itemData[0]:${itemData[0]}');
                      // print('itemData[1]:${itemData[1]}');
                      // print('itemData[2]:${itemData[2]}');
                      // print('itemData[3]:${itemData[3]}');
                      // print('itemName:${editedItem[1]}');
                      // print('quantity:${editedItem[0]}');
                      // print('position:${itemData[2]}');
                      updateShopList(
                          newName: editedItem[1],
                          quantity: editedItem[0],
                          position: itemData[2],
                          oldName: itemData[0]);
                    }
                  },
                );
              },
              // Delete Here ----------------------------------------------------<<<
              deleteTileTap: (_value) => deleteFrmShopList(_value),
            ),
        ],
        onReorder: (oldIndex, newIndex) {
          setState(() {
            if (newIndex > oldIndex) {
              newIndex -= 1;
            }
            final listEntry = userShopList.removeAt(oldIndex);
            userShopList.insert(newIndex, listEntry);
            updateShopListItemPosn(userShopList);
          });
        },
      ),
    );
  }

  /// Check if a quantity was provided, if not set to 1.
  addToShopList({String itemName, String quantity}) {
    quantity == '' ? quantity = '1' : quantity = quantity;
    // print('Val_1: $itemName, Val_0: $quantity');
    // print('Current List Length = $count');
    try {
      if (itemName != '') {
        // print('Starting Add to Shop list for $itemName');
        ShopListEntry newShopListEntry = ShopListEntry();
        newShopListEntry.name = itemName;
        newShopListEntry.quantity = quantity;
        newShopListEntry.position = userShopList.length;
        newShopListEntry.inListStatus = true;
        newShopListEntry.isCheckedStatus = false;
        // print('ShopListEntry instance for $itemName created');
        // print('ATSL: $itemName added in position ${userShopList.length + 1}');
        count++;
        addToShopListTable(listTitle, newShopListEntry).then((value) {
          setState(() {
            userShopList.add(newShopListEntry);
          });
        });
      } else {}
    } catch (e) {
      // print('Error $e with input try again');
    }
  }

  multiAddToShopList({List listOfItemNames}) {
    if (listOfItemNames != null) {
      int _listLen = userShopList.length;
      // print('Current List Length = $_listLen');
      for (int i = 0; i < listOfItemNames.length; i++) {
        //Create an new instance of the class
        ShopListEntry newShopListEntry = ShopListEntry();
        // give it values
        newShopListEntry.name = listOfItemNames[i];
        newShopListEntry.quantity = '1';
        newShopListEntry.position = _listLen;
        newShopListEntry.inListStatus = true;
        newShopListEntry.isCheckedStatus = false;
        _listLen++;
        count++;
        // print(
        //     'ShopListEntry instance for ${listOfItemNames[i]} created at position ${_listLen + 1}');
        addToShopListTable(listTitle, newShopListEntry).then((value) {
          setState(() {
            userShopList.add(newShopListEntry);
          });
        });
      }
    }
  }

  Future<int> addToShopListTable(
      String listTitle, ShopListEntry newShopListEntry) async {
    int i;
    i = await dbHelper.insertToShopList(listTitle, newShopListEntry);
    // print('Shop List Table Insert response = $i');
    return i;
  }

  deleteFrmShopList(String _value) async {
    TwoButtonStyledAlert deleteAlert = TwoButtonStyledAlert(
      titleText: 'Remove',
      messageText: 'Remove $_value from List?',
    );
    showDialog(context: context, builder: (_) => deleteAlert).then((response) {
      if (response == true) {
        for (int i = 0; i < userShopList.length; i++) {
          if (userShopList[i].name == _value) {
            dbHelper.deleteFrmUserList(listTitle, userShopList[i].id);
            // print('Result from DFSL: = $result');
            setState(() {
              userShopList.removeAt(i);
              count--;
              // print('count = $count');
            });
          }
        }
      }
    });
    // print('deleteListEntry: $_value');
  }

  void refreshList(String listTitle) {
    // First get a list of shopListEntries from DB
    // This should comprise all items available
    // dbHelper.getUserShopList(listTitle).then((listFromDb) {
    // Sort the list if 2 or more items long

    userShopList.sort((a, b) => a.position.compareTo(b.position));
    for (int i = 0; i < userShopList.length; i++) {}

    setState(() {
      this.userShopList = userShopList;
      this.count = userShopList.length;
    });
  }

  void toggleState(String title) {
    if (title != null) {
      for (int i = 0; i < userShopList.length; i++) {
        // find the index first then reverse value at that index in
        // userShopList
        if (userShopList[i].name == title) {
          ShopListEntry tempSLE = ShopListEntry();
          tempSLE.name = title;
          tempSLE.quantity = userShopList[i].quantity;
          tempSLE.position = userShopList[i].position;
          tempSLE.isCheckedStatus = !userShopList[i].isCheckedStatus;
          tempSLE.inListStatus = userShopList[i].inListStatus;
          dbHelper
              .updateUserList(listTitle, tempSLE, title)
              .then((value) => setState(() {
                    userShopList[i].isCheckedStatus =
                        !userShopList[i].isCheckedStatus;

                    // print(userShopList[i].isCheckedStatus);
                  }));
        }
      }
    }
    // print('Toggle tile: $title: visible = ${userShopList[i].isCheckedStatus}');
  }

  void getInitialList(String listTitle) {
    List<ShopListEntry> response = [];
    // print('Running Get-Initial-List');
    dbHelper.getUserShopList(listTitle).then((listFromDb) {
      // Sort the list if 2 or more items long
      if (listFromDb.length >= 2) {
        // print('list being sorted as length: ${listFromDb.length}');
        listFromDb.sort((a, b) => a.position.compareTo(b.position));
      }
      for (int i = 0; i < listFromDb.length; i++) {
        // print('name = ${listFromDb[i].name}');
        // print('quantity = ${listFromDb[i].quantity}');
        // print('position = ${listFromDb[i].position}');
        // print('visible? = ${listFromDb[i].inListStatus}');
        // print('checked? = ${listFromDb[i].isCheckedStatus}');
        //Filter only those that should be visible.
        if (listFromDb[i].inListStatus == true) {
          response.add(listFromDb[i]);
        }
      }
      // response = listFromDb;
      setState(() {
        this.userShopList = response;
        this.count = response.length;
        // print(count);
      });
    });
  }

  updateShopList({oldName, newName, quantity, position}) async {
    //Update Item in DB.
    ShopListEntry tempSLE = ShopListEntry();
    tempSLE.name = newName;
    tempSLE.quantity = quantity;
    tempSLE.position = position;
    // tempSLE.isCheckedStatus = !userShopList[i].isCheckedStatus;
    tempSLE.inListStatus = true;
    int result = await dbHelper.updateUserList(listTitle, tempSLE, oldName);
    if (result != 0) {
      // print('dbHelper.UUL: result $result');
      for (int i = 0; i < userShopList.length; i++) {
        if (userShopList[i].name == oldName) {
          setState(() {
            userShopList[i].name = newName;
            userShopList[i].quantity = quantity;
          });
        }
      }
    }
  }

  void updateShopListItemPosn(List<ShopListEntry> userShopList) async {
    // print('updateShopListItemPosn');
    for (int i = 0; i < userShopList.length; i++) {
      int j = await dbHelper.updateUserList(
          listTitle,
          ShopListEntry.withId(
              id: userShopList[i].id,
              name: userShopList[i].name,
              quantity: userShopList[i].quantity,
              position: i,
              inListStatus: userShopList[i].inListStatus,
              isCheckedStatus: userShopList[i].isCheckedStatus),
          userShopList[i].name);
      // if (j != 0) {
      //   // print('ULE Updated $j Entries');
      // } else {
      //   // print('Error updating ULE Table');
      // }
    }
  }

  bool goBack() {
    Navigator.pop(context);
    return true;
  }
}
