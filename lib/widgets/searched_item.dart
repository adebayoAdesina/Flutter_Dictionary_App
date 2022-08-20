import 'package:flutter/material.dart';

import '../model/definitions_model.dart';

class SearchedItem extends StatelessWidget {
  const SearchedItem({
    Key? key,
    required this.dictionary,
  }) : super(key: key);

  final DefinitionsModel dictionary;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(
                thickness: 2.0,
              ),
              Row(
                children: [
                  Text(
                    dictionary.type as String,
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: Theme.of(context)
                          .appBarTheme
                          .backgroundColor,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Container(
                    padding: const EdgeInsets.all(2.0),
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius:
                            BorderRadius.circular(20.0)),
                    child: const Icon(
                      Icons.question_answer,
                      color: Colors.black38,
                      size: 13,
                    ),
                  )
                ],
              ),
              Text(dictionary.definition as String),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Examples :',
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    decoration: TextDecoration.underline),
              ),
              Text(dictionary.example!)
            ],
          ),
        ),
      ],
    );
  }
}
