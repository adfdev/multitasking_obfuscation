import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<Uint8List> getBytesFromImage(String pathImage) async {
  final ByteData bytes = await rootBundle.load(pathImage);
  return bytes.buffer.asUint8List();
}

Future<Size> getImageSize(String pathImage) {
  Completer<Size> completer = Completer();
  Image image = Image.asset(pathImage);
  image.image.resolve(ImageConfiguration()).addListener(
    ImageStreamListener(
      (ImageInfo image, bool synchronousCall) {
        var myImage = image.image;
        Size size = Size(myImage.width.toDouble(), myImage.height.toDouble());
        completer.complete(size);
      },
    ),
  );
  return completer.future;
}
