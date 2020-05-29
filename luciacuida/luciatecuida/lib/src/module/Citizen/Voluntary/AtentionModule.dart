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
  Atencion entity = new Atencion();

  @override
  void initState() {
    prefs.ultimaPagina = AtentionModule.routeName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: scaffoldKey,
      drawer: DrawerCitizen(),
      body: Stack(
        children: <Widget>[ fondoApp(),_crearForm(context),],
      ),
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
            informacionProfesional(context),
            SizedBox(height: 5.0),
          contenedorTitulo(
              context,
              40.0,
              'REGISTRO DE ATENCIÓN',
              FaIcon(FontAwesomeIcons.calendarAlt, color: AppTheme.themeVino),
            ),
       
            SizedBox(height: 5.0),
            Container(
              width: size.width * 0.98,
              margin: EdgeInsets.symmetric(vertical: 0.0),
              decoration: contenedorCampos(),
              child: _crearCampos(),
            ),

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
        color: Color.fromRGBO(165, 5, 5, 0.7),
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
     print('valor del prefsss. ${prefs.userId}');
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

    entity.idInstitucion = int.parse(prefs.idInsitucion);
    entity.idInstitucionPersonal = int.parse(prefs.idPersonal);
    entity.perLunes = intLunes;
    entity.perMartes = intMartes;
    entity.perMiercoles = intMiercoles;
    entity.perJueves = intJueves;
    entity.perViernes = intViernes;
    entity.perSabado = intaSabado;
    entity.perDomingo = intDomingo;
    entity.perLunesH = '-1';
    entity.perMartesH = '-1';
    entity.perMiercolesH = '-1';
    entity.perJuevesH = '-1';
    entity.perViernesH = '-1';
    entity.perSabadoH = '-1';
    entity.perDomingoH = '-1';
    entity.usuario = prefs.userId;

print('valores: $entity');
    final dataMap = generic.add(entity, urlAddAtencion);

    await dataMap.then((respuesta) => result = respuesta["TIPO_RESPUESTA"]);

    if (result == "0")
      scaffoldKey.currentState
          .showSnackBar(messageOk("Se insertó correctamente"));
    else
      scaffoldKey.currentState
          .showSnackBar(messageNOk("Error, vuelta a intentarlo"));

    setState(() {
      _save = false;
    });
  }
  }
}
