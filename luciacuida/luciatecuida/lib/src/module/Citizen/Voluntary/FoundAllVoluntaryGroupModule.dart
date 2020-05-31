import 'package:flutter/material.dart';
import 'package:luciatecuida/src/Model/Entity.dart';
import 'package:luciatecuida/src/Model/Generic.dart';
import 'package:luciatecuida/src/Model/PreferenceUser.dart';
import 'package:luciatecuida/src/Theme/ThemeModule.dart';
import 'package:luciatecuida/src/Util/Util.dart';
import 'package:luciatecuida/src/module/Settings/RoutesModule.dart';

class FoundAllVoluntaryGroupModule extends StatefulWidget {
  final ProfesionalesAgrupados profesional;
  static final String routeName = 'EncontrarTodosLosVoluntariosPorGrupo';

  const FoundAllVoluntaryGroupModule({Key key, @required this.profesional})
      : super(key: key);

  @override
  _FoundAllVoluntaryGroupModuleeState createState() =>
      _FoundAllVoluntaryGroupModuleeState();
}

class _FoundAllVoluntaryGroupModuleeState
    extends State<FoundAllVoluntaryGroupModule> {
  final generic = new Generic();
  final prefs = new PreferensUser();

  @override
  void initState() {
    prefs.ultimaPagina = FoundAllVoluntaryGroupModule.routeName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppTheme.themeColorNaranja, size: 12),
        elevation: 0,
        title: Text(
          widget.profesional.profesion,
          style: TextStyle(
              color: AppTheme.themeColorNaranja,
              fontSize: 17,
              fontWeight: FontWeight.w400),
        ),
        //backgroundColor: AppTheme.themeColorNaranja,
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              SizedBox(
                width: 15,
              ),
              ImageOpaqueNetworkCustomize(widget.profesional.imagenFondo,
                  Colors.white, Size(100, 100), 0.8, BoxFit.cover),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: RichText(
                  overflow: TextOverflow.clip,
                  text: TextSpan(
                    text: widget.profesional.descripcion,
                    style: TextStyle(fontSize: 12, color: Colors.black),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Lista de profesionales / voluntarios registradas",
                  style: AppTheme.themeTitulo,
                )),
          ),
          futureCuerpoProfesionales(context),
        ],
      )),
      floatingActionButton: generaFloatbuttonHome(context),
    );
  }

  Widget informacionProfesional(BuildContext context,
      ProfesionalesDeInstitucion profesionalesDeInstitucion) {
    return ListTile(
      leading: imagenProfesional(profesionalesDeInstitucion),
      title: Text(profesionalesDeInstitucion.tipoProfesion),
      subtitle: Column(
        //mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(profesionalesDeInstitucion.nombreProfesional),
          crearIconoProfesional(Icons.bug_report, 'Ayuda con consultas sobre Covid19'),
        ],
      ),
      //trailing:crearIconoProfesional(Icons.mail, 'Correo')

      trailing: Wrap(
        children: <Widget>[
          crearIconoProfesional(Icons.mail, 'Correo'),
          SizedBox(
            width: 15,
          ),
          crearIconoProfesional(Icons.phone, 'Correo'),
        ],
      ),
    );
  }

  Image imagenProfesional(
      ProfesionalesDeInstitucion profesionalesDeInstitucion) {
    Image imagenAvatar;

    if (profesionalesDeInstitucion.sexo == "F") {
      imagenAvatar = Image.asset(
        "assets/image/circled_user_female.png",
        width: 50,
        height: 50,
        fit: BoxFit.fill,
      );
    } else {
      imagenAvatar = Image.asset(
        "assets/image/circled_user_male.png",
        width: 50,
        height: 50,
        fit: BoxFit.fill,
      );
    }
    return imagenAvatar;
  }

  Column crearIconoProfesional(icon, title) {
    return Column(
      children: <Widget>[
        InkWell(
          onTap: () => sendEmailAdvanced(
              'marcoarce23@gmail.com',
              'SOLICITUD CONSULTA MEDICA',
              'Estimado Sr. Marco Arce, solcitud pder contactarme cn su persona.'), //sendSMS(72038768),
          child: Icon(
            icon,
            size: 18,
            color: AppTheme.themeColorAzul,
          ),
        ),
      ],
    );
  }

  Widget futureCuerpoProfesionales(BuildContext context) {
    return FutureBuilder(
        future: generic.getAll(new ProfesionalesDeInstitucion(),
            urlGetTodosGruposProfesionales, primaryKeyTodosGruposProfesionales),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
              break;
            default:
              //mostramos los datos
              return tarjetaPresentacionProfesional(context, snapshot);
          }
        });
  }

  Widget tarjetaPresentacionProfesional(
      BuildContext context, AsyncSnapshot snapshot) {
    return Container(
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: ClampingScrollPhysics(),
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) {
            ProfesionalesDeInstitucion listaProfesionales =
                snapshot.data[index];
            return informacionProfesional(context, listaProfesionales);
          }),
    );
  }
}

class FormaRecorte extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    //path.lineTo(0,size.height-80);
    print(size.width);
    print(size.height);
    path.lineTo(0, size.height);
    path.lineTo((size.width / 2) - 30, size.height);
    path.quadraticBezierTo(size.width - 20, size.height - 20, size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
