import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ContentCard extends StatelessWidget {
  String firstText;
  String secondText;
  Color firstColor;
  Color secondColor;

  ContentCard({
    Key ?key,
    required this.firstText,
    required this.secondText,
    required this.firstColor,
    required this.secondColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.fromLTRB(15, 15, 0, 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${this.firstText}',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 18,
                // color: Color.fromARGB(255, 69, 69, 69),c
                color: firstColor,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 5,),
            Text(
              '${this.secondText}',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12,
                // color: Color.fromARGB(255, 104, 104, 104)),
                color: secondColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}

//文字黑色内容类
// ignore: must_be_immutable
class ContentCardBlack extends ContentCard {
  ContentCardBlack({Key? key,required String firstText,required String secondText,})
      : super(
          key: key,
          firstText: firstText,
          secondText: secondText,
          firstColor: Color.fromARGB(255, 69, 69, 69),
          secondColor: Color.fromARGB(255, 104, 104, 104),
        );
}

//文字白色内容类
// ignore: must_be_immutable
class ContentCardWhite extends ContentCard {
  ContentCardWhite({Key ?key,required String firstText,required String secondText,})
      : super(
          key: key,
          firstText: firstText,
          secondText: secondText,
          firstColor: Color.fromARGB(255, 255, 255, 255),
          secondColor: Color.fromARGB(255, 255, 255, 255),
        );
}