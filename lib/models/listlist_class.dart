class ListListEntry {
  int _id;
  String name;

  /// Description is Optional for now.
  ListListEntry({this.name});
  ListListEntry.withId(
    this._id,
    this.name,
  );

  /// Create Getters
  /// Basic Getters just conversion to private from external call
  int get listListEntryId => _id;
  String get listListEntryName => name;

  ///Create Setters
  ///Doing some validation here
  set listListEntryName(String value) {
    if (value.length <= 25) {
      this.name = value;
    }
  }

  /// Conversions for use with SQLite
  /// To Map...
  /// Function toAMap converts our class to a Map.
  /// Key <String>, data <dynamic>  - data may be int or string in this case
  /// Used BY DBHelper
  Map<String, dynamic> toAMap() {
    var mapTo = Map<String, dynamic>();
    mapTo['name'] = name;

    // ID is a special case as we need to check if one exists and only map it
    // if one does.
    // Below says if an ID exists (not Null) then map it otherwise do nothing
    if (listListEntryId != null) {
      mapTo['id'] = _id;
    }
    return mapTo;
  }

  /// From Map...
  /// new named constructor Note.fromMapObject...
  /// Receives a Map object<string, dynamic> and assigns it to mapFrm
  /// Used BY DBHelper
  ListListEntry.fromMapObject(Map<String, dynamic> mapFrm) {
    this._id = mapFrm['id'];
    this.name = mapFrm['name'];
  }
}
