import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:luciatecuida/src/Model/Entity.dart';
import 'package:luciatecuida/src/Model/Generic.dart';
import 'package:luciatecuida/src/Model/PreferenceUser.dart';
import 'package:luciatecuida/src/Theme/ThemeModule.dart';
import 'package:luciatecuida/src/Util/Util.dart';
import 'package:luciatecuida/src/Widget/GeneralWidget.dart';
import 'package:luciatecuida/src/module/HomePage/HomePageModule.dart';
import 'package:luciatecuida/src/module/Settings/RoutesModule.dart';

class FoundAllVoluntaryModule extends StatefulWidget {
  final ProfesionalesAgrupados profesional;
final int departamento;

  static final String routeName = 'EncontrarTodosLosVoluntarios';

  const FoundAllVoluntaryModule({Key key, @required this.profesional, @required this.departamento  })
      : super(key: key);

  @override
  _FoundAllVoluntaryModuleState createState() =>
      _FoundAllVoluntaryModuleState();
}

class _FoundAllVoluntaryModuleState extends State<FoundAllVoluntaryModule> {
  final generic = new Generic();
  final prefs = new PreferensUser();

  @override
  void initState() {
    prefs.ultimaPagina = FoundAllVoluntaryModule.routeName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarOpacity: 0.7,
        iconTheme: IconThemeData(color: AppTheme.themeVino, size: 12),
        elevation: 0,
        title: Text(widget.profesional.profesion.toUpperCase(),
            style: kTitleAppBar), //backgroundColor: AppTheme.themeColorNaranja,
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
              ImageOvalNetwork(
                  imageNetworkUrl: widget.profesional.imagenFondo,
                  sizeImage: Size.fromWidth(80)),
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
              child: contenedorTitulo(
                context,
                40.0,
                "Profesionales / Voluntarios".toUpperCase(),
                FaIcon(FontAwesomeIcons.peopleCarry, color: AppTheme.themeVino),
              ),
            ),
          ),
          futureCuerpoProfesionales(context),
          copyRigth(),
        ],
      )),
      drawer: DrawerCitizen(),
      floatingActionButton: generaFloatbuttonHome(context),
    );
  }

  Widget informacionProfesional(BuildContext context,
      ProfesionalesDeInstitucion profesionalesDeInstitucion) {
    String parametroCovid = profesionalesDeInstitucion.ayudaConCovid;
    return Column(
      children: <Widget>[
        Container(
          decoration: boxDecorationList(),
          margin: EdgeInsets.only(top: 5, left: 10, right: 10),
          child: ListTile(
            leading: ImageOvalNetwork(
                imageNetworkUrl: profesionalesDeInstitucion.foto,
                sizeImage: Size.fromWidth(60)),

            subtitle: Column(
              //mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.person,
                      color: AppTheme.themeVino,
                      size: 15,
                    ),
                    Text(
                      "Profesional / Voluntario",
                      style: kTitleCardStyle,
                    ),
                  ],
                ),
                Text(
                  profesionalesDeInstitucion.nombreProfesional,
                  style: kSubTitleCardStyle,
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.business,
                      color: AppTheme.themeVino,
                      size: 15,
                    ),
                    Text(
                      "Institución",
                      style: kTitleCardStyle,
                    ),
                  ],
                ),
                Text(
                  profesionalesDeInstitucion.nombreInstitucion,
                  style: kSubTitleCardStyle,
                  softWrap: true,
                  overflow: TextOverflow.clip,
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.category,
                      color: AppTheme.themeVino,
                      size: 15,
                    ),
                    Text(
                      "Especialidad",
                      style: kTitleCardStyle,
                    ),
                  ],
                ),
                Text(
                  profesionalesDeInstitucion.tipoProfesion.toUpperCase(),
                  style: kSubTitleCardStyle,
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.timer,
                      color: AppTheme.themeVino,
                      size: 15,
                    ),
                    Text(
                      "Horarios",
                      style: kTitleCardStyle,
                    ),
                  ],
                ),
                Text(
                  profesionalesDeInstitucion.horario,
                  style: kSubTitleCardStyle,
                ),
                Opacity(
                  opacity: (parametroCovid == "0") ? 0 : 1,
                  child: Row(
                    children: <Widget>[
                      Image.asset(
                        "assets/image/COVID-19.png",
                        width: 20,
                        height: 20,
                        fit: BoxFit.fill,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Consultas sobre Covid",
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                ),
                Wrap(
                  children: <Widget>[
                    InkWell(
                      child: FaIcon(
                        FontAwesomeIcons.phoneVolume,
                        color: AppTheme.themeVino,
                        size: 25,
                      ),
                      onTap: () {
                        callNumber(
                            int.parse(profesionalesDeInstitucion.telefono));
                      },
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    InkWell(
                      child: FaIcon(
                        FontAwesomeIcons.comment,
                        color: AppTheme.themeVino,
                        size: 25,
                      ),
                      onTap: () {
                        sendSMS(int.parse(profesionalesDeInstitucion.telefono));
                      },
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    InkWell(
                      child: FaIcon(
                        FontAwesomeIcons.mailBulk,
                        color: AppTheme.themeVino,
                        size: 25,
                      ),
                      onTap: () {
                        sendEmailAdvanced(
                            profesionalesDeInstitucion.correo,
                            "Colaboración ${profesionalesDeInstitucion.tipoProfesion}",
                            "Estimad@:  ${profesionalesDeInstitucion.nombreProfesional}, favor su colaboración en: ");
                      },
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    InkWell(
                      child: FaIcon(
                        FontAwesomeIcons.whatsapp,
                        color: AppTheme.themeVino,
                        size: 25,
                      ),
                      onTap: () {
                        callWhatsAppText(
                            int.parse(profesionalesDeInstitucion.telefono),
                            'Estimado soy ${prefs.correoElectronico}, deseo consultarle o ponerme en contacto con ud. \nEnviado desde la aplicación *SomosUnoBolivia*.'
                            );
                      },
                    )
                  ],
                ),
              ],
            ),
            //trailing:crearIconoProfesional(Icons.mail, 'Correo')
          ),
        ),
      ],
    );
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
        future: generic.getAll(
            new ProfesionalesDeInstitucion(),
            urlGetListaProfesionalesInstitucion +
                '/' +
                widget.profesional.idInstitucion.toString() +
                '/' +
                widget.profesional.idProfesion.toString()+
                '/' +
                widget.departamento.toString()
                ,
            primaryKeyListaProfesionalesInstitucion),
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
    //print(size.width);
    //print(size.height);
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
