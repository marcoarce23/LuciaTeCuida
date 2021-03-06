import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:luciatecuida/src/Model/Entity.dart';
import 'package:luciatecuida/src/Model/Generic.dart';
import 'package:luciatecuida/src/Model/PreferenceUser.dart';
import 'package:luciatecuida/src/Theme/ThemeModule.dart';
import 'package:luciatecuida/src/Util/Util.dart';
import 'package:luciatecuida/src/Widget/Message/Message.dart';
import 'package:luciatecuida/src/module/Citizen/CitizenEmergency/CitizenAlertEmergency.dart';
import 'package:luciatecuida/src/module/HomePage/HomePageModule.dart';
import 'package:luciatecuida/src/module/Settings/RoutesModule.dart';

class CitizenEmergencyModule extends StatefulWidget {
  static final String routeName = 'CiudadanoEmergencia';

  @override
  _CitizenEmergencyModuleState createState() => _CitizenEmergencyModuleState();
}

class _CitizenEmergencyModuleState extends State<CitizenEmergencyModule> {
  final prefs = new PreferensUser();
  int page = 0;
  final List<Widget> optionPage = [
    PageCovid(),
    PagePlasma(),
    PageOxigeno(),
    PageAyudaAmigo(),
    PageMedicina(),
    PageMedicmanetos(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      page = index;
    });
  }

  @override
  void initState() {
    prefs.ultimaPagina = CitizenEmergencyModule.routeName;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              toolbarOpacity: 0.7,
              iconTheme: IconThemeData(color: AppTheme.themeVino, size: 12),
              elevation: 0,
              title: Text("Solicitudes de ayuda".toUpperCase(),
                  style: kTitleAppBar),
              //backgroundColor: colorCuadro,
            ), //backgroundColor: colorCuadro,

            drawer: DrawerCitizen(),
            floatingActionButton: generaFloatbuttonHome(context),
            body: optionPage[page],
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: AppTheme.themeVino,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.ac_unit, size: 24),
                  title: Text('Covid', style: TextStyle(fontSize: 12)),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.book, size: 24),
                  title: Text('Plasma', style: TextStyle(fontSize: 12)),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.camera_roll, size: 24),
                  title: Text('Oxigeno', style: TextStyle(fontSize: 12)),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.face, size: 24),
                  title: Text('Ayuda Amigo', style: TextStyle(fontSize: 12)),
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person_add,
                    size: 24,
                  ),
                  title: Text(
                    'Consulta médica',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.library_add, size: 24),
                  title: Text('Lab.-Medicamen', style: TextStyle(fontSize: 12)),
                ),
              ],
              currentIndex: page,
              unselectedItemColor: Colors.black87,
              selectedItemColor: AppTheme.themeVino,
              onTap: _onItemTapped,
            )));
  }
}

class PageMedicina extends StatefulWidget {
  @override
  _PageMedicinaState createState() => _PageMedicinaState();
}

class _PageMedicinaState extends State<PageMedicina> {
  final generic = new Generic();
  final prefs = new PreferensUser();
  String _notificacion = '';

  RegistrarAyuda registrarAyuda = new RegistrarAyuda();

  @override
  Widget build(BuildContext context) {
    final _valor = ModalRoute.of(context).settings.arguments;
    if (_valor != null) _notificacion = _valor;

    return SingleChildScrollView(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              contenedorTitulo(
                context,
                40.0,
                "Medicina".toUpperCase(),
                FaIcon(FontAwesomeIcons.photoVideo, color: AppTheme.themeVino),
              ),
              AutoSizeText(
                'Estamos en el Departamento de : ${obtenerDepartamento(prefs.idDepartamento)} ',
                style: kSubTitleCardStyle,
                maxLines: 2,
                minFontSize: 15.0,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.justify,
              ),
              Opacity(
                  opacity: _notificacion.length > 1 ? 1.0 : 0.0,
                  child: Text('Atención: Ayuda urgente activada.')),
              Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          FlatButton(
                            color: AppTheme.themeVino,
                            textColor: Colors.white,
                            disabledColor: Colors.grey,
                            disabledTextColor: Colors.black,
                            splashColor: Colors.white,
                            onPressed: () {
                              openWeb('http://mapacovid19.ruta88.net/');
                            },
                            child: Text("Mapa de solicitudes"),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          FlatButton(
                            color: AppTheme.themeVino,
                            textColor: Colors.white,
                            disabledColor: Colors.grey,
                            disabledTextColor: Colors.black,
                            splashColor: Colors.greenAccent,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CitizenAlertEmergency(
                                        "-1", prefs.idPersonal)),
                              );
                            },
                            child: Text("Mis atenciones"),
                          ),
                        ],
                      ))),
              futureMedicamentoss(context),
            ],
          ),
        ),
      ),
    );
    //backgroundColor: colorCuadro,
  }

  Widget futureMedicamentoss(BuildContext context) {
    return FutureBuilder(
        future: Generic().getAll(
            new SolicitudAyuda(),
            urlGetListaSolicitudesAyudas +
                '/64' +
                '/' +
                prefs.idDepartamento.toString(),
            primaryKeyListaSolicitudesAyudas),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
              break;
            default:
              //mostramos los datos
              return buildItemSolcitud(context, snapshot);
          }
        });
  }

  Widget buildItemSolcitud(BuildContext context, AsyncSnapshot snapshot) {
    return Container(
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: ClampingScrollPhysics(),
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) {
            SolicitudAyuda item = snapshot.data[index];
            return itemSolicitud(context, item);
          }),
    );
  }

  Widget itemSolicitud(BuildContext context, SolicitudAyuda solicitudAyuda) {
    DateTime tempDate =
        new DateFormat("dd/MM/yyyy").parse(solicitudAyuda.fecha);

    Color colorCuadro;
    String detallePrioridad;
    if (solicitudAyuda.idaPrioridad == 68) {
      colorCuadro = AppTheme.themeColorRojo;
      detallePrioridad = "Muy alta";
    } else if (solicitudAyuda.idaPrioridad == 69) {
      colorCuadro = AppTheme.themeColorNaranja;
      detallePrioridad = "Alta";
    } else {
      colorCuadro = AppTheme.themeAmarillo;
      detallePrioridad = "Media";
    }

    return contenidoAtencionSolicitudes(
        colorCuadro, detallePrioridad, tempDate, solicitudAyuda, context);
  }

  Widget contenidoAtencionSolicitudes(
      Color colorCuadro,
      String detallePrioridad,
      DateTime tempDate,
      SolicitudAyuda solicitudAyuda,
      BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Column(
        children: <Widget>[
          Container(
            decoration: new BoxDecoration(boxShadow: [
              new BoxShadow(
                color: Colors.black12,
                blurRadius: 30.0,
              ),
            ]),
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Column(
                      children: <Widget>[
                        FaIcon(
                          FontAwesomeIcons.eye,
                          color: colorCuadro,
                          size: 30,
                        ),
                        Text(
                          detallePrioridad,
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              new DateFormat("dd/MM/yyyy").format(tempDate),
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              solicitudAyuda.hora,
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Detalle:",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                        RichText(
                          overflow: TextOverflow.clip,
                          text: TextSpan(
                            text: solicitudAyuda.detalle,
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            InkWell(
                              child: FaIcon(
                                FontAwesomeIcons.phoneVolume,
                                size: 25,
                                color: AppTheme.themeVino,
                              ),
                              onTap: () {
                                callNumber(solicitudAyuda.telefono);
                              },
                            ),
                            SizedBox(
                              width: 25,
                            ),
                            InkWell(
                              child: FaIcon(
                                FontAwesomeIcons.comment,
                                size: 25,
                                color: AppTheme.themeVino,
                              ),
                              onTap: () {
                                sendSMS(solicitudAyuda.telefono);
                              },
                            ),
                            SizedBox(
                              width: 25,
                            ),
                            InkWell(
                              child: FaIcon(
                                FontAwesomeIcons.whatsapp,
                                size: 25,
                                color: AppTheme.themeVino,
                              ),
                              onTap: () {
                                callWhatsAppText(solicitudAyuda.telefono,
                                    'Estimado soy ${prefs.correoElectronico}, deseo consultarle o ponerme en contacto con ud. \nEnviado desde la aplicación *SomosUnoBolivia*.');
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                    trailing: InkWell(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          FaIcon(
                            FontAwesomeIcons.checkCircle,
                            color: AppTheme.themeColorVerde,
                            size: 25,
                          ),
                          Text(
                            "Atender",
                          )
                        ],
                      ),
                      onTap: () {
                        _submitMedicamentosAtender(context, solicitudAyuda);
                      },
                    ),
                  ),
                  ButtonBar(
                    alignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[],
                  ),
                ],
              ),
            ),
          ),
          //contenidoCabecera(context, tempDate, solicitudAyuda),
          //contenidoFinal(context, solicitudAyuda),
        ],
      ),
    );
  }

  _submitMedicamentosAtender(
      BuildContext context, SolicitudAyuda solicitudAyuda) async {
    registrarAyuda.idaBotonPanico = solicitudAyuda.idaBotonPanico;
    registrarAyuda.idaPersonal = int.parse(prefs.idPersonal);
    registrarAyuda.fecha =
        DateFormat("dd/MM/yyyy HH:mm").format(DateTime.now());
    registrarAyuda.idaEstado = 78; // en cursoF
    registrarAyuda.usuario = prefs.correoElectronico;

    final dataMap = generic.add(registrarAyuda, urlAddSolicitudAyud);
    var result;
    await dataMap.then((respuesta) => result = respuesta["TIPO_RESPUESTA"]);
    if (result == "0") {
      setState(() {
        Scaffold.of(context)
            .showSnackBar(messageOk("Se puso en atención su solicitud"));
      });
    } else {
      Scaffold.of(context)
          .showSnackBar(messageNOk("Ocurrio un error inseperado"));
    }

    //print('resultado:$result');
  }
}

class PageCovid extends StatefulWidget {
  @override
  _PageCovidState createState() => _PageCovidState();
}

class _PageCovidState extends State<PageCovid> {
  final generic = new Generic();
  final prefs = new PreferensUser();
  String _notificacion = '';
  RegistrarAyuda registrarAyuda = new RegistrarAyuda();

  @override
  Widget build(BuildContext context) {
    final _valor = ModalRoute.of(context).settings.arguments;
    if (_valor != null) _notificacion = _valor;

    return SingleChildScrollView(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              contenedorTitulo(
                context,
                40.0,
                "Consulta Covid".toUpperCase(),
                FaIcon(FontAwesomeIcons.photoVideo, color: AppTheme.themeVino),
              ),
              AutoSizeText(
                'Estamos en el Departamento de : ${obtenerDepartamento(prefs.idDepartamento)} ',
                style: kSubTitleCardStyle,
                maxLines: 2,
                minFontSize: 15.0,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.justify,
              ),
              Opacity(
                  opacity: _notificacion.length > 1 ? 1.0 : 0.0,
                  child: Text('Atención: Ayuda urgente activada.')),
              Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          FlatButton(
                            color: AppTheme.themeVino,
                            textColor: Colors.white,
                            disabledColor: Colors.grey,
                            disabledTextColor: Colors.black,
                            splashColor: Colors.white,
                            onPressed: () {
                              openWeb('http://mapacovid19.ruta88.net/');
                            },
                            child: Text("Mapa de solicitudes"),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          FlatButton(
                            color: AppTheme.themeVino,
                            textColor: Colors.white,
                            disabledColor: Colors.grey,
                            disabledTextColor: Colors.black,
                            splashColor: Colors.greenAccent,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CitizenAlertEmergency(
                                        "-1", prefs.idPersonal)),
                              );
                            },
                            child: Text("Mis atenciones"),
                          ),
                        ],
                      ))),
              futureCovid(context),
            ],
          ),
        ),
      ),
    );
    //backgroundColor: colorCuadro,
  }

  Widget futureCovid(BuildContext context) {
    return FutureBuilder(
        future: Generic().getAll(
            new SolicitudAyuda(),
            urlGetListaSolicitudesAyudas +
                '/65' +
                '/' +
                prefs.idDepartamento.toString(),
            primaryKeyListaSolicitudesAyudas),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
              break;
            default:
              //mostramos los datos
              return buildItemSolcitud(context, snapshot);
          }
        });
  }

  Widget buildItemSolcitud(BuildContext context, AsyncSnapshot snapshot) {
    return Container(
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: ClampingScrollPhysics(),
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) {
            SolicitudAyuda item = snapshot.data[index];
            return itemSolicitud(context, item);
          }),
    );
  }

  Widget itemSolicitud(BuildContext context, SolicitudAyuda solicitudAyuda) {
    DateTime tempDate =
        new DateFormat("dd/MM/yyyy").parse(solicitudAyuda.fecha);
    Color colorCuadro;
    String detallePrioridad;
    if (solicitudAyuda.idaPrioridad == 68) {
      colorCuadro = AppTheme.themeColorRojo;
      detallePrioridad = "Muy alta";
    } else if (solicitudAyuda.idaPrioridad == 69) {
      colorCuadro = AppTheme.themeColorNaranja;
      detallePrioridad = "Alta";
    } else {
      colorCuadro = AppTheme.themeAmarillo;
      detallePrioridad = "Media";
    }
    return contenidoAtencionSolicitudes(
        colorCuadro, detallePrioridad, tempDate, solicitudAyuda, context);
  }

  // _submitCovidConcluido(
  //     BuildContext context, SolicitudAyuda solicitudAyuda) async {
  //   registrarAyuda.idaBotonPanico = solicitudAyuda.idaBotonPanico;
  //   registrarAyuda.idaPersonal = int.parse(prefs.idPersonal);
  //   registrarAyuda.fecha =
  //       DateFormat("dd/MM/yyyy HH:mm").format(DateTime.now());
  //   registrarAyuda.idaEstado = 79; // en concluido
  //   registrarAyuda.usuario = prefs.correoElectronico;

  //   final dataMap = generic.add(registrarAyuda, urlAddSolicitudAyud);
  //   var result;
  //   await dataMap.then((respuesta) => result = respuesta["TIPO_RESPUESTA"]);
  //   if (result == "0") {
  //     setState(() {
  //       Scaffold.of(context)
  //           .showSnackBar(messageOk("Se concluyo la solicitud"));
  //     });
  //   } else {
  //     Scaffold.of(context)
  //         .showSnackBar(messageNOk("Ocurrio un error inseperado"));
  //   }

  //   //print('resultado:$result');
  // }

  _submitCovidAtender(
      BuildContext context, SolicitudAyuda solicitudAyuda) async {
    registrarAyuda.idaBotonPanico = solicitudAyuda.idaBotonPanico;
    registrarAyuda.idaPersonal = int.parse(prefs.idPersonal);
    registrarAyuda.fecha =
        DateFormat("dd/MM/yyyy HH:mm").format(DateTime.now());
    registrarAyuda.idaEstado = 78; // en cursoF
    registrarAyuda.usuario = prefs.correoElectronico;

    final dataMap = generic.add(registrarAyuda, urlAddSolicitudAyud);
    var result;
    await dataMap.then((respuesta) => result = respuesta["TIPO_RESPUESTA"]);
    if (result == "0") {
      setState(() {
        Scaffold.of(context)
            .showSnackBar(messageOk("Se puso en atención su solicitud"));
      });
    } else {
      Scaffold.of(context)
          .showSnackBar(messageNOk("Ocurrio un error inseperado"));
    }

    //print('resultado:$result');
  }

  Widget contenidoAtencionSolicitudes(
      Color colorCuadro,
      String detallePrioridad,
      DateTime tempDate,
      SolicitudAyuda solicitudAyuda,
      BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Column(
        children: <Widget>[
          Container(
            decoration: new BoxDecoration(boxShadow: [
              new BoxShadow(
                color: Colors.black12,
                blurRadius: 30.0,
              ),
            ]),
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Column(
                      children: <Widget>[
                        FaIcon(
                          FontAwesomeIcons.eye,
                          color: colorCuadro,
                          size: 30,
                        ),
                        Text(
                          detallePrioridad,
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              new DateFormat("dd/MM/yyyy").format(tempDate),
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              solicitudAyuda.hora,
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Detalle:",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                        RichText(
                          overflow: TextOverflow.clip,
                          text: TextSpan(
                            text: solicitudAyuda.detalle,
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            InkWell(
                              child: FaIcon(
                                FontAwesomeIcons.phoneVolume,
                                size: 25,
                                color: AppTheme.themeVino,
                              ),
                              onTap: () {
                                callNumber(solicitudAyuda.telefono);
                              },
                            ),
                            SizedBox(
                              width: 25,
                            ),
                            InkWell(
                              child: FaIcon(
                                FontAwesomeIcons.comment,
                                size: 25,
                                color: AppTheme.themeVino,
                              ),
                              onTap: () {
                                sendSMS(solicitudAyuda.telefono);
                              },
                            ),
                            SizedBox(
                              width: 25,
                            ),
                            InkWell(
                              child: FaIcon(
                                FontAwesomeIcons.whatsapp,
                                size: 25,
                                color: AppTheme.themeVino,
                              ),
                              onTap: () {
                                callWhatsAppText(solicitudAyuda.telefono,
                                    'Estimado soy ${prefs.correoElectronico}, deseo consultarle o ponerme en contacto con ud. \nEnviado desde la aplicación *SomosUnoBolivia*.');
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                    trailing: InkWell(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          FaIcon(
                            FontAwesomeIcons.checkCircle,
                            color: AppTheme.themeColorVerde,
                            size: 25,
                          ),
                          Text(
                            "Atender",
                          )
                        ],
                      ),
                      onTap: () {
                        _submitCovidAtender(context, solicitudAyuda);
                      },
                    ),
                  ),
                  ButtonBar(
                    alignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[],
                  ),
                ],
              ),
            ),
          ),
          //contenidoCabecera(context, tempDate, solicitudAyuda),
          //contenidoFinal(context, solicitudAyuda),
        ],
      ),
    );
  }
}

class PagePlasma extends StatefulWidget {
  @override
  _PagePlasmaState createState() => _PagePlasmaState();
}

class _PagePlasmaState extends State<PagePlasma> {
  final generic = new Generic();
  final prefs = new PreferensUser();
  String _notificacion = '';
  RegistrarAyuda registrarAyuda = new RegistrarAyuda();

  @override
  Widget build(BuildContext context) {
    final _valor = ModalRoute.of(context).settings.arguments;
    if (_valor != null) _notificacion = _valor;

    return SingleChildScrollView(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              contenedorTitulo(
                context,
                40.0,
                "Solicitud Plasma".toUpperCase(),
                FaIcon(FontAwesomeIcons.photoVideo, color: AppTheme.themeVino),
              ),
              AutoSizeText(
                'Estamos en el Departamento de : ${obtenerDepartamento(prefs.idDepartamento)} ',
                style: kSubTitleCardStyle,
                maxLines: 2,
                minFontSize: 15.0,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.justify,
              ),
              Opacity(
                  opacity: _notificacion.length > 1 ? 1.0 : 0.0,
                  child: Text('Atención: Ayuda urgente activada.')),
              Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          FlatButton(
                            color: AppTheme.themeVino,
                            textColor: Colors.white,
                            disabledColor: Colors.grey,
                            disabledTextColor: Colors.black,
                            splashColor: Colors.white,
                            onPressed: () {
                              openWeb('http://mapacovid19.ruta88.net/');
                            },
                            child: Text("Mapa de solicitudes"),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          FlatButton(
                            color: AppTheme.themeVino,
                            textColor: Colors.white,
                            disabledColor: Colors.grey,
                            disabledTextColor: Colors.black,
                            splashColor: Colors.greenAccent,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CitizenAlertEmergency(
                                        "-1", prefs.idPersonal)),
                              );
                            },
                            child: Text("Mis atenciones"),
                          ),
                        ],
                      ))),
              futureCovid(context),
            ],
          ),
        ),
      ),
    );
    //backgroundColor: colorCuadro,
  }

  Widget futureCovid(BuildContext context) {
    return FutureBuilder(
        future: Generic().getAll(
            new SolicitudAyuda(),
            urlGetListaSolicitudesAyudas +
                '/102' +
                '/' +
                prefs.idDepartamento.toString(),
            primaryKeyListaSolicitudesAyudas),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
              break;
            default:
              //mostramos los datos
              return buildItemSolcitud(context, snapshot);
          }
        });
  }

  Widget buildItemSolcitud(BuildContext context, AsyncSnapshot snapshot) {
    return Container(
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: ClampingScrollPhysics(),
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) {
            SolicitudAyuda item = snapshot.data[index];
            return itemSolicitud(context, item);
          }),
    );
  }

  Widget itemSolicitud(BuildContext context, SolicitudAyuda solicitudAyuda) {
    DateTime tempDate =
        new DateFormat("dd/MM/yyyy").parse(solicitudAyuda.fecha);
    Color colorCuadro;
    String detallePrioridad;
    if (solicitudAyuda.idaPrioridad == 68) {
      colorCuadro = AppTheme.themeColorRojo;
      detallePrioridad = "Muy alta";
    } else if (solicitudAyuda.idaPrioridad == 69) {
      colorCuadro = AppTheme.themeColorNaranja;
      detallePrioridad = "Alta";
    } else {
      colorCuadro = AppTheme.themeAmarillo;
      detallePrioridad = "Media";
    }
    return contenidoAtencionSolicitudes(
        colorCuadro, detallePrioridad, tempDate, solicitudAyuda, context);
  }

  // _submitCovidConcluido(
  //     BuildContext context, SolicitudAyuda solicitudAyuda) async {
  //   registrarAyuda.idaBotonPanico = solicitudAyuda.idaBotonPanico;
  //   registrarAyuda.idaPersonal = int.parse(prefs.idPersonal);
  //   registrarAyuda.fecha =
  //       DateFormat("dd/MM/yyyy HH:mm").format(DateTime.now());
  //   registrarAyuda.idaEstado = 79; // en concluido
  //   registrarAyuda.usuario = prefs.correoElectronico;

  //   final dataMap = generic.add(registrarAyuda, urlAddSolicitudAyud);
  //   var result;
  //   await dataMap.then((respuesta) => result = respuesta["TIPO_RESPUESTA"]);
  //   if (result == "0") {
  //     setState(() {
  //       Scaffold.of(context)
  //           .showSnackBar(messageOk("Se concluyo la solicitud"));
  //     });
  //   } else {
  //     Scaffold.of(context)
  //         .showSnackBar(messageNOk("Ocurrio un error inseperado"));
  //   }

  //   //print('resultado:$result');
  // }

  _submitCovidAtender(
      BuildContext context, SolicitudAyuda solicitudAyuda) async {
    registrarAyuda.idaBotonPanico = solicitudAyuda.idaBotonPanico;
    registrarAyuda.idaPersonal = int.parse(prefs.idPersonal);
    registrarAyuda.fecha =
        DateFormat("dd/MM/yyyy HH:mm").format(DateTime.now());
    registrarAyuda.idaEstado = 78; // en cursoF
    registrarAyuda.usuario = prefs.correoElectronico;

    final dataMap = generic.add(registrarAyuda, urlAddSolicitudAyud);
    var result;
    await dataMap.then((respuesta) => result = respuesta["TIPO_RESPUESTA"]);
    if (result == "0") {
      setState(() {
        Scaffold.of(context)
            .showSnackBar(messageOk("Se puso en atención su solicitud"));
      });
    } else {
      Scaffold.of(context)
          .showSnackBar(messageNOk("Ocurrio un error inseperado"));
    }

    //print('resultado:$result');
  }

  Widget contenidoAtencionSolicitudes(
      Color colorCuadro,
      String detallePrioridad,
      DateTime tempDate,
      SolicitudAyuda solicitudAyuda,
      BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Column(
        children: <Widget>[
          Container(
            decoration: new BoxDecoration(boxShadow: [
              new BoxShadow(
                color: Colors.black12,
                blurRadius: 30.0,
              ),
            ]),
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Column(
                      children: <Widget>[
                        FaIcon(
                          FontAwesomeIcons.eye,
                          color: colorCuadro,
                          size: 30,
                        ),
                        Text(
                          detallePrioridad,
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              new DateFormat("dd/MM/yyyy").format(tempDate),
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              solicitudAyuda.hora,
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Detalle:",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                        RichText(
                          overflow: TextOverflow.clip,
                          text: TextSpan(
                            text: solicitudAyuda.detalle,
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            InkWell(
                              child: FaIcon(
                                FontAwesomeIcons.phoneVolume,
                                size: 25,
                                color: AppTheme.themeVino,
                              ),
                              onTap: () {
                                callNumber(solicitudAyuda.telefono);
                              },
                            ),
                            SizedBox(
                              width: 25,
                            ),
                            InkWell(
                              child: FaIcon(
                                FontAwesomeIcons.comment,
                                size: 25,
                                color: AppTheme.themeVino,
                              ),
                              onTap: () {
                                sendSMS(solicitudAyuda.telefono);
                              },
                            ),
                            SizedBox(
                              width: 25,
                            ),
                            InkWell(
                              child: FaIcon(
                                FontAwesomeIcons.whatsapp,
                                size: 25,
                                color: AppTheme.themeVino,
                              ),
                              onTap: () {
                                callWhatsAppText(solicitudAyuda.telefono,
                                    'Estimado soy ${prefs.correoElectronico}, deseo consultarle o ponerme en contacto con ud. \nEnviado desde la aplicación *SomosUnoBolivia*.');
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                    trailing: InkWell(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          FaIcon(
                            FontAwesomeIcons.checkCircle,
                            color: AppTheme.themeColorVerde,
                            size: 25,
                          ),
                          Text(
                            "Atender",
                          )
                        ],
                      ),
                      onTap: () {
                        _submitCovidAtender(context, solicitudAyuda);
                      },
                    ),
                  ),
                  ButtonBar(
                    alignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[],
                  ),
                ],
              ),
            ),
          ),
          //contenidoCabecera(context, tempDate, solicitudAyuda),
          //contenidoFinal(context, solicitudAyuda),
        ],
      ),
    );
  }
}

class PageMedicmanetos extends StatefulWidget {
  @override
  _PageMedicmanetosState createState() => _PageMedicmanetosState();
}

class _PageMedicmanetosState extends State<PageMedicmanetos> {
  final generic = new Generic();
  final prefs = new PreferensUser();
  String _notificacion = '';
  RegistrarAyuda registrarAyuda = new RegistrarAyuda();

  @override
  Widget build(BuildContext context) {
    final _valor = ModalRoute.of(context).settings.arguments;
    if (_valor != null) _notificacion = _valor;

    return SingleChildScrollView(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              contenedorTitulo(
                context,
                40.0,
                "Medicamentos y abastecimientos".toUpperCase(),
                FaIcon(FontAwesomeIcons.photoVideo, color: AppTheme.themeVino),
              ),
              AutoSizeText(
                'Estamos en el Departamento de : ${obtenerDepartamento(prefs.idDepartamento)} ',
                style: kSubTitleCardStyle,
                maxLines: 2,
                minFontSize: 15.0,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.justify,
              ),
              Opacity(
                  opacity: _notificacion.length > 1 ? 1.0 : 0.0,
                  child: Text('Atención: Ayuda urgente activada.')),
              Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          FlatButton(
                            color: AppTheme.themeVino,
                            textColor: Colors.white,
                            disabledColor: Colors.grey,
                            disabledTextColor: Colors.black,
                            splashColor: Colors.white,
                            onPressed: () {
                              openWeb('http://mapacovid19.ruta88.net/');
                            },
                            child: Text("Mapa de solicitudes"),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          FlatButton(
                            color: AppTheme.themeVino,
                            textColor: Colors.white,
                            disabledColor: Colors.grey,
                            disabledTextColor: Colors.black,
                            splashColor: Colors.greenAccent,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CitizenAlertEmergency(
                                        "-1", prefs.idPersonal)),
                              );
                            },
                            child: Text("Mis atenciones"),
                          ),
                        ],
                      ))),
              future(context),
            ],
          ),
        ),
      ),
    );
    //backgroundColor: colorCuadro,
  }

  Widget future(BuildContext context) {
    return FutureBuilder(
        future: Generic().getAll(
            new SolicitudAyuda(),
            urlGetListaSolicitudesAyudas +
                '/66' +
                '/' +
                prefs.idDepartamento.toString(),
            primaryKeyListaSolicitudesAyudas),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
              break;
            default:
              //mostramos los datos
              return buildItemSolcitud(context, snapshot);
          }
        });
  }

  Widget buildItemSolcitud(BuildContext context, AsyncSnapshot snapshot) {
    return Container(
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: ClampingScrollPhysics(),
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) {
            SolicitudAyuda item = snapshot.data[index];
            return itemSolicitud(context, item);
          }),
    );
  }

  Widget itemSolicitud(BuildContext context, SolicitudAyuda solicitudAyuda) {
    DateTime tempDate =
        new DateFormat("dd/MM/yyyy").parse(solicitudAyuda.fecha);
    Color colorCuadro;
    String detallePrioridad;
    if (solicitudAyuda.idaPrioridad == 68) {
      colorCuadro = AppTheme.themeColorRojo;
      detallePrioridad = "Muy alta";
    } else if (solicitudAyuda.idaPrioridad == 69) {
      colorCuadro = AppTheme.themeColorNaranja;
      detallePrioridad = "Alta";
    } else {
      colorCuadro = AppTheme.themeAmarillo;
      detallePrioridad = "Media";
    }
    return contenidoAtencionSolicitudes(
        colorCuadro, detallePrioridad, tempDate, solicitudAyuda, context);
  }

  // _submitConcluido(BuildContext context, SolicitudAyuda solicitudAyuda) async {
  //   registrarAyuda.idaBotonPanico = solicitudAyuda.idaBotonPanico;
  //   registrarAyuda.idaPersonal = int.parse(prefs.idPersonal);
  //   registrarAyuda.fecha =
  //       DateFormat("dd/MM/yyyy HH:mm").format(DateTime.now());
  //   registrarAyuda.idaEstado = 79; // en concluido
  //   registrarAyuda.usuario = prefs.correoElectronico;

  //   final dataMap = generic.add(registrarAyuda, urlAddSolicitudAyud);
  //   var result;
  //   await dataMap.then((respuesta) => result = respuesta["TIPO_RESPUESTA"]);
  //   if (result == "0") {
  //     setState(() {
  //       Scaffold.of(context)
  //           .showSnackBar(messageOk("Se concluyo la solicitud"));
  //     });
  //   } else {
  //     Scaffold.of(context)
  //         .showSnackBar(messageNOk("Ocurrio un error inseperado"));
  //   }

  //   //print('resultado:$result');
  // }

  _submitAtender(BuildContext context, SolicitudAyuda solicitudAyuda) async {
    registrarAyuda.idaBotonPanico = solicitudAyuda.idaBotonPanico;
    registrarAyuda.idaPersonal = int.parse(prefs.idPersonal);
    registrarAyuda.fecha =
        DateFormat("dd/MM/yyyy HH:mm").format(DateTime.now());
    registrarAyuda.idaEstado = 78; // en cursoF
    registrarAyuda.usuario = prefs.correoElectronico;

    final dataMap = generic.add(registrarAyuda, urlAddSolicitudAyud);
    var result;
    await dataMap.then((respuesta) => result = respuesta["TIPO_RESPUESTA"]);
    if (result == "0") {
      setState(() {
        Scaffold.of(context)
            .showSnackBar(messageOk("Se puso en atención su solicitud"));
      });
    } else {
      Scaffold.of(context)
          .showSnackBar(messageNOk("Ocurrio un error inseperado"));
    }

    //print('resultado:$result');
  }

  Widget contenidoAtencionSolicitudes(
      Color colorCuadro,
      String detallePrioridad,
      DateTime tempDate,
      SolicitudAyuda solicitudAyuda,
      BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Column(
        children: <Widget>[
          Container(
            decoration: new BoxDecoration(boxShadow: [
              new BoxShadow(
                color: Colors.black12,
                blurRadius: 30.0,
              ),
            ]),
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Column(
                      children: <Widget>[
                        FaIcon(
                          FontAwesomeIcons.eye,
                          color: colorCuadro,
                          size: 30,
                        ),
                        Text(
                          detallePrioridad,
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              new DateFormat("dd/MM/yyyy").format(tempDate),
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              solicitudAyuda.hora,
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Detalle:",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                        RichText(
                          overflow: TextOverflow.clip,
                          text: TextSpan(
                            text: solicitudAyuda.detalle,
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            InkWell(
                              child: FaIcon(
                                FontAwesomeIcons.phoneVolume,
                                size: 25,
                                color: AppTheme.themeVino,
                              ),
                              onTap: () {
                                callNumber(solicitudAyuda.telefono);
                              },
                            ),
                            SizedBox(
                              width: 25,
                            ),
                            InkWell(
                              child: FaIcon(
                                FontAwesomeIcons.comment,
                                size: 25,
                                color: AppTheme.themeVino,
                              ),
                              onTap: () {
                                sendSMS(solicitudAyuda.telefono);
                              },
                            ),
                            SizedBox(
                              width: 25,
                            ),
                            InkWell(
                              child: FaIcon(
                                FontAwesomeIcons.whatsapp,
                                size: 25,
                                color: AppTheme.themeVino,
                              ),
                              onTap: () {
                                callWhatsAppText(solicitudAyuda.telefono,
                                    'Estimado soy ${prefs.correoElectronico}, deseo consultarle o ponerme en contacto con ud. \nEnviado desde la aplicación *SomosUnoBolivia*.');
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                    trailing: InkWell(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          FaIcon(
                            FontAwesomeIcons.checkCircle,
                            color: AppTheme.themeColorVerde,
                            size: 25,
                          ),
                          Text(
                            "Atender",
                          )
                        ],
                      ),
                      onTap: () {
                        _submitAtender(context, solicitudAyuda);
                      },
                    ),
                  ),
                  ButtonBar(
                    alignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[],
                  ),
                ],
              ),
            ),
          ),
          //contenidoCabecera(context, tempDate, solicitudAyuda),
          //contenidoFinal(context, solicitudAyuda),
        ],
      ),
    );
  }
}

class PageOxigeno extends StatefulWidget {
  @override
  _PageOxigenoState createState() => _PageOxigenoState();
}

class _PageOxigenoState extends State<PageOxigeno> {
  final generic = new Generic();
  final prefs = new PreferensUser();
  String _notificacion = '';
  RegistrarAyuda registrarAyuda = new RegistrarAyuda();

  @override
  Widget build(BuildContext context) {
    final _valor = ModalRoute.of(context).settings.arguments;
    if (_valor != null) _notificacion = _valor;

    return SingleChildScrollView(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              contenedorTitulo(
                context,
                40.0,
                "Oxigeno".toUpperCase(),
                FaIcon(FontAwesomeIcons.photoVideo, color: AppTheme.themeVino),
              ),
              AutoSizeText(
                'Estamos en el Departamento de : ${obtenerDepartamento(prefs.idDepartamento)} ',
                style: kSubTitleCardStyle,
                maxLines: 2,
                minFontSize: 15.0,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.justify,
              ),
              Opacity(
                  opacity: _notificacion.length > 1 ? 1.0 : 0.0,
                  child: Text('Atención: Ayuda urgente activada.')),
              Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          FlatButton(
                            color: AppTheme.themeVino,
                            textColor: Colors.white,
                            disabledColor: Colors.grey,
                            disabledTextColor: Colors.black,
                            splashColor: Colors.white,
                            onPressed: () {
                              openWeb('http://mapacovid19.ruta88.net/');
                            },
                            child: Text("Mapa de solicitudes"),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          FlatButton(
                            color: AppTheme.themeVino,
                            textColor: Colors.white,
                            disabledColor: Colors.grey,
                            disabledTextColor: Colors.black,
                            splashColor: Colors.greenAccent,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CitizenAlertEmergency(
                                        "-1", prefs.idPersonal)),
                              );
                            },
                            child: Text("Mis atenciones"),
                          ),
                        ],
                      ))),
              futureBonos(context),
            ],
          ),
        ),
      ),
    );
    //backgroundColor: colorCuadro,
  }

  Widget futureBonos(BuildContext context) {
    return FutureBuilder(
        future: Generic().getAll(
            new SolicitudAyuda(),
            urlGetListaSolicitudesAyudas +
                '/77' +
                '/' +
                prefs.idDepartamento.toString(),
            primaryKeyListaSolicitudesAyudas),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
              break;
            default:
              //mostramos los datos
              return buildItemSolcitud(context, snapshot);
          }
        });
  }

  Widget buildItemSolcitud(BuildContext context, AsyncSnapshot snapshot) {
    return Container(
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: ClampingScrollPhysics(),
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) {
            SolicitudAyuda item = snapshot.data[index];
            return itemSolicitud(context, item);
          }),
    );
  }

  Widget itemSolicitud(BuildContext context, SolicitudAyuda solicitudAyuda) {
    DateTime tempDate =
        new DateFormat("dd/MM/yyyy").parse(solicitudAyuda.fecha);
    Color colorCuadro;
    String detallePrioridad;
    if (solicitudAyuda.idaPrioridad == 68) {
      colorCuadro = AppTheme.themeColorRojo;
      detallePrioridad = "Muy alta";
    } else if (solicitudAyuda.idaPrioridad == 69) {
      colorCuadro = AppTheme.themeColorNaranja;
      detallePrioridad = "Alta";
    } else {
      colorCuadro = AppTheme.themeAmarillo;
      detallePrioridad = "Media";
    }
    return contenidoAtencionSolicitudes(
        colorCuadro, detallePrioridad, tempDate, solicitudAyuda, context);
  }

  // _submitMedicamentosConcluido(
  //     BuildContext context, SolicitudAyuda solicitudAyuda) async {
  //   registrarAyuda.idaBotonPanico = solicitudAyuda.idaBotonPanico;
  //   registrarAyuda.idaPersonal = int.parse(prefs.idPersonal);
  //   registrarAyuda.fecha =
  //       DateFormat("dd/MM/yyyy HH:mm").format(DateTime.now());
  //   registrarAyuda.idaEstado = 79; // en concluido
  //   registrarAyuda.usuario = prefs.correoElectronico;

  //   final dataMap = generic.add(registrarAyuda, urlAddSolicitudAyud);
  //   var result;
  //   await dataMap.then((respuesta) => result = respuesta["TIPO_RESPUESTA"]);
  //   if (result == "0") {
  //     setState(() {
  //       Scaffold.of(context)
  //           .showSnackBar(messageOk("Se concluyo la solicitud"));
  //     });
  //   } else {
  //     Scaffold.of(context)
  //         .showSnackBar(messageNOk("Ocurrio un error inseperado"));
  //   }

  //   //print('resultado:$result');
  // }

  _submitMedicamentosAtender(
      BuildContext context, SolicitudAyuda solicitudAyuda) async {
    registrarAyuda.idaBotonPanico = solicitudAyuda.idaBotonPanico;
    registrarAyuda.idaPersonal = int.parse(prefs.idPersonal);
    registrarAyuda.fecha =
        DateFormat("dd/MM/yyyy HH:mm").format(DateTime.now());
    registrarAyuda.idaEstado = 78; // en cursoF
    registrarAyuda.usuario = prefs.correoElectronico;

    final dataMap = generic.add(registrarAyuda, urlAddSolicitudAyud);
    var result;
    await dataMap.then((respuesta) => result = respuesta["TIPO_RESPUESTA"]);
    if (result == "0") {
      setState(() {
        Scaffold.of(context)
            .showSnackBar(messageOk("Se puso en atención su solicitud"));
      });
    } else {
      Scaffold.of(context)
          .showSnackBar(messageNOk("Ocurrio un error inseperado"));
    }

    //print('resultado:$result');
  }

  Widget contenidoAtencionSolicitudes(
      Color colorCuadro,
      String detallePrioridad,
      DateTime tempDate,
      SolicitudAyuda solicitudAyuda,
      BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Column(
        children: <Widget>[
          Container(
            decoration: new BoxDecoration(boxShadow: [
              new BoxShadow(
                color: Colors.black12,
                blurRadius: 30.0,
              ),
            ]),
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Column(
                      children: <Widget>[
                        FaIcon(
                          FontAwesomeIcons.eye,
                          color: colorCuadro,
                          size: 30,
                        ),
                        Text(
                          detallePrioridad,
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              new DateFormat("dd/MM/yyyy").format(tempDate),
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              solicitudAyuda.hora,
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Detalle:",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                        RichText(
                          overflow: TextOverflow.clip,
                          text: TextSpan(
                            text: solicitudAyuda.detalle,
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            InkWell(
                              child: FaIcon(
                                FontAwesomeIcons.phoneVolume,
                                size: 25,
                                color: AppTheme.themeVino,
                              ),
                              onTap: () {
                                callNumber(solicitudAyuda.telefono);
                              },
                            ),
                            SizedBox(
                              width: 25,
                            ),
                            InkWell(
                              child: FaIcon(
                                FontAwesomeIcons.comment,
                                size: 25,
                                color: AppTheme.themeVino,
                              ),
                              onTap: () {
                                sendSMS(solicitudAyuda.telefono);
                              },
                            ),
                            SizedBox(
                              width: 25,
                            ),
                            InkWell(
                              child: FaIcon(
                                FontAwesomeIcons.whatsapp,
                                size: 25,
                                color: AppTheme.themeVino,
                              ),
                              onTap: () {
                                callWhatsAppText(solicitudAyuda.telefono,
                                    'Estimado soy ${prefs.correoElectronico}, deseo consultarle o ponerme en contacto con ud. \nEnviado desde la aplicación *SomosUnoBolivia*.');
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                    trailing: InkWell(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          FaIcon(
                            FontAwesomeIcons.checkCircle,
                            color: AppTheme.themeColorVerde,
                            size: 25,
                          ),
                          Text(
                            "Atender",
                          )
                        ],
                      ),
                      onTap: () {
                        _submitMedicamentosAtender(context, solicitudAyuda);
                      },
                    ),
                  ),
                  ButtonBar(
                    alignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[],
                  ),
                ],
              ),
            ),
          ),
          //contenidoCabecera(context, tempDate, solicitudAyuda),
          //contenidoFinal(context, solicitudAyuda),
        ],
      ),
    );
  }
}

class PageAyudaAmigo extends StatefulWidget {
  PageAyudaAmigo({Key key}) : super(key: key);

  @override
  _PageAyudaAmigoState createState() => _PageAyudaAmigoState();
}

class _PageAyudaAmigoState extends State<PageAyudaAmigo> {
  final generic = new Generic();
  final prefs = new PreferensUser();
  String _notificacion = '';
  RegistrarAyuda registrarAyuda = new RegistrarAyuda();

  @override
  Widget build(BuildContext context) {
    final _valor = ModalRoute.of(context).settings.arguments;
    if (_valor != null) _notificacion = _valor;

    return SingleChildScrollView(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              contenedorTitulo(
                context,
                40.0,
                "Ayuda a un amig@".toUpperCase(),
                FaIcon(FontAwesomeIcons.photoVideo, color: AppTheme.themeVino),
              ),
              AutoSizeText(
                'Estamos en el Departamento de : ${obtenerDepartamento(prefs.idDepartamento)} ',
                style: kSubTitleCardStyle,
                maxLines: 2,
                minFontSize: 15.0,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.justify,
              ),
              Opacity(
                  opacity: _notificacion.length > 1 ? 1.0 : 0.0,
                  child: Text('Atención: Ayuda urgente activada.')),
              Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          FlatButton(
                            color: AppTheme.themeVino,
                            textColor: Colors.white,
                            disabledColor: Colors.grey,
                            disabledTextColor: Colors.black,
                            splashColor: Colors.white,
                            onPressed: () {
                              openWeb('http://mapacovid19.ruta88.net/');
                            },
                            child: Text("Mapa de solicitudes"),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          FlatButton(
                            color: AppTheme.themeVino,
                            textColor: Colors.white,
                            disabledColor: Colors.grey,
                            disabledTextColor: Colors.black,
                            splashColor: Colors.greenAccent,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CitizenAlertEmergency(
                                        "-1", prefs.idPersonal)),
                              );
                            },
                            child: Text("Mis atenciones"),
                          ),
                        ],
                      ))),
              futureSolicitudesAmigo(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget futureSolicitudesAmigo(BuildContext context) {
    return FutureBuilder(
        future: Generic().getAll(
            new SolicitudAyuda(),
            urlGetListaSolicitudesAyudas +
                '/-1' +
                '/' +
                prefs.idDepartamento.toString(),
            primaryKeyListaSolicitudesAyudas),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
              break;
            default:
              //mostramos los datos
              return buildItemSolcitud(context, snapshot);
          }
        });
  }

  Widget buildItemSolcitud(BuildContext context, AsyncSnapshot snapshot) {
    return Container(
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: ClampingScrollPhysics(),
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) {
            SolicitudAyuda item = snapshot.data[index];
            return itemSolicitud(context, item);
          }),
    );
  }

  Widget itemSolicitud(BuildContext context, SolicitudAyuda solicitudAyuda) {
    DateTime tempDate =
        new DateFormat("dd/MM/yyyy").parse(solicitudAyuda.fecha);
    Color colorCuadro;
    String detallePrioridad;

    if (solicitudAyuda.nombrePrioridad.toString() == "Muy Alta") {
      colorCuadro = AppTheme.themeColorRojo;
      detallePrioridad = "Muy alta";
    } else if (solicitudAyuda.nombrePrioridad.toString() == "Alta") {
      colorCuadro = AppTheme.themeVino;
      detallePrioridad = "Alta";
    } else {
      colorCuadro = AppTheme.themeColorVerde;
      detallePrioridad = "Media";
    }

    return contenidoAtencionSolicitudes(
        colorCuadro, detallePrioridad, tempDate, solicitudAyuda, context);
  }

  // _submitMedicamentosConcluido(
  //     BuildContext context, SolicitudAyuda solicitudAyuda) async {
  //   registrarAyuda.idaBotonPanico = solicitudAyuda.idaBotonPanico;
  //   registrarAyuda.idaPersonal = int.parse(prefs.idPersonal);
  //   registrarAyuda.fecha =
  //       DateFormat("dd/MM/yyyy HH:mm").format(DateTime.now());
  //   registrarAyuda.idaEstado = 79; // en concluido
  //   registrarAyuda.usuario = prefs.correoElectronico;

  //   final dataMap = generic.add(registrarAyuda, urlAddSolicitudAyud);
  //   var result;
  //   await dataMap.then((respuesta) => result = respuesta["TIPO_RESPUESTA"]);
  //   if (result == "0") {
  //     setState(() {
  //       Scaffold.of(context)
  //           .showSnackBar(messageOk("Se concluyo la solicitud"));
  //     });
  //   } else {
  //     Scaffold.of(context)
  //         .showSnackBar(messageNOk("Ocurrio un error inseperado"));
  //   }

  //   //print('resultado:$result');
  // }

  _submitAyudaAmigo(BuildContext context, SolicitudAyuda solicitudAyuda) async {
    registrarAyuda.idaBotonPanico = solicitudAyuda.idaBotonPanico;
    registrarAyuda.idaPersonal = int.parse(prefs.idPersonal);
    registrarAyuda.fecha =
        DateFormat("dd/MM/yyyy HH:mm").format(DateTime.now());
    registrarAyuda.idaEstado = 78; // en cursoF
    registrarAyuda.usuario = prefs.correoElectronico;

    final dataMap = generic.add(registrarAyuda, urlAddSolicitudAyudaAmigo);
    var result;
    await dataMap.then((respuesta) => result = respuesta["TIPO_RESPUESTA"]);
    if (result == "0") {
      setState(() {
        Scaffold.of(context)
            .showSnackBar(messageOk("Se puso en atención su solicitud"));
      });
    } else {
      Scaffold.of(context)
          .showSnackBar(messageNOk("Ocurrio un error inseperado"));
    }

    //print('resultado:$result');
  }

  Widget contenidoAtencionSolicitudes(
      Color colorCuadro,
      String detallePrioridad,
      DateTime tempDate,
      SolicitudAyuda solicitudAyuda,
      BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Column(
        children: <Widget>[
          Container(
            decoration: new BoxDecoration(boxShadow: [
              new BoxShadow(
                color: Colors.black12,
                blurRadius: 30.0,
              ),
            ]),
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Column(
                      children: <Widget>[
                        FaIcon(
                          FontAwesomeIcons.eye,
                          color: colorCuadro,
                          size: 30,
                        ),
                        Text(
                          detallePrioridad,
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              new DateFormat("dd/MM/yyyy").format(tempDate),
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              solicitudAyuda.hora,
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Detalle:",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                        RichText(
                          overflow: TextOverflow.clip,
                          text: TextSpan(
                            text: solicitudAyuda.detalle,
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            InkWell(
                              child: FaIcon(
                                FontAwesomeIcons.phoneVolume,
                                size: 25,
                                color: AppTheme.themeVino,
                              ),
                              onTap: () {
                                callNumber(solicitudAyuda.telefono);
                              },
                            ),
                            SizedBox(
                              width: 25,
                            ),
                            InkWell(
                              child: FaIcon(
                                FontAwesomeIcons.comment,
                                size: 25,
                                color: AppTheme.themeVino,
                              ),
                              onTap: () {
                                sendSMS(solicitudAyuda.telefono);
                              },
                            ),
                            SizedBox(
                              width: 25,
                            ),
                            InkWell(
                              child: FaIcon(
                                FontAwesomeIcons.whatsapp,
                                size: 25,
                                color: AppTheme.themeVino,
                              ),
                              onTap: () {
                                callWhatsAppText(solicitudAyuda.telefono,
                                    'Estimado soy ${prefs.correoElectronico}, deseo consultarle o ponerme en contacto con ud. \nEnviado desde la aplicación *SomosUnoBolivia*.');
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                    trailing: InkWell(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          FaIcon(
                            FontAwesomeIcons.checkCircle,
                            color: Colors.black,
                            size: 20,
                          ),
                          Text(
                            "Atender",
                          )
                        ],
                      ),
                      onTap: () {
                        _submitAyudaAmigo(context, solicitudAyuda);
                      },
                    ),
                  ),
                  ButtonBar(
                    alignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[],
                  ),
                ],
              ),
            ),
          ),
          //contenidoCabecera(context, tempDate, solicitudAyuda),
          //contenidoFinal(context, solicitudAyuda),
        ],
      ),
    );
  }
}
