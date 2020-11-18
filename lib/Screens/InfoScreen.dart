import 'package:flutter/material.dart';
import 'package:listease/utilities/constants.dart';

class InfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              'Info Screen',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: kTextPrimaryColour,
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: Container(
        color: kPrimaryLight,
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Container(
              // color: kTextFieldColour,
              decoration: BoxDecoration(
                color: kTextFieldColour,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40.0),
                  bottomLeft: Radius.circular(40.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20.0, top: 5.0),
                child: ListView(
                  children: [
                    SizedBox(
                      height: 12.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Thanks For Trying our App',
                        textScaleFactor: 2,
                      ),
                    ),
                    Divider(
                      thickness: 2.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'This App allows you to build lists in which you can '
                        'add, delete, edit and check off items.  We hope '
                        'you find it useful and intuitive to use but just '
                        'in case, here are some tips... ',
                        textScaleFactor: 1.2,
                      ),
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 4.0),
                      child: Text(
                        '1.  Add New Lists and Items',
                        textScaleFactor: 1.5,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 2.0),
                      child: Text(
                          'Tap the floating pink Button at the bottom right of '
                          'Screens to add a new list or create a new list '
                          'entry.',
                          textScaleFactor: 1.2),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 4.0),
                      child: Text(
                        '2.  QuickAdd Previous Items',
                        textScaleFactor: 1.5,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 2.0),
                      child: Text(
                        'Tap the 3 Horizontal bars at the top right of the '
                        'screen to open QuickAdd.  From there you can select '
                        'items you have previously added to your database.  '
                        'Tap done to and your selection is added to the list.',
                        textScaleFactor: 1.2,
                      ),
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 4.0),
                      child: Text(
                        '3.  Check off your list',
                        textScaleFactor: 1.5,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 2.0),
                      child: Text(
                        'Tap on an item in your list to mark it as done.',
                        textScaleFactor: 1.2,
                      ),
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 4.0),
                      child: Text(
                        '4.  Re-Order your list',
                        textScaleFactor: 1.5,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 2.0),
                      child: Text(
                        'Want your lists and a different order? Hold on the item you want to move until it floats, move and then drop.',
                        textScaleFactor: 1.2,
                      ),
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 4.0),
                      child: Text(
                        '5.  Edit your list',
                        textScaleFactor: 1.5,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 2.0),
                      child: Text(
                        'Double Tap a list entry to edit it\'s Title or Quantity.',
                        textScaleFactor: 1.2,
                      ),
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 4.0),
                      child: Text(
                        '6.  Save to Database',
                        textScaleFactor: 1.5,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 2.0),
                      child: Text(
                        'This App auto-saves its data to a database locally on your '
                        'phone.  This means that the lists, items in them,  '
                        'their position and if they are checked off or not '
                        'are all saved for you without the need for a mobile or '
                        'wifi signal.',
                        textScaleFactor: 1.2,
                      ),
                    ),
                    Divider(
                      thickness: 2.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 4.0),
                      child: Text(
                        'Privacy Policy',
                        textScaleFactor: 1.5,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 2.0),
                      child: Text(
                        'This App does not collect or send any data externally.  '
                        'All data is used solely by the app and not shared in any way.',
                        textScaleFactor: 1.2,
                      ),
                    ),
                    Divider(
                      thickness: 2.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 4.0),
                      child: Text(
                        'Terms Of Use',
                        textScaleFactor: 1.5,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 2.0),
                      child: Text(
                        'Add Here',
                        textScaleFactor: 1.2,
                      ),
                    ),
                    Divider(
                      thickness: 2.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 4.0),
                      child: Text(
                        'Contact Support',
                        textScaleFactor: 1.5,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 2.0),
                      child: Text(
                        'Add Here',
                        textScaleFactor: 1.2,
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
