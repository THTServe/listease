import 'package:flutter/material.dart';
import 'package:listease/utilities/constants.dart';
import 'package:listease/widgets/one_button_styled_alert.dart';

class GetNewListName extends StatelessWidget {
  final listNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        padding: EdgeInsets.only(left: 18.0, right: 18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40.0),
                      bottomLeft: Radius.circular(40.0)),
                  child: Container(
                    decoration: BoxDecoration(color: kTextFieldColour),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text(
                            'Add New List',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                        Divider(
                          color: kBlackButtonColour,
                          thickness: 2.0,
                          indent: 18.0,
                          endIndent: 18.0,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  18.0, 8.0, 8.0, 0.0),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                child: Container(
                                  height: 49.0,
                                  width: 140.0,
                                  color: kPrimaryDark,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Text(
                                      'List Name',
                                      style: buildTextStyle(),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 18.0),
                                child: Container(
                                  height: 49.0,
                                  child: TextField(
                                    textInputAction: TextInputAction.none,
                                    controller: listNameController,
                                    onEditingComplete: () {
                                      if (listNameController.text.isEmpty)
                                        return;
                                    },
                                    autofocus: true,
                                    textCapitalization:
                                        TextCapitalization.words,
                                    cursorColor: kPinkButtonColour,
                                    cursorWidth: 5.0,
                                    cursorRadius: Radius.circular(10.0),
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        color: kBlackButtonColour),
                                    textAlign: TextAlign.start,
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        // hintText: 'Milk',
                                        labelText: 'List Name',
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0))),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 42.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 18.0, bottom: 18.0),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                child: InkWell(
                                  onTap: () {
                                    // print('Add Page - Cancel Button');
                                    Navigator.pop(context);
                                    // listNameController.dispose();
                                  },
                                  child: Container(
                                    height: 45.0,
                                    width: 140.0,
                                    color: kBlackButtonColour,
                                    child: Center(
                                      child: Text(
                                        'Cancel',
                                        style: TextStyle(
                                            color: kTextPrimaryColour,
                                            fontSize: 20.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 18.0, bottom: 18.0),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                child: InkWell(
                                  onTap: () {
                                    if (validTitle(listNameController.text)) {
                                      Navigator.pop(
                                          context, listNameController.text);
                                    } else {
                                      invalidCharWarningDialog(context);
                                    }
                                    // listNameController.dispose();
                                  },
                                  child: Container(
                                    height: 45.0,
                                    width: 140.0,
                                    color: kPinkButtonColour,
                                    child: Center(
                                      child: Text(
                                        'Add List',
                                        style: TextStyle(
                                            color: kTextPrimaryColour,
                                            fontSize: 20.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // TextField(),
                          ],
                        ),
                      ],
                    ),
                  )),
            ),
            SizedBox(
              height: 18,
            ),
          ],
        ),
      ),
    );
  }

  TextStyle buildTextStyle() {
    return TextStyle(
      color: kTextPrimaryColour,
      fontSize: 18.0,
    );
  }

  bool validTitle(String text) {
    bool response = true;
    final validCharacters = RegExp(r'^[a-zA-Z0-9 _]+$');
    // Check for correct chars
    if (!validCharacters.hasMatch(listNameController.text)) {
      response = false;
    }
    if (checkForKeywords(text)) {
      response = false;
    }
    return response;
  }

  bool checkForKeywords(String text) {
    String correctedText = text.toLowerCase();
    List<String> badWords = [
      "add",
      "all",
      "alter",
      "and",
      "as",
      "autoincrement",
      "between",
      "case",
      "check",
      "collate",
      "commit",
      "constraint",
      "create",
      "default",
      "deferrable",
      "delete",
      "distinct",
      "drop",
      "else",
      "escape",
      "except",
      "exists",
      "foreign",
      "from",
      "group",
      "having",
      "if",
      "in",
      "index",
      "insert",
      "intersect",
      "into",
      "is",
      "isnull",
      "join",
      "limit",
      "not",
      "notnull",
      "null",
      "on",
      "or",
      "order",
      "primary",
      "references",
      "select",
      "set",
      "table",
      "then",
      "to",
      "transaction",
      "union",
      "unique",
      "update",
      "using",
      "values",
      "when",
      "where"
    ];
    bool bad = false;
    badWords.forEach((element) {
      if (element == correctedText) {
        bad = true;
      }
    });
    // print('Bad = $bad');
    return bad;
  }

  invalidCharWarningDialog(context) {
    OneButtonStyledAlert invalidCharAlert = OneButtonStyledAlert(
      titleText: 'Invalid Character or Name',
      messageText:
          'Your title contains an invalid Character or name. Names such as \'Drop\' or \'Create\' are reserved by the database. Please choose a different name using aA-zZ 0-9.',
    );
    showDialog(context: context, builder: (_) => invalidCharAlert)
        .then((response) {
      if (response) {
        Navigator.pop(context);
      }
    });
  }
}
