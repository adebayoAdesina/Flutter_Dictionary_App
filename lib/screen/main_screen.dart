import 'dart:async';
import 'package:dictionary/data/data.dart';
import 'package:dictionary/model/dictionary_modal.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../widgets/searched_item_card.dart';

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
  bool _isSearching = false;
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
    setState(() {
      _isSearching = true;
    });

    Data data = Data();
    await data.fetchData(text);
    dictionaryModel = data.fetchedData;
    streamController!.add(data.fetchedData);
    setState(() {
      _isSearching = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: StreamBuilder(
        stream: stream,
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return const Center(
              child: Text('Enter a word to search'),
            );
          }
          return ModalProgressHUD(
              inAsyncCall: _isSearching,
              child: SearchedItemCard(dictionaryModel: dictionaryModel));
        },
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      centerTitle: true,
      title: const Text(
        'Dictionary',
        style: TextStyle(fontWeight: FontWeight.w700, letterSpacing: 2),
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
                    onFieldSubmitted: (value) =>
                        _search(textEditingController!.text),
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
    );
  }
}
