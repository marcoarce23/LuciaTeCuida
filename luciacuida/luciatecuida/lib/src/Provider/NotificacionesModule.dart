
import 'package:flutter/material.dart';


class NotificacionesModule extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

  //  final arg = ModalRoute.of(context).settings.arguments;


    return Scaffold(
      appBar: AppBar(
        title: Text('NOTIFICACIONES'),
      ),
      body: Center(
        child: Text('Notificaicones'),//arg),
      ),
    );
  }
}