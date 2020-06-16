import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:luciatecuida/src/Model/Entity.dart';
import 'package:luciatecuida/src/Model/Generic.dart';
import 'package:luciatecuida/src/Model/PreferenceUser.dart';
import 'package:luciatecuida/src/Theme/ThemeModule.dart';
import 'package:luciatecuida/src/Util/Resource.dart' as resource;
import 'package:luciatecuida/src/Util/Util.dart';
import 'package:luciatecuida/src/Widget/GeneralWidget.dart';
import 'package:luciatecuida/src/Widget/InputField/InputFieldWidget.dart';
import 'package:luciatecuida/src/Widget/Message/Message.dart';
import 'package:luciatecuida/src/module/Citizen/Voluntary/InformationVoluntary.dart';
import 'package:luciatecuida/src/module/HomePage/HomePageModule.dart';
import 'package:luciatecuida/src/module/Settings/RoutesModule.dart';

class AtentionModule extends StatefulWidget {
  static final String routeName = 'atentionVoluntary';
  @override
  _AtentionModuleState createState() => _AtentionModuleState();
}

class _AtentionModuleState extends State<AtentionModule> {
  InputCheckBox lunes;
  InputCheckBox martes;
  InputCheckBox miercoles;
  InputCheckBox jueves;
  InputCheckBox viernes;
  InputCheckBox sabado;
  InputCheckBox domingo;

  bool selectLunes = false;
  bool selectMartes = false;
  bool selectMiercoles = false;
  bool selectJueves = false;
  bool selectViernes = false;
  bool selectSabado = false;
  bool selectDomingo = false;

  int intLunes = 0;
  int intMartes = 0;
  int intMiercoles = 0;
  int intJueves = 0;
  int intViernes = 0;
  int intaSabado = 0;
  int intDomingo = 0;

  bool _save = false;
  var result;

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final generic = new Generic();
  final prefs = new PreferensUser();
  Voluntary entity = new Voluntary();
  VoluntarioAtencion entityAtencion = new  VoluntarioAtencion();

int _valorId = 0;
  bool bandera = false;

  @override
  void initState() {
    prefs.ultimaPagina = AtentionModule.routeName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

     final Voluntary entityData = ModalRoute.of(context).settings.arguments;

    if (entityData != null) {
       entity = entityData;
       if(entity.lunes == 1) selectLunes = true; 
     if(entity.martes == 1) selectMartes = true; 
     if(entity.miercoles == 1) selectMiercoles = true; 
     if(entity.jueves == 1) selectJueves= true; 
     if(entity.viernes == 1) selectViernes = true; 
     if(entity.sabado == 1) selectSabado = true; 
     if(entity.domingo == 1) selectDomingo = true; 
 
    }

    return Scaffold(
      key: scaffoldKey,
      drawer: DrawerCitizen(),
      body: Stack(
        children: <Widget>[ fondoApp(),_crearForm(context),],
      ),
      floatingActionButton: generaFloatButtonInformationVoluntary(context),
    );
  }

  Widget informacionProfesional(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.all(15.0),
        width: MediaQuery.of(context).size.width - 20,
        decoration: boxDecorationList(),//contenedorCabecera(),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                imagenProfesional(),
                SizedBox(width: 15.0),
                cabeceraInformativa(),
              ],
            ),
            divider(),
          ],
        ),
      ),
    );
  }

  ImageOvalNetwork imagenProfesional() {
    return ImageOvalNetwork(
        imageNetworkUrl: prefs.avatarImagen, sizeImage: Size.fromWidth(40));
  }

  Widget _crearForm(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            SizedBox(height: 20.0),
             contenedorTitulo(
              context,
              40.0,
              'REGISTRO DE ATENCIÓN',
              FaIcon(FontAwesomeIcons.calendarAlt, color: AppTheme.themeVino),
            ),
            SizedBox(height: 7.0),
            informacionProfesional(context),
            SizedBox(height: 5.0),

            Container(
              width: size.width * 0.98,
              margin: EdgeInsets.symmetric(vertical: 0.0),
              decoration: contenedorCampos(),
              child: _crearCampos(),
            ),
SizedBox(height: 15.0),
            Row(
              
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'IMPORTANTE:',
                  style: kTitleCardStyle,
                  textAlign: TextAlign.left,
                ),
              ],
            ),
            SizedBox(height: 15.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Seleccionar los días de atención',
                  style: kSubTitleCardStyle,
                  textAlign: TextAlign.center,
                ),
                SizedBox(width: 15.0),
                FaIcon(
                  FontAwesomeIcons.calendarCheck,
                  color: AppTheme.themeVino,
                  size: 15,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 10,
                ),
                Text('Definir si la atención se realizará fin de semana.',
                  style: kSubTitleCardStyle,
                  textAlign: TextAlign.center,
                ),
                SizedBox(width: 10.0),
                FaIcon(
                  FontAwesomeIcons.calendarCheck,
                  color: AppTheme.themeVino,
                  size: 15,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 10,
                ),
                Text('Se recomienda que los días asignados sean \n cumplidos  por el voluntario.',
                  style: kSubTitleCardStyle,
                  textAlign: TextAlign.center,
                ),
                SizedBox(width: 15.0),
                FaIcon(
                  FontAwesomeIcons.calendarCheck,
                  color: AppTheme.themeVino,
                  size: 15,
                ),
              ],
            ),
            copyRigth(),
          ],
        ),
      ),
    );
  }

  Widget _crearCampos() {
    lunes = InputCheckBox('Lun', selectLunes);
    martes = InputCheckBox('Mar', selectMartes);
    miercoles = InputCheckBox('Mie', selectMiercoles);
    jueves = InputCheckBox('Jue', selectJueves);
    viernes = InputCheckBox('Vie', selectViernes);
    sabado = InputCheckBox('Sab', selectSabado);
    domingo = InputCheckBox('(*) Domingo', selectDomingo);

    return Column(
      children: <Widget>[
        divider(),
        Row(
          children: <Widget>[
            Expanded(
              child: lunes,
            ),
            Expanded(
              child: martes,
            ),
            Expanded(
              child: miercoles,
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: jueves,
            ),
            Expanded(
              child: viernes,
            ),
            Expanded(
              child: sabado,
            ),
          ],
        ),
        domingo,
        divider(),
        _crearBoton(resource.save),
      ],
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
          style: kBotontitleStyle,
        ),
        icon: FaIcon(FontAwesomeIcons.checkCircle, color: Colors.white),
        onPressed: (_save) ? null : _submit,
      ),
    );
  }

  _submit() async {
     //print('valor del prefsss. ${prefs.userId}');
    if (prefs.userId == '-1')
      scaffoldKey.currentState.showSnackBar(messageNOk(
          "Para registrar una Atención debe registrar su Institución"));
    else {
    if (!formKey.currentState.validate()) return;

    formKey.currentState.save();
    setState(() {
      _save = true;
    });

    if (lunes.objectValue == true) {
      intLunes = 1;
      selectLunes = true;
    }
    if (martes.objectValue == true) {
      intMartes = 1;
      selectMartes = true;
    }
    if (miercoles.objectValue == true) {
      intMiercoles = 1;
      selectMiercoles = true;
    }
    if (jueves.objectValue == true) {
      intJueves = 1;
      selectJueves = true;
    }
    if (viernes.objectValue == true) {
      intViernes = 1;
      selectViernes = true;
    }
    if (sabado.objectValue == true) {
      intaSabado = 1;
      selectSabado = true;
    }
    if (domingo.objectValue == true) {
      intDomingo = 1;
      selectDomingo = true;
    }

//print(' intLunes; $intLunes intMartes $intMartes');

    entityAtencion.idCovAtencion = _valorId;
    entityAtencion.idCovEntityPersonal = int.parse(prefs.idPersonal);
    entityAtencion.perLunes = intLunes;
    entityAtencion.perMartes = intMartes;
    entityAtencion.perMiercoles = intMiercoles;
    entityAtencion.perJueves = intJueves;
    entityAtencion.perViernes = intViernes;
    entityAtencion.perSabado = intaSabado;
    entityAtencion.perDomingo = intDomingo;
    // entityAtencion.perLunesH = '-1';
    // entityAtencion.perMartesH = '-1';
    // entityAtencion.perMiercolesH = '-1';
    // entityAtencion.perJuevesH = '-1';
    // entityAtencion.perViernesH = '-1';
    // entityAtencion.perSabadoH = '-1';
    // entityAtencion.perDomingoH = '-1';
    entityAtencion.usuario = prefs.correoElectronico;


    final dataMap = generic.add(entityAtencion, urlAddAtencion);

    await dataMap.then((respuesta) 
    {
      result = respuesta["TIPO_RESPUESTA"];

    if (result == "0"){
     
    
    Navigator.of(context).push(CupertinoPageRoute(
            builder: (BuildContext context) => InformationVoluntary()));
    }
    else
      scaffoldKey.currentState
          .showSnackBar(messageNOk("Error, vuelta a intentarlo"));

    setState(() {
      _save = false;
    });
  });
  }
}
}
