import 'package:flutter/material.dart';

import 'news_big_card_widget.dart';

class CustomListWidget extends StatelessWidget {
  const CustomListWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 10,
        addAutomaticKeepAlives: true,
        itemBuilder: (context, index) {
          return NewsBigCardWidget(
            imageUrl: "https://picsum.photos/200/300",
            date: "24.09.2020",
            title:
                "Премьер-Министр РК А.Мамин провел в Шардаре семинар- совещание по развитию",
          );
        });
  }
}
