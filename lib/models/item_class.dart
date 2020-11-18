class Item {
  int id;
  String name;


  Item({this.id, this.name});


  /// Conversions for use with SQLite
  /// To Map...
  /// Function toAMap converts our class to a Map.
  /// Key <String>, data <dynamic>  - data may be int or string in this case
  /// Used BY DBHelper
  Map<String, dynamic> toMap() {
    var mapTo = Map<String, dynamic>();
    mapTo['name'] = name;
    mapTo['id'] = id;
    return mapTo;
  }

  /// From Map...
  /// new named constructor Note.fromMapObject...
  /// Receives a Map object<string, dynamic> and assigns it to mapFrm
  /// Used BY DBHelper
  Item.fromMapObject(Map<String, dynamic> mapFrm) {
    this.name = mapFrm['name'];
    this.id = mapFrm['id'];
  }

  /// Class End.
}
