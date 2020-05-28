import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

SnackBar messageOk(String mensaje) {
  return SnackBar(
    backgroundColor: Colors.green,
    content: Row(
      children: <Widget>[
        FaIcon(FontAwesomeIcons.check, color: Colors.white),
        SizedBox(
          width: 20,
        ),
        Text("Exito!", style: TextStyle(fontWeight: FontWeight.w800),),
         SizedBox(
          width: 20,
        ),
        Expanded(
          child: Text(mensaje),
        )
      ],
    ),
  );
}


SnackBar messageNOk(String mensaje) {
  return SnackBar(
    backgroundColor: Colors.red,
    content: Row(
      children: <Widget>[
        FaIcon(FontAwesomeIcons.exclamationCircle, color: Colors.white),
        SizedBox(
          width: 20,
        ),
        Text("Error!", style: TextStyle(fontWeight: FontWeight.w800),),
         SizedBox(
          width: 20,
        ),
        Expanded(
          child: Text(mensaje),
        )
      ],
    ),
  );
}

SnackBar messageWarning(String mensaje) {
  return SnackBar(
    backgroundColor: Colors.yellow,
    content: Row(
      children: <Widget>[
        FaIcon(FontAwesomeIcons.exclamationCircle, color: Colors.black),
        SizedBox(
          width: 20,
        ),
        Text("Advertencia!", style: TextStyle(fontWeight: FontWeight.w800, color: Colors.black),  ),
         SizedBox(
          width: 20,
        ),
        Expanded(
          child: Text(mensaje,style:TextStyle( color: Colors.black)),
        )
      ],
    ),
  );
}


SnackBar messageHelp(String mensaje) {
  return SnackBar(
    backgroundColor: Colors.blue,
    content: Row(
      children: <Widget>[
        FaIcon(FontAwesomeIcons.infoCircle, color: Colors.white),
        SizedBox(
          width: 20,
        ),
        Text("Ayuda!", style: TextStyle(fontWeight: FontWeight.w800, color: Colors.white),  ),
         SizedBox(
          width: 20,
        ),
        Expanded(
          child: Text(mensaje,style:TextStyle( color: Colors.white)),
        )
      ],
    ),
  );
}
