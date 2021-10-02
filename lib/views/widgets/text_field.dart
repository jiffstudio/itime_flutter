import 'package:flutter/material.dart';
import 'package:itime_frontend/styles/itime_colors.dart';
import 'package:itime_frontend/theme.dart';


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
class ItimeTextField extends TextField {
  ItimeTextField({Key? key, bool? autofocus, TextEditingController? controller})
      : super(
          key: key,
          controller: controller,
          style: textTheme.bodyText1,
          cursorColor: ItimeColors.vi,
          autofocus: autofocus ?? true,
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
