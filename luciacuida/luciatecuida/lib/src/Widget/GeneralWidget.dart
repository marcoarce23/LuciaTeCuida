import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:luciatecuida/src/Theme/ThemeModule.dart';

Widget copyRigth() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      SizedBox(height: 5.0),
     divider(),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('EstamosContigo@2020. ', style: kTitleCursive4Style),
          FaIcon(
            FontAwesomeIcons.fistRaised,
            color: AppTheme.themeVino,
            size: 18,
          ),
        ],
      ),
    ],
  );
}
