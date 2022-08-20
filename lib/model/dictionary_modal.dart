import 'package:dictionary/model/definitions_model.dart';

class DictionaryModel {
  String? word;
  String? pronunciation;
  List<DefinitionsModel>? definitions;

  DictionaryModel({
    this.word,
    this.pronunciation,
    this.definitions,
  });
}
