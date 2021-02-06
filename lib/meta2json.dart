import 'dart:math';

import 'package:http/http.dart'; // Contains a client for making API calls
import 'package:html/parser.dart'; // Contains HTML parsers to generate a Document object
import 'package:html/dom.dart';

typedef FilterFunc = bool Function(Element metaNode);

Future<List<MetaNode>> fromUrl(
  String url, {
  FilterFunc filter,
  bool omitDataAttribute = true,
}) async {
  final httpClient = Client();
  final response = await httpClient.get(url);
  if (response.body.isNotEmpty) {
    final parsedDocument = parse(response.body);
    var metaNodesInHeader = parsedDocument.head.querySelectorAll('meta');
    if (filter != null) {
      metaNodesInHeader = metaNodesInHeader.where((e) => filter(e)).toList();
    }
    var result = metaNodesInHeader
        .map(
          (e) => MetaNode(
            e.attributes.map(
              (key, value) => MapEntry(key.toString(), value),
            ),
          ),
        )
        .toList();
    if (omitDataAttribute) {
      result.forEach((element) => element.attributes
          .removeWhere((key, value) => key.startsWith('data-')));
    }
    return result;
  }
  return [];
}

class MetaNode {
  final Map<String, String> attributes;

  MetaNode(this.attributes);
}
