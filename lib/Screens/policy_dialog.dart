import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class PolicyDialog extends StatelessWidget {
  final Key key;
  final String mdFileName;
  final double radius;
  PolicyDialog({@required this.mdFileName, this.key, this.radius = 8.0})
      : assert(mdFileName.contains('.md')),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
      child: Column(
        children: [
          Expanded(
              child: FutureBuilder(
            future: Future.delayed(Duration(milliseconds: 150)).then((value) {
              return rootBundle.loadString('lib/assets/$mdFileName');
            }),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Markdown(
                  data: snapshot.data,
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          )),
          FlatButton(
              padding: EdgeInsets.all(8),
              color: Theme.of(context).buttonColor,
              onPressed: () => Navigator.of(context).pop(),
              child: Text('CLOSE')),
        ],
      ),
    );
  }
}
