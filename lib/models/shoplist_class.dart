class ShopListEntry {
  int id;
  String name;
  String quantity;
  int position;
  bool inListStatus;
  bool isCheckedStatus;

  ShopListEntry(
      {this.name,
      this.quantity,
      this.inListStatus,
      this.isCheckedStatus,
      this.position});

  ShopListEntry.withId(
      {this.id,
      this.name,
      this.quantity,
      this.inListStatus,
      this.isCheckedStatus,
      this.position});

  /// Conversions for use with SQLite
  /// To Map...
  /// Function toMap converts our class to a Map.
  /// Key <String>, data <dynamic>  - data may be int or string in this case
  /// Used BY DBHelper
  Map<String, dynamic> toMap() {
    var mapTo = Map<String, dynamic>();
    mapTo['name'] = name;
    mapTo['position'] = position;
    mapTo['quantity'] = quantity;
    //Converting from bool to int
    if (inListStatus == true) {
      mapTo['inList'] = 1;
    } else {
      mapTo['inList'] = 0;
    }

    if (isCheckedStatus == true) {
      mapTo['isChecked'] = 1;
    } else {
      mapTo['isChecked'] = 0;
    }

    // ID is a special case as we need to check if one exists and only map it
    // if one does.
    // Below says if an ID exists (not Null) then map it otherwise do nothing
    if (id != null) {
      mapTo['id'] = id;
    }
    return mapTo;
  }

  /// From Map...
  /// Receives a Map object<string, dynamic> and assigns it to mapFrm
  /// Used BY DBHelper
  ShopListEntry.fromMapObject(Map<String, dynamic> mapFrm) {
    this.id = mapFrm['id'];
    this.name = mapFrm['name'];
    this.position = mapFrm['position'];
    this.quantity = mapFrm['quantity'];
    //Converting from int to bool
    if (mapFrm['inList'] == 0) {
      this.inListStatus = false;
    } else {
      this.inListStatus = true;
    }
    if (mapFrm['isChecked'] == 0) {
      this.isCheckedStatus = false;
    } else {
      this.isCheckedStatus = true;
    }
  }
}
