import 'dart:convert';

import 'package:dictionary/model/definitions_model.dart';
import 'package:dictionary/model/dictionary_modal.dart';
import 'package:http/http.dart' as http;

class Data {
  DictionaryModel fetchedData = DictionaryModel();
  Future<void> fetchData(String word) async {
    String _token = "3466d155b13170bbb10a582096659dbb777b6201";
    String _url = "https://owlbot.info/api/v4/dictionary/$word";

    var response = await http
        .get(Uri.parse(_url), headers: {"Authorization": "Token " + _token});

    var values = jsonDecode(response.body);
    try {
      DictionaryModel dictionaryModel = DictionaryModel(
        word: values['word'],
        pronunciation: values['pronunciation'],
        definitions: (values['definitions'] as List<dynamic>)
            .map(
              (e) => DefinitionsModel(
                  type: e['type'],
                  definition: e['definition'],
                  example: e['example'],
                  imageUrl: e['image_url'],
                  emoji: e['emoji']),
            )
            .toList(),
      );

      fetchedData = dictionaryModel;
    } catch (e) {
      String res = e.toString();
      throw res;
    }
  }
}
