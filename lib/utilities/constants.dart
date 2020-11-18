import 'package:flutter/material.dart';

///Background COLOURS
const kPrimaryLight = Color(0xFFB2DFDB);
const kPrimaryDark = Color(0xFF009688);

///Button COLOURS
const kPinkButtonColour = Color(0xFFE040FB);
const kBlackButtonColour = Color(0xFF212121);

///Text COLOURS
const kTextFieldColour = Color(0xFFffffff);
const kTextPrimaryColour = Color(0xFFffffff);

/// Box Decoration
BoxDecoration buildTileDecoration() {
  return BoxDecoration(
      color: kTextFieldColour,
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(20.0), bottomLeft: Radius.circular(20.0)),
      boxShadow: [buildBoxShadow()]);
}

BoxShadow buildBoxShadow() {
  return BoxShadow(
      color: Colors.grey[600], blurRadius: 8.0, offset: Offset(1.0, 4.0));
}
