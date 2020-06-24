import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:luciatecuida/src/Model/Entity.dart';
import 'package:luciatecuida/src/Model/Generic.dart';
import 'package:luciatecuida/src/Model/PreferenceUser.dart';
import 'package:luciatecuida/src/Theme/ThemeModule.dart';
import 'package:luciatecuida/src/Util/Util.dart';
import 'package:luciatecuida/src/Widget/GeneralWidget.dart';
import 'package:luciatecuida/src/Widget/Message/Message.dart';
import 'package:luciatecuida/src/module/Citizen/CitizenEmergency/CitizenAlertEmergency.dart';
import 'package:luciatecuida/src/module/HomePage/HomePageModule.dart';
import 'package:luciatecuida/src/module/Settings/RoutesModule.dart';

class CitizenPanicButtonModule extends StatefulWidget {
  static final String routeName = 'CiudadanoBotonPanico';

  const CitizenPanicButtonModule({Key key}) : super(key: key);

  @override
  _CitizenPanicButtonModuleState createState() =>
      _CitizenPanicButtonModuleState();
}

class _CitizenPanicButtonModuleState extends State<CitizenPanicButtonModule> {
  final prefs = new PreferensUser();

  @override
  void initState() {
    prefs.ultimaPagina = CitizenPanicButtonModule.routeName;
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
            title: Text("PIDE AYUDA URGENTE", style: kTitleAppBar),
            actions: <Widget>[],
            //backgroundColor: AppTheme.themeColorNaranja,
          ),
          drawer: DrawerCitizen(),
         floatingActionButton: generaFloatbuttonHome(context),         
    
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                ButtonPanic(
                  titulo: "CONSULTA",
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    margin: EdgeInsets.only(right: 15),
                    child: FlatButton(
                      color: AppTheme.themeVino,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  CitizenAlertEmergency(prefs.userId, "-1")),
                        );
                      },
                      child: Text(
                        "Mi Historial",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                // ButtonPanic(
                //   titulo: "CONSULTA MÉDICA",
                //   tipoBoton: "64",
                // ),
                // ButtonPanic(
                //   titulo: "COMPRA MEDICAMENTOS-INSUMOS",
                //   tipoBoton: "66",
                // ),
                // ButtonPanic(
                //   titulo: "BONOS Y OTROS SERVICIOS",
                //   tipoBoton: "77",
                // ),
                copyRigth(),
              ],
            ),
          )),
    );
  }
}

class ButtonPanic extends StatefulWidget {
  final String titulo;

  const ButtonPanic({
    Key key,
    this.titulo,
  }) : super(key: key);

  @override
  _ButtonPanic createState() => _ButtonPanic();
}

class _ButtonPanic extends State<ButtonPanic> {
  BotonPanico botonPanico = new BotonPanico();
  final generic = new Generic();

  int _group = 1;
  int _selectedRadio = 1;

  bool checkMuyAlto = false;
  bool checkAlto = false;
  bool checkMedio = false;
  String fechaNotificacion = "-/-/- --:--";
  final prefs = new PreferensUser();

  @override
  void initState() {
    checkMedio = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: buttonPanic(),
    );
  }

  Widget buttonPanic() {
    //botonPanico.botFecha=DateTime.now();

    

    botonPanico.botFecha =
        DateFormat("dd/MM/yyyy HH:mm").format(DateTime.now());

    botonPanico.usuario = prefs.correoElectronico;

    ///72 Solicitud enviada
    botonPanico.idaEstadoSolicitud = 72;

    var textStyle = TextStyle(
        fontSize: 16.5, fontWeight: FontWeight.w900, color: AppTheme.themeVino);

    return Stack(
      children: <Widget>[
        Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black12,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(12),
              //color: Colors.white
            ),
            //color: Colors.red,
            margin: EdgeInsets.only(top: 5, left: 7, right: 7),
            child: Padding(
                padding: const EdgeInsets.only(
                  top: 0.0,
                ),
                child: ListTile(
                  title: Container(
                    padding: EdgeInsets.only(top: 1, left: 2),
                    //height: 20.0,
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Selecciona tipo de ayuda".toUpperCase(),
                                style: textStyle),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text('Consulta COVID',
                                style: TextStyle(fontSize: 12)),
                            Radio(
                              value: 65,
                              groupValue: _group,
                              onChanged: (T) {
                                //print(T);
                                _selectedRadio = T;
                                setState(() {
                                  _group = T;
                                });
                              },
                            ),
                            Text('Medicamentos-alimentos',
                                style: TextStyle(fontSize: 12)),
                            Radio(
                              value: 66,
                              groupValue: _group,
                              onChanged: (T) {
                                //print(T);
                                _selectedRadio = T;
                                setState(() {
                                  _group = T;
                                });
                              },
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text('Consulta Médica',
                                style: TextStyle(fontSize: 12)),
                            Radio(
                              value: 64,
                              groupValue: _group,
                              onChanged: (T) {
                                //print(T);
                                _selectedRadio = T;
                                setState(() {
                                  _group = T;
                                });
                              },
                            ),
                            Text('Bonos - otros servicios',
                                style: TextStyle(fontSize: 12)),
                            Radio(
                              value: 77,
                              groupValue: _group,
                              onChanged: (T) {
                                //print(T);
                                _selectedRadio = T;
                                setState(() {
                                  _group = T;
                                });
                              },
                            ),
                          ],
                        ),
                        divider(),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text("Selecciona la prioridad:".toUpperCase(),
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w700)),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Muy Alta",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w700),
                            ),
                            Checkbox(
                                value: checkMuyAlto,
                                onChanged: (bool value) {
                                  setState(() {
                                    //print(value);

                                    botonPanico.idaPrioridad = 68;
                                    //print(botonPanico.idaPrioridad);
                                    checkMuyAlto = true;
                                    checkAlto = false;
                                    checkMedio = false;
                                  });
                                }),
                            Text("Alta",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w700)),
                            Checkbox(
                                value: checkAlto,
                                onChanged: (bool value) {
                                  setState(() {
                                    //print(value);
                                    botonPanico.idaPrioridad = 69;
                                    //print(botonPanico.idaPrioridad);

                                    checkMuyAlto = false;
                                    checkAlto = true;
                                    checkMedio = false;
                                  });
                                }),
                            Text("Media",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w700)),
                            Checkbox(
                                value: checkMedio,
                                onChanged: (bool value) {
                                  setState(() {
                                    //print(value);
                                    botonPanico.idaPrioridad = 70;
                                    //print(botonPanico.idaPrioridad);

                                    checkMuyAlto = false;
                                    checkAlto = false;
                                    checkMedio = true;
                                  });
                                })
                          ],
                        ),
                        TextFormField(
                          style: TextStyle(color: Colors.black, fontSize: 13),
                         // textCapitalization: TextCapitalization.sentences,
                          //enableSuggestions: true,
                          maxLength: 100,
                          maxLines: 3,
                          minLines: 1,
                          autocorrect: true,
                          autovalidate: false,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            focusColor: Colors.blue,
                            labelStyle:
                                TextStyle(fontSize: 14, color: Colors.black),
                            labelText: "Ingrese sus síntomas y/o ayuda:",
                            border: InputBorder.none,
                            hintText: 'Ingrese su inquietud',
                            hintStyle:
                                TextStyle(fontSize: 14, color: Colors.black),
                          ),
                          onChanged: (value) {
                            botonPanico.botDetalle = value;
                          },
                           
                        ),
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          textCapitalization: TextCapitalization.sentences,
                          enableSuggestions: true,
                          maxLength: 10,
                          style: TextStyle(color: Colors.black, fontSize: 13),
                          decoration: InputDecoration(
                            labelStyle:
                                TextStyle(fontSize: 14, color: Colors.black),
                            labelText: "Ingrese su número de teléfono:",
                            border: InputBorder.none,
                            helperText: 'Ejemplo: 72038234',
                            hintText:
                                'Ingrese el número de telefono para comunicarnos con ud.',
                            hintStyle:
                                TextStyle(fontSize: 14, color: Colors.black),
                          ),
                          onChanged: (value) {
                            botonPanico.botTelefono = value;
                          },
                        ),
                        Center(
                          child: FlatButton(
                            color: AppTheme.themeVino,
                            onPressed: () {
                              botonPanico.idaCatalogo = _selectedRadio;
                              _submit();
                              setState(() {
                                fechaNotificacion =
                                    DateFormat("dd/MM/yyyy HH:mm")
                                        .format(DateTime.now());
                              });
                            },
                            child: Icon(Icons.pan_tool, color: Colors.white),
                          ),
                        ),
divider(),
                         AutoSizeText(
                'Importante. El registro de los síntomas y nro. de teléfono son necesarios para que el voluntario se pongan en contacto con su persona.',
                style: kSubTitleCardStyle,
                maxLines: 3,
                minFontSize: 14.0,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.justify,
                
              ),
                      ],
                    ),
                  ),
                ))),
      ],
    );
  }

  _submit() async {
    //print(botonPanico);
    LatLng latLng;
    latLng = await getLocation().then((onvalue) => latLng = onvalue);

    //print(' el valorrr.... ${prefs.userId}');
    botonPanico.idLogin = int.parse(prefs.userId);
    botonPanico.botCordenadalat = latLng.latitude;
    botonPanico.botCordenadalon = latLng.longitude;

    if (botonPanico.idaCatalogo == 1) {
      Scaffold.of(context).showSnackBar(
          messageWarning("Debe seleccionar el tipo de ayuda que necesita"));
      return;
    } else if (botonPanico.botDetalle == null ||
        botonPanico.botTelefono == null) {
      Scaffold.of(context).showSnackBar(messageWarning(
          "Debe completar los campos los campos del detalle y teléfono"));
      return;
    } else {
      final dataMap = generic.add(botonPanico, urlAddBotonPanico);
      var result;
      await dataMap.then((respuesta) => result = respuesta["TIPO_RESPUESTA"]);
      if (result == "0") {
        Scaffold.of(context).showSnackBar(messageOk(
            "Se registro correctamente, a las ${DateFormat("HH:mm").format(DateTime.now())} del ${DateFormat("dd/MM/yyyy").format(DateTime.now())}"));

        enviarNotificaciones(
            urlGetToken + '4/-',
            'ayudaPersona',
            'Solicitud de atención a una persona',
            'Usuario: ${prefs.correoElectronico} solicita ayuda',
            '',
            '');
      } else {
        Scaffold.of(context)
            .showSnackBar(messageNOk("Ocurrio un error inseperado"));
      }

      //print('resultado:$result');
    }
  }
}
