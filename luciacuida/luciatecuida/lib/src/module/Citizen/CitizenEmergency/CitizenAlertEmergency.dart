import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:luciatecuida/src/Model/Entity.dart';
import 'package:luciatecuida/src/Model/Generic.dart';
import 'package:luciatecuida/src/Model/PreferenceUser.dart';
import 'package:luciatecuida/src/Theme/ThemeModule.dart';
import 'package:luciatecuida/src/Util/Util.dart';
import 'package:luciatecuida/src/Widget/GeneralWidget.dart';
import 'package:luciatecuida/src/Widget/Message/Message.dart';
import 'package:luciatecuida/src/module/HomePage/HomePageModule.dart';
import 'package:luciatecuida/src/module/Settings/RoutesModule.dart';

class CitizenAlertEmergency extends StatefulWidget {
  String personal;
  String voluntario;
  static final String routeName = 'CiudadanoAlertaEmergencia';

  CitizenAlertEmergency(this.personal, this.voluntario);

  @override
  _CitizenAlertEmergencyState createState() => _CitizenAlertEmergencyState();
}

class _CitizenAlertEmergencyState extends State<CitizenAlertEmergency> {
  final prefs = new PreferensUser();
  RegistrarAyuda registrarAyuda = new RegistrarAyuda();

  @override
  void initState() {
    prefs.ultimaPagina = CitizenAlertEmergency.routeName;
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
              title: Text("Historial de solicitudes".toUpperCase(),
                  style: kTitleAppBar),
              //backgroundColor: colorCuadro,
            ),
            drawer: DrawerCitizen(),
            floatingActionButton: generaFloatbuttonHome(context),
            // backgroundColor: Colors.red,
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  cuerpoSolicitudes(),
                  copyRigth(),
                ],
              ),
            )));
  }

  Widget cuerpoSolicitudes() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            futureSolicitudes(context),
          ],
        ),
      ),
    );
  }

  Widget futureSolicitudes(BuildContext context) {
    return FutureBuilder(
        future: Generic().getAll(
            new SolicitudAyuda(),
            urlGetHistorialListaSolicitudesAyudas +
                '/${widget.personal}' +
                '/${widget.voluntario}',
            primaryKeyHistorialListaSolicitudesAyudas),
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
    return SingleChildScrollView(
      child: Padding(
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
                          Text(
                            "Fecha solicitud:",
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                new DateFormat("dd/MM/yyyy").format(tempDate),
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(
                                width: 10,
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
                              fontWeight: FontWeight.w800,
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: RichText(
                                  overflow: TextOverflow.clip,
                                  text: TextSpan(
                                    text: solicitudAyuda.detalle,
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "Voluntario asignado:",
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                (solicitudAyuda.nombrePersonalAtendio.length <=
                                        0)
                                    ? "En curso de atención"
                                    : solicitudAyuda.nombrePersonalAtendio,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "Institución:",
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                (solicitudAyuda
                                            .nombreInstitucionAtencion.length <=
                                        0)
                                    ? "En curso de atención"
                                    : solicitudAyuda.nombreInstitucionAtencion,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "Fecha de asignación con voluntario:",
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                (solicitudAyuda.fechaAtencion.length <= 0)
                                    ? "En curso de atención"
                                    : solicitudAyuda.fechaAtencion,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      trailing: Opacity(
                        opacity: controlVisibilidadConclusion(solicitudAyuda),
                        //   ( widget.voluntario!= "-1" && (  solicitudAyuda.idaEstadoSolicitud == 79 || solicitudAyuda.idaEstadoSolicitud == 72)) ? 0 : 1,
                        child: InkWell(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              FaIcon(
                                FontAwesomeIcons.checkCircle,
                                color: Colors.black,
                                size: 20,
                              ),
                              Text(
                                "Concluir",
                              )
                            ],
                          ),
                          onTap: () {
                            _submitConcluirAtencionr(context, solicitudAyuda);
                          },
                        ),
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
      ),
    );
  }

  double controlVisibilidadConclusion(SolicitudAyuda solicitudAyuda) {
    if (widget.voluntario == "-1") {
      return 0;
    } else {
      if (solicitudAyuda.idaEstadoSolicitud == 72) {
        return 1;
      } else {
        return 0;
      }
    }
  }

  _submitConcluirAtencionr(
      BuildContext context, SolicitudAyuda solicitudAyuda) async {
    registrarAyuda.idaBotonPanico = solicitudAyuda.idaBotonPanico;
    registrarAyuda.idaPersonal = int.parse(prefs.idPersonal);
    registrarAyuda.fecha =
        DateFormat("dd/MM/yyyy HH:mm").format(DateTime.now());
    registrarAyuda.idaEstado = 79; // en cursoF
    registrarAyuda.usuario = prefs.correoElectronico;

    final dataMap = Generic().add(registrarAyuda, urlAddSolicitudAyudaAmigo);
    var result;
    await dataMap.then((respuesta) => result = respuesta["TIPO_RESPUESTA"]);
    if (result == "0") {
      setState(() {
        Scaffold.of(context).showSnackBar(messageOk("Se concluyo la atención"));
      });
    } else {
      Scaffold.of(context)
          .showSnackBar(messageNOk("Ocurrio un error inseperado"));
    }

    setState(() {});

    //print('resultado:$result');
  }
}
