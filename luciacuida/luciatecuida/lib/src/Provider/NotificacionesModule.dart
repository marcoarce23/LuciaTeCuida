
import 'package:flutter/material.dart';


class NotificacionesModule extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    final arg = ModalRoute.of(context).settings.arguments;
    print('valro obtenido: $arg');
     
   

     return Scaffold(
      appBar: AppBar(
        title: Text('NOTIFICACIONES - ESTAMOS CONTIGO'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Text('valor optenido $arg'),
          ],
        ),//arg),
      ),
    );
  }
}

    // final snackbar = SnackBar(
      //   content: Text(argumento),
      //   action: SnackBarAction(label: 'Vamos', onPressed: ()=>null,)

      //   );
      // Scaffold.of(context).showSnackBar(snackbar);