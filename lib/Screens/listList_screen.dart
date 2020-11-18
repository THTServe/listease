import 'package:flutter/material.dart';
import 'package:listease/database/database_helper.dart';
import 'package:listease/Screens/get_new_list_screen.dart';
import 'package:listease/Screens/shop_list_screen.dart';
import 'package:listease/models/listlist_class.dart';
import 'package:listease/utilities/constants.dart';
import 'package:listease/widgets/list_list_tile.dart';
import 'package:listease/widgets/reorderablelist_elevation_adjust.dart';
import 'package:listease/widgets/one_button_styled_alert.dart';
import 'package:listease/widgets/two_button_styled_alert.dart';
import 'package:sqflite/sqflite.dart';
import 'package:listease/Screens/InfoScreen.dart';

class ListListScreen extends StatefulWidget {
  @override
  _ListListScreenState createState() => _ListListScreenState();
}

class _ListListScreenState extends State<ListListScreen> {
  /// Create an empty List of lists
  List<ListListEntry> localListOfLists;

  /// Hold the count of these entries.
  int countOfEntries;

  /// Build our database Helper
  DatabaseHelper dbHelper = DatabaseHelper();

  var newListTitle;

  @override
  Widget build(BuildContext context) {
    /// Do an initial check to see if the local List of List exists yet if yes
    /// check the Database
    if (localListOfLists == null) {
      localListOfLists = List<ListListEntry>();
      updateListOfLists();
    }
    return Scaffold(
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
            'Add List',
            style: TextStyle(
                color: kTextPrimaryColour,
                fontSize: 15.0,
                fontWeight: FontWeight.w900),
          ),
          elevation: 5.0,
          onPressed: () {
            // print('Add List Button Clicked');
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
                            child: GetNewListName(),
                          ),
                        ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40.0),
                      ),
                    ),
                    elevation: 2.0)
                .then((newListName) => updateListOfLists(newListName));
          }),
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
                    Center(
                      child: Text(
                        'ListEase',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: kTextPrimaryColour,
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => InfoScreen())),
                      icon: Icon(
                        Icons.info_outline,
                        size: 35.0,
                        color: kTextPrimaryColour,
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
                  topRight: Radius.circular(40.0),
                ),
              ),
              child: Theme(
                data: ThemeData(canvasColor: Colors.transparent),
                child: ReorderableListViewNoShadow(
                  header: SizedBox(
                    height: 18.0,
                  ),
                  children: [
                    for (final entry in localListOfLists)
                      ListListTile(
                        key: ValueKey(entry),
                        title: entry.name,
                        mainTileTap: (String _value) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ShopListScreen(
                                        listTitle: _value,
                                      )));
                        },
                        deleteTileTap: (String value) => deleteList(value),
                      ),
                  ],
                  onReorder: (oldIndex, newIndex) {
                    setState(() {
                      if (newIndex > oldIndex) {
                        newIndex -= 1;
                      }
                      final listEntry = localListOfLists.removeAt(oldIndex);
                      localListOfLists.insert(newIndex, listEntry);
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  updateListOfLists([listTitleUncorrected]) {
    bool uniqueTitle = true;
    String listTitle;
    // SQL cant handle spaces so replace with underscore if not null/first time
    if (listTitleUncorrected != null) {
      listTitle = correctTextInput(listTitleUncorrected);
    }

    /// Open DB and build tables if required.
    /// Check DB for an existing List of Lists
    // print('updateListOfLists-Start');
    if (listTitle == null) {
      final Future<Database> dbFuture = dbHelper.openAndSetupDB();
      dbFuture.then((newDb) {
        Future<List<ListListEntry>> listListFuture = dbHelper.getMasterList();
        listListFuture.then((_listOfLists) {
          setState(() {
            this.localListOfLists = _listOfLists;
            this.countOfEntries = _listOfLists.length;
          });
        });
      });
    } else {
      // List title is not Null case
      // Check to see if list title already exists
      for (final item in localListOfLists) {
        if (item.name == listTitle) {
          uniqueTitle = false;
        }
      }
      uniqueTitle
          ? setState(() {
              // print('$listTitle being added');
              localListOfLists.add(ListListEntry(name: listTitle));
              dbHelper.insertIntoListOfLists(ListListEntry(name: listTitle));
              dbHelper.createShopListTable(listTitle);
            })
          : showNotUniqueDialog();
    }
  }

  deleteList(String _listName) {
    TwoButtonStyledAlert deleteAlert = TwoButtonStyledAlert(
      titleText: 'Warning',
      messageText: 'Permanently remove $_listName?',
    );
    showDialog(context: context, builder: (_) => deleteAlert).then((response) {
      if (response == true) {
        for (int i = 0; i < localListOfLists.length; i++) {
          if (localListOfLists[i].name == _listName) {
            dbHelper.deleteFrmListList(_listName);
            setState(() {
              localListOfLists.removeAt(i);
            });
          }
        }
      }
    });
  }

  showNotUniqueDialog() {
    OneButtonStyledAlert notUnique = OneButtonStyledAlert(
      titleText: 'Duplicate',
      messageText: 'Please choose a unique List Name :-)',
    );
    showDialog(context: context, builder: (_) => notUnique);
  }

  showWarningDeleteDialog(String listName) {
    TwoButtonStyledAlert deleteWarn = TwoButtonStyledAlert(
      titleText: 'Warning',
      messageText: 'Permanently Delete $listName?',
    );
    showDialog(context: context, builder: (_) => deleteWarn);
  }

  correctTextInput(String _value) {
    // Replace any spaces with underline
    _value = _value.replaceAll(' ', '_');
    // if first char is a digit replace with _
    _value = _value.splitMapJoin(RegExp(r'^\d+'),
        onMatch: (m) => '_${m.group(0)}', onNonMatch: (n) => n);
    return _value;
  }
}
