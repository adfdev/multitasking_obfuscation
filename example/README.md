## MultiTaskingObfuscationExample

```dart
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:multitasking_obfuscation/models/ContentPositonModel.dart';
import 'package:multitasking_obfuscation/multitasking_obfuscation.dart';

void main() {
  runApp(MultiTaskingObfuscationExample());
}

class MultiTaskingObfuscationExample extends StatefulWidget {
  @override
  _MultiTaskingObfuscationExampleState createState() => _MultiTaskingObfuscationExampleState();
}

class _MultiTaskingObfuscationExampleState extends State<MultiTaskingObfuscationExample> {
  Color backgroundColor = Colors.white;
  ContentPosition contentPosition = ContentPosition.Center;
  Size imageSize;

  @override
  void initState() {
    super.initState();
    MultitaskingObfuscation.setContent(
      pathImage: "assets/images/example.png",
      imageSize: imageSize,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Multitasking obfuscation'),
        ),
        body: Platform.isAndroid
            ? Container()
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FlatButton(
                      onPressed: () {
                        setState(() {
                          backgroundColor = Colors.green;
                        });
                        setContent();
                      },
                      child: Text("Set green background color"),
                    ),
                    FlatButton(
                      onPressed: () {
                        setState(() {
                          contentPosition = ContentPosition.Top;
                        });
                        setContent();
                      },
                      child: Text("Set content to top"),
                    ),
                    FlatButton(
                      onPressed: () {
                        setState(() {
                          imageSize = Size(120, 120);
                        });
                        setContent();
                      },
                      child: Text("Set image size"),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  void setContent() {
    MultitaskingObfuscation.setContent(
      pathImage: "assets/images/example.png",
      backgroundColor: backgroundColor,
      contentPosition: contentPosition,
      imageSize: imageSize,
    );
  }
}

```