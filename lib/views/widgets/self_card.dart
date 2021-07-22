import 'package:flutter/material.dart';
import 'package:itime_frontend/views/widgets/button.dart';
import 'package:itime_frontend/views/widgets/card_content.dart';

// ignore: must_be_immutable
class SelfButtonCard extends Card {
  ContentCard contentCard;
  Widget button;
  SelfButtonCard(
      {Key? key,
      color,
      borderOnForeground = true,
      margin,
      clipBehavior,
      child,
      semanticContainer = true,
      required this.contentCard,
      required this.button})
      : super(
          key: key,
          color: color,
          borderOnForeground: borderOnForeground,
          margin: margin,
          clipBehavior: clipBehavior,
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
            child: Row(
              children: [
                Expanded(child: contentCard),
                SizedBox(
                  width: 5,
                ),
                button,
              ],
            ),
          ),
          semanticContainer: semanticContainer,
          elevation: 0.0,
          shadowColor: null,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusDirectional.circular(20)),
        );
}

// ignore: must_be_immutable
class SelfCard extends Card {
  ContentCard contentCard;
  SelfCard({
    Key? key,
    color,
    borderOnForeground = true,
    margin,
    clipBehavior,
    child,
    semanticContainer = true,
    required this.contentCard,
  }) : super(
          key: key,
          color: color,
          borderOnForeground: borderOnForeground,
          margin: margin,
          clipBehavior: clipBehavior,
          child: Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 15, 0), child: contentCard),
          semanticContainer: semanticContainer,
          elevation: 0.0,
          shadowColor: null,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusDirectional.circular(20)),
        );
}

class ClassBlackCard extends Card {
  final firstText;
  final secondText;
  ClassBlackCard({Key? key, this.firstText, this.secondText})
      : super(
            key: key,
            color: Color.fromARGB(255, 244, 244, 244),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusDirectional.circular(20)),
            child: Container(
              width: 163.5,
              child: Padding(
                padding: EdgeInsets.fromLTRB(15, 15, 0, 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      firstText,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 18,
                        // color: Color.fromARGB(255, 69, 69, 69),c
                        color: Color.fromARGB(255, 69, 69, 69),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      secondText,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        // color: Color.fromARGB(255, 104, 104, 104)),
                        color: Color.fromARGB(255, 104, 104, 104),
                      ),
                    )
                  ],
                ),
              ),
            ));
}


class ClassWhiteCard extends Card {
  final firstText;
  final secondText;
  ClassWhiteCard({Key? key, this.firstText, this.secondText, Color? color})
      : super(
            key: key,
            color: color,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusDirectional.circular(20)),
            child: Container(
              width: 163.5,
              child: Padding(
                padding: EdgeInsets.fromLTRB(15, 15, 0, 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      firstText,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 18,
                        // color: Color.fromARGB(255, 69, 69, 69),c
                        color: Color.fromARGB(255, 244, 244, 244),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      secondText,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        // color: Color.fromARGB(255, 104, 104, 104)),
                        color: Color.fromARGB(255, 244, 244, 244),
                      ),
                    )
                  ],
                ),
              ),
            ));
}




//课程卡片类
// ignore: must_be_immutable
class LessonCard extends SelfCard {
  LessonCard({Key? key, required String firstText, required String secondText})
      : super(
          key: key,
          color: Color.fromARGB(255, 123, 167, 254),
          contentCard: ContentCardWhite(
            firstText: firstText,
            secondText: secondText,
          ),
        );
}

//地点卡片类
// ignore: must_be_immutable
class SiteCard extends SelfCard {
  SiteCard({Key? key, required String firstText, required String secondText})
      : super(
          key: key,
          color: Color.fromARGB(255, 123, 167, 254),
          contentCard: ContentCardBlack(
            firstText: firstText,
            secondText: secondText,
          ),
        );
}

//带按钮的卡片，课程的卡片
// ignore: must_be_immutable
class ButtonCard extends SelfButtonCard {
  ButtonCard({
    Key? key,
    required String firstText,
    required String secondText,
  }) : super(
          key: key,
          color: Color.fromARGB(255, 244, 244, 244),
          contentCard: ContentCardBlack(
            firstText: firstText,
            secondText: secondText,
          ),
          button: PlusClassButton(),
        );
}

// ignore: must_be_immutable
class DropdownCard extends Card {
  ContentCard contentCard;
  DropdownCard(
      {Key? key,
      color,
      borderOnForeground = true,
      margin,
      clipBehavior,
      semanticContainer = true,
      required this.contentCard,
      required String  firstText,
      required String  secondText})
      : super(
          key: key,
          color: color,
          borderOnForeground: borderOnForeground,
          margin: margin,
          clipBehavior: clipBehavior,
          child: Container(
            height: 90,
            child: Stack(
              children: [
                ContentCardBlack(
                  firstText: firstText,
                  secondText: secondText,
                ),
                Positioned(
                  right: 6,
                  bottom: 6,
                  child: ImageButton(
                    image: Image.asset("images/arrow_drop_right_down.png"),
                    onTap: null,
                  ),
                ),
              ],
            ),
          ),
          semanticContainer: semanticContainer,
          elevation: 0.0,
          shadowColor: null,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusDirectional.circular(20)),
        );
}
