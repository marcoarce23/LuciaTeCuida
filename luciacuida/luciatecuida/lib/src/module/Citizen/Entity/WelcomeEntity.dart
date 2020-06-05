import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:luciatecuida/src/Model/Generic.dart';
import 'package:luciatecuida/src/Model/PreferenceUser.dart';
import 'package:luciatecuida/src/Theme/ThemeModule.dart';
import 'package:luciatecuida/src/module/Citizen/Voluntary/VoluntaryModule.dart';

class WelcomeEntityModule extends StatelessWidget {
  final estiloTitulo = TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold);
  final estiloSubTitulo = TextStyle(fontSize: 15.0, color: Colors.grey);

  String imagen = 'https://res.cloudinary.com/propia/image/upload/v1590675803/xxxykvu7m2d4nwk4gaf6.jpg';
  var result;

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final generic = new Generic();
  final prefs = new PreferensUser();

  @override
  Widget build(BuildContext context) {
    if (prefs.idPersonal == '-1') {
      return Scaffold(
          body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _crearImagen(context),
            _crearTitulo(),
            _crearTexto(),
            _crearTexto(),
            _crearTexto(),
            _crearTexto(),
            _crearTexto(),
            _crearTexto(),
            _crearAcciones(context),
          ],
        ),
      ));
    } else {
      return Scaffold(
          body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // _crearImagen(context),
            // _crearInformacion(),
            // _crearHorarios(),
            _crearAccionesEdicion(context),
          ],
        ),
      ));
    }
  }

  Widget _crearImagen(BuildContext context) {
    return Container(
      width: double.infinity,
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, 'scroll'),
        child: Image(
          image: NetworkImage(
              'https://images.pexels.com/photos/814499/pexels-photo-814499.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
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
                  Text('REGISTRAR UNA ORGANIZACIÓN ', style: estiloTitulo),
                  SizedBox(height: 7.0),
                  Text(
                    'A continuación, se recomienda  leer cuidadosamente la información para registrar una organziación en la Aplicación móvil',
                    style: estiloSubTitulo,
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

Widget _crearAccionesEdicion(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        InkWell(
            child: FaIcon(
              FontAwesomeIcons.whatsapp,
              color: AppTheme.themeVino,
              size: 25,
            ),
            onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VoluntaryAllModule()),
                )),
        SizedBox(height: 5.0),
        Text(
          'Crear Organización',
          style: TextStyle(fontSize: 15.0, color: Colors.black87),
        ),
        InkWell(
            child: FaIcon(
              FontAwesomeIcons.whatsapp,
              color: AppTheme.themeVino,
              size: 25,
            ),
            onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VoluntaryAllModule()),
                )),
        SizedBox(height: 5.0),
        Text(
          'Asignar Horarios',
          style: TextStyle(fontSize: 15.0, color: Colors.black87),
        )
      ],
    );
  }

  Widget _crearAcciones(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        InkWell(
            child: FaIcon(
              FontAwesomeIcons.whatsapp,
              color: AppTheme.themeVino,
              size: 25,
            ),
            onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VoluntaryAllModule()),
                )),
        SizedBox(height: 5.0),
        Text(
          'Crear Organización',
          style: TextStyle(fontSize: 15.0, color: Colors.black87),
        ),
        InkWell(
            child: FaIcon(
              FontAwesomeIcons.whatsapp,
              color: AppTheme.themeVino,
              size: 25,
            ),
            onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VoluntaryAllModule()),
                )),
        SizedBox(height: 5.0),
        Text(
          'Asignar Horarios',
          style: TextStyle(fontSize: 15.0, color: Colors.black87),
        )
      ],
    );
  }

  Widget _crearTexto() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30.0),
        child: Row(
          children: <Widget>[
            Text(
              'ua laboris dolor. Nisi duis consectetur veniam id nulla deserunt aliqua velit ullamco. ',
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
