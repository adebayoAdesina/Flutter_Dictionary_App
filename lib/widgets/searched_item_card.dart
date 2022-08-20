import 'package:dictionary/widgets/searched_item.dart';
import 'package:flutter/material.dart';

import '../model/dictionary_modal.dart';

class SearchedItemCard extends StatelessWidget {
  const SearchedItemCard({
    Key? key,
    required this.dictionaryModel,
  }) : super(key: key);

  final DictionaryModel? dictionaryModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 2),
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 10,
                  )
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(dictionaryModel!.word!),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      '/${dictionaryModel!.pronunciation!}/',
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: dictionaryModel!.definitions!.length,
                itemBuilder: (context, index) {
                  final dictionary = dictionaryModel!.definitions![index];
                  return SearchedItem(dictionary: dictionary);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
