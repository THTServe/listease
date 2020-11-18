import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:listease/models/listlist_class.dart';
import 'package:listease/models/shoplist_class.dart';
import 'package:listease/models/item_class.dart';

class DatabaseHelper {
  /// Here we call a class constructor (NoT) a class instance var.
  /// So using Static & Final
  /// Static to call member of the class itself (member being internal var)
  /// final as in this is the only instance of the DB we want.
  DatabaseHelper._createInstance();

  static DatabaseHelper _instance = DatabaseHelper._createInstance();

  /// DATABASE Name and version
  /// Name must be .db
  static final _dbName = 'Listease_v1.db';
  static final _dbVersion = 1;

  /// Details of tables in DB
  ///
  /// ListOfLists TABLE columns
  /// A list of the user created lists
  static final _listListTableName = 'listOfLists';
  static final _listListTableCol_1_PK = 'id';
  static final _listListTableCol_2 = 'name';
  static final _listListTableCol_3 = 'position'; //Not Used yet

  /// SHOP LIST TABLE columns - Table name given by user
  /// Shopping list created by Users
  String shopListTableName;
  static final _shopListTableCol_1_PK = 'id';
  static final _shopListTableCol_2 = 'name';
  static final _shopListTableCol_3 = 'quantity';
  static final _shopListTableCol_4 = 'position'; // reflects position in list
  static final _shopListTableCol_5 = 'inList'; // reflects if appears in list
  static final _shopListTableCol_6 = 'isChecked'; // reflects checked Status

  /// ITEM TABLE
  /// List of all items ever added to DB
  static final _itemsTableName = 'itemsTable';
  static final _itemsTableCol_1_PK = 'id';
  static final _itemsTableCol_2 = 'name';
  static final _itemsTableCol_3 = 'inList';

  /// Build DB
  /// Create an instance of the DB called _database
  static Database _database;

  /// CONSTRUCTOR - Factory Constructor
  /// Factory Constructor allows a value to be returned during construction
  ///
  factory DatabaseHelper() {
    if (_instance == null) {
      _instance = DatabaseHelper._createInstance(); // Executed once only
    }
    return _instance;
  }

  /// Create a Function to get the database instance
  /// new DBs will be Null
  Future<Database> get database async {
    // return the current version if DB is not Null
    if (_database == null) {
      _database = await openAndSetupDB();
    }
    return _database;
  }

  /// Find the path to the docs directory on the user device then create the
  /// DB there.
  Future<Database> openAndSetupDB() async {
    WidgetsFlutterBinding.ensureInitialized();
    var listDatabase;
    // first get the path
    Directory docsDirectory = await getApplicationDocumentsDirectory();
    String path = docsDirectory.path + _dbName;
    // Now we have the path we can ether open or create it there...
    // onCreate calls _createDb if the Table does not already exist.
    listDatabase =
        await openDatabase(path, version: _dbVersion, onCreate: _onCreation);
    return listDatabase;
  }

  Future<int> _onCreation(Database db, int version) async {
    /// On Creation of the DB build the first 2 default Tables
    /// Create the ListOfList Table.
    /// Will start off empty
    int _errorCode;
    try {
      await db.execute('''
      CREATE TABLE $_listListTableName(
      $_listListTableCol_1_PK INTEGER PRIMARY KEY AUTOINCREMENT,
      $_listListTableCol_2 TEXT NOT NULL UNIQUE ON CONFLICT IGNORE,
      $_listListTableCol_3 INTEGER
      )
      ''');

      /// Create Base Items Table
      /// Will Start off empty
      await db.execute('''
      CREATE TABLE $_itemsTableName(
      $_itemsTableCol_1_PK INTEGER PRIMARY KEY AUTOINCREMENT,
      $_itemsTableCol_2 TEXT NOT NULL UNIQUE ON CONFLICT REPLACE,
      $_itemsTableCol_3 INTEGER DEFAULT 0
      )
      ''');
    } catch (e) {
      if (e == null) {
        _errorCode = 0;
      } else {
        // print('There was a DataBase error creating your initial tables');
        _errorCode = 1;
      }
    }
    return _errorCode;
  }

  /// Create ShopListTable
  /// user provides String tableName.
  /// Create empty Table then add all Items to it
  Future<int> createShopListTable(String _tableName) async {
    int _errorCode;
    Database db = await this.database;
    try {
      db.execute('''
      CREATE TABLE IF NOT EXISTS $_tableName(
      $_shopListTableCol_1_PK INTEGER PRIMARY KEY AUTOINCREMENT,
      $_shopListTableCol_2 TEXT NOT NULL,
      $_shopListTableCol_3 TEXT DEFAULT '',
      $_shopListTableCol_4 INTEGER DEFAULT 0,
      $_shopListTableCol_5 INTEGER DEFAULT 0,
      $_shopListTableCol_6 INTEGER DEFAULT 0
      )
      ''');
    } catch (e) {
      if (e == null) {
        _errorCode = 0;
      } else {
        // print('There was a DataBase error creating your list');
        _errorCode = 1;
      }
    }

    // print('$_tableName created');
    return _errorCode;
  }

  /// HELPER FUNCTIONS
  ///
  ///
  /// INSERT Functions
  ///
  /// USING the toAMap function in our item class
  /// if successful it will return the PK value of the inserted item.
  /// LIST OF LISTS
  Future<int> insertIntoListOfLists(ListListEntry newListName) async {
    Database db = await this.database;
    var successVal = await db.insert(_listListTableName, newListName.toAMap());
    return successVal;
  }

  /// USER CREATED SHOP LIST
  Future<int> insertToShopList(_tableName, ShopListEntry newItemName) async {
    Database db = await this.database;
    var result = await db.insert(_tableName, newItemName.toMap());
    return result;
  }

  /// ALL ITEMS LIST
  Future<int> insertIntoItemList(Item itemName) async {
    Database db = await this.database;
    var resultId = await db.insert(_itemsTableName, itemName.toMap());
//    print('insertToItemList: ID: $result');
    return resultId;
  }

  ///
  /// LIST
  ///
  /// List of Lists
  // Future<List<Map<String, dynamic>>> listListListTbl() async {
  //   final Database db = await this.database;
  //   return await db.query(_listListTableName);
  // }
  /// User
  /// List of Items in Specific List
  /// User defined table Name
  // Future<List<Map<String, dynamic>>> listShopListTbl(_tableName) async {
  //   Database db = await this.database;
  //   return await db.query(_tableName);
  // }
  /// Item
  /// List of all Items
  // Future<List<Map<String, dynamic>>> listItemsTbl() async {
  //   final Database db = await this.database;
  //   return await db.query(_itemsTableName);
  // }

  ///
  /// UPDATE
  ///
  /// Master
  /// Provide the new version of master List Instance
  /// Where the id matches the item to update
  /// Returns the number of changes made as an Int
  // Future<int> updateMasterList(ListListEntry _mleUpdate) async {
  //   Database db = await this.database;
  //   var numOfUpdates = await db.update(_listListTableName, _mleUpdate.toAMap(),
  //       where: '$_listListTableCol_1_PK = ?',
  //       whereArgs: [_mleUpdate.listListEntryId]);
  //   return numOfUpdates;
  // }

  /// User
  /// Provide the name of the list being edited and the entry in the list.
  Future<int> updateUserList(
      String _tableName, ShopListEntry _uleUpdate, String _oldName) async {
    Database db = await this.database;
    var result = await db.update(_tableName, _uleUpdate.toMap(),
        where: '$_shopListTableCol_2 = ?', whereArgs: [_oldName]);
    return result;
  }

  /// Item
//   Future<int> updateItemsList(Item _updatedItem) async {
// //    print('updateItemsList: itemName: ${_updatedItem.itemName}, ${_updatedItem.itemStatus}');
//     Database db = await this.database;
//     var result = await db.update(_itemsTableName, _updatedItem.toMap(),
//         where: '$_shopListTableCol_1_PK = ?', whereArgs: [_updatedItem.id]);
// //    print('result: $result item updated in Items List');
//     return result;
//   }

  ///
  /// DELETE
  ///
  /// Master - ID of UserList in Master table
  /// Provide the new version of shoplist Instance
  Future<int> deleteFrmListList(_name) async {
    Database db = await this.database;
    var i = await db.delete(_listListTableName,
        where: '$_listListTableCol_2 = ?', whereArgs: [_name]);
    if (i != 0) {
      db
          .execute('DROP TABLE $_name');
          // .then((value) => print('Dropped Table $_name'));
    }
    return i;
  }

  /// User - ID of Item in User Table
  /// Users List deleted and table Dropped
  Future<int> deleteFrmUserList(String _tableName, _id) async {
    Database db = await this.database;
    var result = await db.delete(_tableName,
        where: '$_shopListTableCol_1_PK = ?', whereArgs: [_id]);
    return result;
  }

  /// Item - Item from Items Table
  Future<int> deleteFrmItemsList(_name) async {
    Database db = await this.database;
    return await db.delete(_itemsTableName,
        where: '$_itemsTableCol_2 = ?', whereArgs: [_name]);
  }

  /// Now adding in the helping functions
  ///
  ///  Provide the name of the Table and get returned a
  ///  List of Maps<String, Dynamic>>
  ///
  Future<List<Map<String, dynamic>>> getTableEntriesAsMap(
      String _tableName) async {
    var result;
    Database db = await this.database;
    result = await db.query(_tableName);
    return result;
  }

  /// Master
  /// Get the 'Map List' { List<Map> } and convert to
  /// 'List of List' { List<MasterListEntry> }
  Future<List<ListListEntry>> getMasterList() async {
    var mapList =
        await getTableEntriesAsMap(_listListTableName); // Get 'Map List'
    int count = mapList.length; // Count entries
    List<ListListEntry> _listOfLists = List<ListListEntry>();
    // Loop to create a note List from Map List
    for (int i = 0; i < count; i++) {
      _listOfLists.add(ListListEntry.fromMapObject(mapList[i]));
      // print('gML: ${mapList[i]}');
    }
    // debugPrint('getMasterList complete');
    return _listOfLists;
  }

  /// User
  /// Get the 'List of Maps' { List<Map> } and convert to
  /// 'Shop List' { List<ShopListEntry> }
  Future<List<ShopListEntry>> getUserShopList(_listTitle) async {
    var listOfMaps = await getTableEntriesAsMap(_listTitle); // Get 'Map List'
    int count = listOfMaps.length; // Count entries
    List<ShopListEntry> _userList = List<ShopListEntry>();
    for (int i = 0; i < count; i++) {
      _userList.add(ShopListEntry.fromMapObject(listOfMaps[i]));
    }
    return _userList;
  }

  /// Item
  /// Get the 'List of Maps' { List<Map> } for ALL Items and convert to
  /// 'User List' { List<UserListEntry> }
  Future<List<Item>> getItemList() async {
    var mapList = await getTableEntriesAsMap(_itemsTableName); // Get 'Map List'
    int count = mapList.length; // Count entries
    List<Item> _listOfItems = List<Item>();
    // Loop to create a note List from Map List
    for (int i = 0; i < count; i++) {
      _listOfItems.add(Item.fromMapObject(mapList[i]));
    }
    return _listOfItems;
  }

// Future<int> getItemId(_name) async {
//   Database db = await this.database;
//   int id = await db.rawQuery(
//       'SELECT ID FROM $_itemsTableName WHERE $_itemsTableCol_2 = $_name');
// }

//  Future<List<Map<String, dynamic>>> getAllListsAsMap() async {
////    debugPrint('Running getAllListsAsMap');
//    Database db = await this.database;
//    var result = await db.query(_masterTableName);
////    debugPrint('getAllListsAsMap complete');
//    return result;
//
//    /// See SQLIte API for details on options ///
//  }

//  /// GET NUmber of DB Entries in Master List:
//  Future<int> getMasterCount() async {
//    Database db = await this.database;
//    // Get a list of our maps/entries
//    List<Map<String, dynamic>> tempList =
//        await db.rawQuery('SELECT COUNT (*) from $_masterTableName');
//
//    /// USE Sqflite.firstIntValue to get the count of entries.
//    int result = Sqflite.firstIntValue(tempList);
////    debugPrint('GetMaster Count complete');
//    return result;
//
//    /// ZERO Returns on failure
//  }

//   /// GET NUmber of DB Entries in Item List:
//   Future<int> getItemCount() async {
//     Database db = await this.database;
//     // Get a list of our maps/entries
//     List<Map<String, dynamic>> tempList =
//         await db.rawQuery('SELECT COUNT (*) from $userListTableName');
//
//     /// USE Sqflite.firstIntValue to get the count of entries.
//     int result = Sqflite.firstIntValue(tempList);
// //    debugPrint('GetItem Count complete');
//     return result;
//
//     /// ZERO Returns on failure
//   }
//   Future<bool> getItemStatus(int _itemId) async {
//     List<Item> tempList = await getItemList();
//     bool result;
//     tempList.forEach((element) {
//       if (element.itemId == _itemId) {
//         result = element.itemStatus;
//       }
//     });
// //    print('getItemStatus: $_itemId : $result');
//
//     return result;
//   }
}
