import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:luciatecuida/src/Model/Entity.dart';
import 'package:luciatecuida/src/Model/Generic.dart';
import 'package:luciatecuida/src/Model/PreferenceUser.dart';
import 'package:luciatecuida/src/Theme/ThemeModule.dart';
import 'package:luciatecuida/src/Util/Resource.dart' as resource;
import 'package:luciatecuida/src/Util/SearchDelegate/DataSearch.dart';
import 'package:luciatecuida/src/Util/Util.dart';
import 'package:luciatecuida/src/Widget/GeneralWidget.dart';
import 'package:luciatecuida/src/Widget/InputField/InputFieldWidget.dart';
import 'package:luciatecuida/src/Widget/Message/Message.dart';
import 'package:luciatecuida/src/module/Citizen/Voluntary/ListEventModule.dart';
import 'package:luciatecuida/src/module/HomePage/HomePageModule.dart';
import 'package:luciatecuida/src/module/Settings/RoutesModule.dart';

class EventVoluntaryAllModule extends StatefulWidget {
  static final String routeName = 'voluntarioz';
  const EventVoluntaryAllModule({Key key}) : super(key: key);

  @override
  _EventVoluntaryAllModuleState createState() =>
      _EventVoluntaryAllModuleState();
}

class _EventVoluntaryAllModuleState extends State<EventVoluntaryAllModule> {
  final prefs = new PreferensUser();
  final generic = new Generic();
  int page = 0;
  final List<Widget> optionPage = [EventModule(), ListEventModule()];

  void _onItemTapped(int index) {
    setState(() {
      page = index;
    });
  }

  @override
  void initState() {
    prefs.ultimaPagina = EventVoluntaryAllModule.routeName;
    page = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarOpacity: 0.7,
        iconTheme: IconThemeData(color: AppTheme.themeVino, size: 12),
        elevation: 0,
        title: Text("EVENTOS", style: kTitleAppBar),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: DataSearchVoluntary());
            },
          )
        ],
      ),
      drawer: DrawerCitizen(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: [
          BottomNavigationBarItem(
              icon: FaIcon(
                FontAwesomeIcons.userCircle,
                size: 25,
              ),
              title: Text('Eventos')),
          BottomNavigationBarItem(
              icon: FaIcon(
                FontAwesomeIcons.calendarCheck,
                size: 25,
              ),
              title: Text('Listado eventos')),
        ],
        currentIndex: page,
         unselectedItemColor: Colors.black54,
        selectedItemColor: AppTheme.themeVino,
        onTap: _onItemTapped,
      ),
      body: optionPage[page],
    );
  }
}

class EventModule extends StatefulWidget {
  static final String routeName = 'eventVoluntary';
  @override
  _EventModuleState createState() => _EventModuleState();
}

class _EventModuleState extends State<EventModule> {
  bool _save = false;
  String _fecha = '';
  TimeOfDay _time;
  var result;
  String imagen =
      'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80';
  File foto;

  TextEditingController _inputFieldDateController = new TextEditingController();
  TextEditingController _inputFieldTimeController = new TextEditingController();

  InputTextField titulo;
  InputMultilineField objetivo;
  InputMultilineField dirigidoA;
  InputTextField expositor;
  InputMultilineField ubicacion;
  InputTextField fecha;
  InputTextField hora;
  InputTextField fotoa;

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final generic = new Generic();
  final prefs = new PreferensUser();
  Evento entity = new Evento();

  @override
  void initState() {
    prefs.ultimaPagina = EventModule.routeName;
    _time = new TimeOfDay.now();
    _fecha = new DateTime.now().toString().substring(0, 10);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Evento entityData = ModalRoute.of(context).settings.arguments;

    if (entityData != null) entity = entityData;

    return Scaffold(
      key: scaffoldKey,
      body: Stack(
        children: <Widget>[
          crearFondo(context, imagen),
          _crearForm(context),
        ],
      ),
      floatingActionButton: generaFloatbuttonHome(context),
    );
  }

  _crearIconAppImagenes() {
    return IconButton(
      icon: Icon(Icons.photo_size_select_actual, color: AppTheme.themeVino,),
      onPressed: _seleccionarFoto,
    );
  }

  _crearIconAppCamara() {
    return IconButton(
      icon: Icon(Icons.camera_alt, color: AppTheme.themeVino,),
      onPressed: _tomarFoto,
    );
  }

  Widget _crearForm(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[],
            ),
            SafeArea(
              child: Container(
                height: 125.0,
              ),
            ),
            Container(
              width: size.width * 0.96,
              margin: EdgeInsets.symmetric(vertical: 0.0),
              decoration: contenedorCarretes(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text('CARGAR IMAGEN DEL EVENTO',
                      style: TextStyle(
                        color: AppTheme.themeVino,
                        fontSize: 16.0,
                      )),
                  _crearIconAppImagenes(),
                  _crearIconAppCamara(),
                ],
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Container(
              width: size.width * 0.96,
              margin: EdgeInsets.symmetric(vertical: 0.0),
              decoration: contenedorCampos(),
              child: _crearCampos(),
            ),
            copyRigth(),
          ],
        ),
      ),
    );
  }

  Widget _crearCampos() {
    titulo = InputTextField(
        FaIcon(FontAwesomeIcons.chalkboardTeacher, color: AppTheme.themeVino),
        'Nombre del evento:',
        entity.eveTitulo,
        'Nombre del Evento',
        true);
    objetivo = InputMultilineField(
        FaIcon(FontAwesomeIcons.clipboardList, color: AppTheme.themeVino),
        'Objetivo:',
        entity.eveObjetivo,
        'Objetivo del evento',
        true);
    dirigidoA = InputMultilineField(
        FaIcon(FontAwesomeIcons.handshake, color: AppTheme.themeVino),
        'Dirigido A:',
        entity.eveDirigidoA,
        'Dirigido A',
        true);
    expositor = InputTextField(
        FaIcon(FontAwesomeIcons.male, color: AppTheme.themeVino),
        'Expositor:',
        entity.eveExpositor,
        'Expositor/Disertante',
        true);
    ubicacion = InputMultilineField(
        FaIcon(FontAwesomeIcons.mapMarkedAlt, color: AppTheme.themeVino),
        'Ubicacion/enlace digital:',
        entity.eveUbicacion,
        'Ubicacion/enlace digital',
        true);
    return Column(
      children: <Widget>[
        titulo,
        objetivo,
        dirigidoA,
        expositor,
        ubicacion,
        _crearFecha('Fecha Evento'),
        _crearTime('hora'),
        divider(),
        _crearBoton(resource.save),
      ],
    );
  }

  _selectDate(BuildContext context) async {
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: new DateTime(2020, 4),
      lastDate: new DateTime(2025, 12),
      // locale: Locale('es', 'ES')
    );

    if (picked != null) {
      setState(() {
        _fecha = DateFormat("dd/MM/yyyy").format(picked);
        _inputFieldDateController.text = _fecha;
        print(_inputFieldDateController.text);
      });
    }
  }

  _selectTime(BuildContext context) async {
    TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: _time,

      builder: (BuildContext context, Widget child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child,
        );
      },
      //   locale: Locale('es', 'ES')
    );

    if (picked != null) {
      setState(() {
        _time = picked;
        _inputFieldTimeController.text = _time.hour.toString() +
            ':' +
            _time.minute
                .toString(); //TimeOfDay(hour: _time.hour, minute: _time.minute).toString();
      });
    }
  }

  Widget _crearFecha(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
      child: TextField(
        enableInteractiveSelection: false,
        controller: _inputFieldDateController,
        decoration: InputDecoration(
            // border: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(20.0)
            // ),
            hintText: 'Fecha del evento',
            labelText: 'Fecha del evento',
            //    suffixIcon: Icon(Icons.perm_contact_calendar),
            icon: FaIcon(FontAwesomeIcons.calendarAlt,
                color: AppTheme.themeVino)),
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
          _selectDate(context);
        },
      ),
    );
  }

  Widget _crearTime(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
      child: TextField(
        enableInteractiveSelection: false,
        controller: _inputFieldTimeController,
        decoration: InputDecoration(
            // border: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(20.0)
            // ),
            hintText: 'Hora del evento',
            labelText: 'Hora del evento (23:59)',
            //    suffixIcon: Icon(Icons.perm_contact_calendar),
            icon: FaIcon(FontAwesomeIcons.clock, color: AppTheme.themeVino)),
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
          _selectTime(context);
        },
      ),
    );
  }

  Widget _crearBoton(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 100.0),
      width: MediaQuery.of(context).size.width,
      child: RaisedButton.icon(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        color: AppTheme.themeVino,
        textColor: Colors.white,
        label: Text(
          text,
          style: kSubtitleStyle,
        ),
        icon: FaIcon(FontAwesomeIcons.save, color: Colors.white),
        onPressed: (_save) ? null : _submit,
      ),
    );
  }

  _submit() async {
    entity.eveFoto = imagen;

    if (!formKey.currentState.validate()) return;

    formKey.currentState.save();
    setState(() {
      _save = true;
    });

    entity.idcovEvento = 0;
    entity.idcovInstitucion = int.parse(prefs.idInsitucion);
    entity.idcovPersonal = int.parse(prefs.idPersonal);
    entity.eveTitulo = titulo.objectValue;
    entity.eveObjetivo = objetivo.objectValue;
    entity.eveDirigidoA = dirigidoA.objectValue;
    entity.eveExpositor = expositor.objectValue;
    entity.eveUbicacion = ubicacion.objectValue;
    entity.eveFecha = _inputFieldDateController.text;
    entity.eveHora = _inputFieldTimeController.text;
    entity.usuario = prefs.userId;

    final dataMap = generic.add(entity, urlAddEvento);

    await dataMap.then((respuesta) => result = respuesta["TIPO_RESPUESTA"]);
    print('resultado:$result');

    if (result == "0")
      scaffoldKey.currentState
          .showSnackBar(messageOk("Se inserto correctamente"));
    else
      scaffoldKey.currentState
          .showSnackBar(messageNOk("Error, vuelta a intentarlo"));

    setState(() {
      _save = false;
    });
  }

  _seleccionarFoto() async => _procesarImagen(ImageSource.gallery);
  _tomarFoto() async => _procesarImagen(ImageSource.camera);

  _procesarImagen(ImageSource origen) async {
    foto = await ImagePicker.pickImage(source: origen);

    if (foto != null) {
      imagen = await generic.subirImagen(foto);
    }

    setState(() {
      entity.eveFoto = imagen;
      print('cargadod e iagen ${entity.eveFoto}');
    });
  }
}
