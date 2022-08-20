import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dictionary/data/data.dart';
import 'package:dictionary/model/dictionary_modal.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  TextEditingController? textEditingController = TextEditingController();
  StreamController? streamController;
  Stream? stream;
  DictionaryModel? dictionaryModel;

  @override
  void initState() {
    streamController = StreamController();
    stream = streamController!.stream;
    super.initState();
  }

  @override
  void dispose() {
    textEditingController!.dispose();
    super.dispose();
  }

  _search(String text) async {
    if (textEditingController == null || textEditingController == 0) {
      streamController!.add(null);
      return;
    }

    Data data = Data();
    await data.fetchData(text);
    dictionaryModel = data.fetchedData;
    streamController!.add(data.fetchedData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Dictionary',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        bottom: PreferredSize(
            preferredSize: const Size(double.infinity, 48.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(
                      left: 12.0,
                      bottom: 8.0,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24.0)),
                    child: TextFormField(
                      controller: textEditingController,
                      decoration: const InputDecoration(
                        hintText: 'Search for  word',
                        contentPadding: EdgeInsets.only(left: 24.0),
                        border: InputBorder.none,
                        filled: true,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => _search(textEditingController!.text),
                  icon: const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                ),
              ],
            )),
      ),
      body: StreamBuilder(
        stream: stream,
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return const Center(
              child: Text('Enter a word to search'),
            );
          }
          return Card(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0, 2),
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 10,
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(dictionaryModel!.word!),
                        Text(
                          '/${dictionaryModel!.pronunciation!}/',
                          style: TextStyle(
                            color: Colors.grey[300],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: dictionaryModel!.definitions!.length,
                      itemBuilder: (context, index) {
                        final dictionary = dictionaryModel!.definitions![index];
                        print(dictionary);
                        return Row(
                          children: [
                            Expanded(
                              flex: 10,
                              child: Column(
                                children: [
                                  const Divider(
                                    thickness: 2.0,
                                  ),
                                  Row(
                                    children: [
                                      Text(dictionary.type as String),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Container(
                                        color: Colors.grey[300],
                                        child: const Icon(
                                          Icons.question_mark,
                                          color: Colors.black38,
                                          size: 15,
                                        ),
                                      )
                                    ],
                                  ),
                                  Text(dictionary.definition as String),
                                ],
                              ),
                            ),
                            Expanded(
                              child: CachedNetworkImage(
                                imageUrl: dictionary.imageUrl as String,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
