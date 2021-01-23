import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multitasking_obfuscation/models/ContentPositonModel.dart';
import 'package:multitasking_obfuscation/utils/functions.dart';

class MultitaskingObfuscation {
  static const MethodChannel _channel = const MethodChannel('multitasking_obfuscation');

  static void setContent({
    String pathImage,
    Color backgroundColor = Colors.white,
    Size imageSize,
    ContentPosition contentPosition = ContentPosition.Center,
  }) async {
    if (imageSize == null) imageSize = await getImageSize(pathImage);
    try {
      Uint8List imageBytes = await getBytesFromImage(pathImage);
      await _channel.invokeMethod('init', <String, dynamic>{
        "hexColor": backgroundColor.value,
        "bytesImage": imageBytes,
        "imageWidth": imageSize.width.ceilToDouble(),
        "imageHeight": imageSize.height.ceilToDouble(),
        "contentViewMode": contentPosition.toShortString().toLowerCase(),
      });
    } on PlatformException catch (e) {
      print(e);
    }
  }
}
