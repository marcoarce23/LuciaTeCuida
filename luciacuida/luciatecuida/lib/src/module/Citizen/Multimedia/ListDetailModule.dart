import 'package:flutter/material.dart';

class ListMaterialModule extends StatefulWidget {
  ListMaterialModule({Key key}) : super(key: key);

  @override
  _ListMaterialModuleState createState() => _ListMaterialModuleState();
}

class _ListMaterialModuleState extends State<ListMaterialModule> {
final estiloTitulo    = TextStyle( fontSize: 20.0, fontWeight: FontWeight.bold );
final estiloSubTitulo = TextStyle( fontSize: 18.0, color: Colors.grey );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _crearImagen(context),
            _crearTitulo(),
            _crearAcciones(),
            _crearTexto(),
            _crearTexto(),
            _crearTexto(),
            _crearTexto(),
            _crearTexto(),
            _crearTexto(),
          ],
        ),
      )
    );
  }

  Widget _crearImagen(BuildContext context) {
    return Container(
      width: double.infinity,
      child: GestureDetector(
        onTap: ()=> Navigator.pushNamed(context, 'scroll'),
        child: Image(
          image: NetworkImage('https://images.pexels.com/photos/814499/pexels-photo-814499.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
          height: 180.0,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _crearTitulo() {
    
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
        child: Row(
          children: <Widget>[

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('COLCOAR NOMBRE EVENTO ', style: estiloTitulo ),
                  SizedBox( height: 7.0 ),
                  Text('Fecha: XXXXX', style: estiloSubTitulo ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _crearAcciones() {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[

        _accion( Icons.call, 'LLAMAR' ),
        _accion( Icons.near_me, 'WHATSAPP' ),
        _accion( Icons.share, 'COMPARTIR'),

      ],
    );

  }

  Widget _accion(IconData icon, String texto ) {

    return Column(
      children: <Widget>[
        Icon( icon, color: Colors.black54, size: 40.0 ),
        SizedBox( height: 5.0 ),
        Text( texto, style: TextStyle( fontSize: 15.0, color: Colors.black87), )
      ],
    );

  }

  Widget _crearTexto() {

    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric( horizontal: 30.0 ),
        child: Text(
          'Sit minim aliqua minim laborum duis occaecat consectetur aliquip id ad deserunt. Adipisicing qui reprehenderit eu eu qui occaecat exercitation et aliqua laboris dolor. Nisi duis consectetur veniam id nulla deserunt aliqua velit ullamco. Deserunt exercitation adipisicing nostrud amet eu.',
          textAlign: TextAlign.justify,
        ),
      ),
    );

  }

}