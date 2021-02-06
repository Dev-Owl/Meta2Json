import 'dart:convert';
import 'dart:io';

import 'package:meta2json/meta2json.dart' as meta2json;

void main(List<String> arguments) async {
  final mediumMetaNodes = [
    MapEntry('name', 'title'),
    MapEntry('property', 'article:published_time'),
    MapEntry('property', 'og:title'),
    MapEntry('property', 'al:android:url'),
    MapEntry('property', 'al:ios:url'),
    MapEntry('name', 'description'),
    MapEntry('property', 'og:description'),
    MapEntry('property', 'og:url'),
    MapEntry('property', 'og:image'),
    MapEntry('name', 'twitter:image:src'),
    MapEntry('property', 'article:author'),
    MapEntry('name', 'twitter:creator'),
    MapEntry('name', 'author'),
    MapEntry('name', 'twitter:label1'),
    MapEntry('name', 'twitter:data1'),
  ];
  if (arguments.isEmpty) {
    print('Provide URL as first argument');
    print(
        'Optional provide output path for json, if not set current folder with timestamp.json will be used');
    exit(-1);
  }
  final url = arguments.first;
  final response = await meta2json.fromUrl(
    url,
    filter: (metaNode) => metaNode.attributes.entries.any(
      (element) => mediumMetaNodes.any(
          (e) => e.key == element.key.toString() && e.value == element.value),
    ),
  );
  if (arguments.length >= 2) {
    final outPutPath = arguments[1];
    final targetFile = File(outPutPath);
    await targetFile
        .writeAsString(jsonEncode(response.map((e) => e.attributes).toList()));
  }
  exit(0);
}
