import 'package:flutter/material.dart';
import 'package:listease/utilities/constants.dart';

class EditShopListEntry extends StatelessWidget {
  final itemNameController = TextEditingController();
  final itemAmountController = TextEditingController();
  final List<dynamic> currentItem;

  EditShopListEntry({this.currentItem});

  @override
  Widget build(BuildContext context) {
    FocusNode nodeOne = FocusNode();
    FocusNode nodeTwo = FocusNode();

    itemNameController.value =
        itemNameController.value.copyWith(text: currentItem[0]);
    itemAmountController.value =
        itemAmountController.value.copyWith(text: currentItem[1]);
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
                            'Edit Item',
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
                                  width: 100.0,
                                  color: kPrimaryDark,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Text(
                                      'Name',
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

                                    controller: itemNameController,
                                    onEditingComplete: () {
                                      if (itemNameController.text.isEmpty)
                                        return;
                                    },
                                    autofocus: true,
                                    focusNode: nodeOne,
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
                                        labelText: 'Item Name',
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0))),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 18.0, right: 8.0, top: 8.0),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                child: Container(
                                  height: 49.0,
                                  width: 100.0,
                                  color: kPrimaryDark,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Text(
                                      'Quantity',
                                      style: buildTextStyle(),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 19.0),
                                child: Container(
                                  height: 49,
                                  child: TextField(
                                    onChanged: (value) {},
                                    controller: itemAmountController,
                                    autofocus: false,
                                    focusNode: nodeTwo,
                                    cursorColor: kPinkButtonColour,
                                    cursorWidth: 5.0,
                                    cursorRadius: Radius.circular(10.0),
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      color: kBlackButtonColour,
                                    ),
                                    decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 8.0),
                                      labelText: 'Item quantity',
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                    // decoration: null,
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
                                  // --------------------------------------- Cancel<<<
                                  onTap: () {
                                    Navigator.pop(context);
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
                                  // --------------------------------------- Edit<<<
                                  /// Pass back 2 Strings in a list 1 for item
                                  /// name and 1 for item quantity
                                  onTap: () {
                                    final List itemList = [];
                                    itemList.add(itemAmountController.text);
                                    itemList.add(itemNameController.text);
                                    Navigator.pop(context, itemList);
                                    // addItemTextController.dispose();

                                  },
                                  child: Container(
                                    height: 45.0,
                                    width: 140.0,
                                    color: kPinkButtonColour,
                                    child: Center(
                                      child: Text(
                                        'Update',
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
}
