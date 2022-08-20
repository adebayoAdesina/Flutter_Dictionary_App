import 'package:cached_network_image/cached_network_image.dart';
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        dictionary.type != null
                            ? dictionary.type as String
                            : '',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: Theme.of(context).appBarTheme.backgroundColor,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Container(
                        padding: const EdgeInsets.all(2.0),
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(20.0)),
                        child: const Icon(
                          Icons.question_answer,
                          color: Colors.black38,
                          size: 13,
                        ),
                      ),
                    ],
                  ),
                  dictionary.imageUrl != null
                      ? GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) => Dialog(
                                      child: CachedNetworkImage(
                                          errorWidget: ((context, url, error) =>
                                              Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  color: Theme.of(context)
                                                      .appBarTheme
                                                      .backgroundColor,
                                                ),
                                              )),
                                          // width: 50,
                                          imageUrl: dictionary.imageUrl!),
                                    ));
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50.0),
                            child: CachedNetworkImage(
                              errorWidget: ((context, url, error) => Center(
                                    child: CircularProgressIndicator(
                                      color: Theme.of(context)
                                          .appBarTheme
                                          .backgroundColor,
                                    ),
                                  )),
                              width: 50,
                              imageUrl: dictionary.imageUrl!,
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
              Text(dictionary.definition != null ? dictionary.definition! : ''),
              const SizedBox(
                height: 10,
              ),
              Text(
                dictionary.example != null ? 'Examples :' : '',
                style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    decoration: TextDecoration.underline),
              ),
              Text(dictionary.example != null ? dictionary.example! : '')
            ],
          ),
        ),
      ],
    );
  }
}
