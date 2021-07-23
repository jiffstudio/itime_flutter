import 'package:flutter/material.dart';
import 'package:itime_frontend/styles/itime_colors.dart';
import 'package:itime_frontend/theme.dart';

// class LineTextField extends StatefulWidget {
//   LineTextField({Key key}) : super(key: key);

//   @override
//   _LineTextFieldState createState() => _LineTextFieldState();
// }

// class _LineTextFieldState extends State<LineTextField> {
//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       decoration: InputDecoration(
//         border: OutlineInputBorder(
//             borderRadius: BorderRadius.all(Radius.circular(16))),
//       ),
//     );
//   }
// }

// ignore: must_be_immutable
// class AreaTextField extends StatefulWidget {
//   final int maxline;
//   AreaTextField({Key key,this.maxline}) : super(key: key);

//   @override
//   _AreaTextFieldState createState() => _AreaTextFieldState();
// }

// class _AreaTextFieldState extends State<AreaTextField> {
//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       maxLines: ,
//       decoration: InputDecoration(
//         border: OutlineInputBorder(
//             borderRadius: BorderRadius.all(Radius.circular(16))),
//       ),
//     );
//   }
// }

// ignore: must_be_immutable
class AreaTextField extends TextField {
  int maxLines;

  AreaTextField({Key? key, required this.maxLines})
      : super(
          key: key,
          maxLines: maxLines,
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(16))),
          ),
        );
}

// ignore: must_be_immutable
class LineTextField extends TextField {
  LineTextField({Key? key})
      : super(
          key: key,
          style: textTheme.bodyText1,
          cursorColor: ItimeColors.vi,
          decoration: InputDecoration(
            filled: true,
            fillColor: ItimeColors.card,
            hoverColor: ItimeColors.vi,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              borderSide: BorderSide(color: ItimeColors.vi),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              borderSide: BorderSide(color: ItimeColors.transparent),
            ),
          ),
        );
}
