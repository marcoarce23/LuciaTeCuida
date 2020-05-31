import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  int _group = 1;
  int _selectedRadio = 1;

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
//         bottomNavigationBar: _bottomNavigationBar(context)),

          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
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
                Row(
                  children: <Widget>[
                    SizedBox(width: 23.0),
                    //   FaIcon(FontAwesomeIcons.male, color: AppTheme.themeVino),
                    SizedBox(width: 15.0),
                    Text('Consulta Covid'),
                    Radio(
                      value: 65,
                      groupValue: _group,
                      onChanged: (T) {
                        print(T);
                        _selectedRadio = T;
                        setState(() {
                          _group = T;
                        });
                      },
                    ),
                    Text('Consulta Médica'),
                    Radio(
                      value: 64,
                      groupValue: _group,
                      onChanged: (T) {
                        print(T);
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
                    SizedBox(width: 23.0),
                    // FaIcon(FontAwesomeIcons.male, color: AppTheme.themeVino),
                    SizedBox(width: 15.0),
                    Text('Compra medicmentos-alimentos'),
                    Radio(
                      value: 66,
                      groupValue: _group,
                      onChanged: (T) {
                        print(T);
                        _selectedRadio = T;
                        setState(() {
                          _group = T;
                        });
                      },
                    ),
                    Text('Bonos-Otros servicios'),
                    Radio(
                      value: 77,
                      groupValue: _group,
                      onChanged: (T) {
                        print(T);
                        _selectedRadio = T;
                        setState(() {
                          _group = T;
                        });
                      },
                    ),
                  ],
                ),
                ButtonPanic(
                  titulo: "CONSULTA COVID",
                  tipoBoton: _selectedRadio.toString(),
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
  final String tipoBoton;

  const ButtonPanic({
    Key key,
    this.titulo,
    this.tipoBoton,
  }) : super(key: key);

  @override
  _ButtonPanic createState() => _ButtonPanic();
}

class _ButtonPanic extends State<ButtonPanic> {
  BotonPanico botonPanico = new BotonPanico();
  final generic = new Generic();

  bool checkMuyAlto = false;
  bool checkAlto = false;
  bool checkMedio = false;

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
    botonPanico.idaCatalogo = int.parse(widget.tipoBoton);
    //botonPanico.botFecha=DateTime.now();

    String fechaNotificacion = "-/-/- --:--";

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
            margin: EdgeInsets.only(top: 5, left: 15, right: 15),
            child: Padding(
                padding: const EdgeInsets.only(
                  top: 0.0,
                ),
                child: ListTile(
                  title: Container(
                    padding: EdgeInsets.only(top: 1, left: 5),
                    //height: 20.0,
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(widget.titulo, style: textStyle),
                          ],
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(" Selecione su Prioridad:",
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
                                    print(value);

                                    botonPanico.idaPrioridad = 68;
                                    print(botonPanico.idaPrioridad);
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
                                    print(value);
                                    botonPanico.idaPrioridad = 69;
                                    print(botonPanico.idaPrioridad);

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
                                    print(value);
                                    botonPanico.idaPrioridad = 70;
                                    print(botonPanico.idaPrioridad);

                                    checkMuyAlto = false;
                                    checkAlto = false;
                                    checkMedio = true;
                                  });
                                })
                          ],
                        ),
                        TextFormField(
                          style: TextStyle(color: Colors.black, fontSize: 13),
                          textCapitalization: TextCapitalization.sentences,
                          enableSuggestions: true,
                          maxLength: 100,
                          autocorrect: true,
                          autovalidate: false,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            focusColor: Colors.blue,
                            labelStyle:
                                TextStyle(fontSize: 14, color: Colors.black),
                            labelText: "Ingrese Detalle/Inquietud",
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
                          maxLength: 15,
                          style: TextStyle(color: Colors.black, fontSize: 13),
                          decoration: InputDecoration(
                            labelStyle:
                                TextStyle(fontSize: 14, color: Colors.black),
                            labelText: "Nro  telefono",
                            border: InputBorder.none,
                            hintText:
                                'Ingrese el número de telefono para comunicarnos',
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
                              _submit();
                              setState(() {
                                fechaNotificacion =
                                    DateFormat("dd/MM/yyyy HH:mm")
                                        .format(DateTime.now());
                              });
                            },
                            child: Icon(Icons.pan_tool, color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                ))),
      ],
    );
  }

  _submit() async {
    print(botonPanico);
    LatLng latLng;
    latLng = await getLocation().then((onvalue) => latLng = onvalue);

    print(' el valorrr.... ${prefs.userId}');
    botonPanico.idLogin = int.parse(prefs.userId);
    botonPanico.botCordenadalat = latLng.latitude;
    botonPanico.botCordenadalon = latLng.longitude;
    final dataMap = generic.add(botonPanico, urlAddBotonPanico);
    var result;
    await dataMap.then((respuesta) => result = respuesta["TIPO_RESPUESTA"]);
    if (result == "0") {
      Scaffold.of(context).showSnackBar(messageOk(
          "Se registro correctamente, a las ${DateFormat("HH:mm").format(DateTime.now())} del ${DateFormat("dd/MM/yyyy").format(DateTime.now())}"));
    } else {
      Scaffold.of(context)
          .showSnackBar(messageNOk("Ocurrio un error inseperado"));
    }

    print('resultado:$result');
  }
}
