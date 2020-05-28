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
import 'package:luciatecuida/src/module/Settings/RoutesModule.dart';

class AtentionEntityModule extends StatefulWidget {
  static final String routeName = 'AtentionEntity';
  AtentionEntityModule({Key key}) : super(key: key);

  @override
  _AtentionEntityModuleState createState() => _AtentionEntityModuleState();
}

class _AtentionEntityModuleState extends State<AtentionEntityModule> {
  bool _save = false;

  InputCheckBox lunes;
  InputCheckBox martes;
  InputCheckBox miercoles;
  InputCheckBox jueves;
  InputCheckBox viernes;
  InputCheckBox sabado;
  InputCheckBox domingo;

  InputTextField lunesH;
  InputTextField martesH;
  InputTextField miercolesH;
  InputTextField juevesH;
  InputTextField viernesH;
  InputTextField sabadoH;
  InputTextField domingoH;

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
  int intSabado = 0;
  int intDomingo = 0;
  var result;

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final generic = new Generic();
  final prefs = new PreferensUser();
  Atencion entity = new Atencion();

  @override
  void initState() {
    prefs.ultimaPagina = AtentionEntityModule.routeName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Stack(
        children: <Widget>[
          _crearForm(context),
        ],
      ),
    );
  }

  Widget informacionProfesional(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.all(15.0),
        width: MediaQuery.of(context).size.width - 20,
        decoration: contenedorCabecera(),
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

  Column crearIconoProfesional(icon, title) {
    return Column(
      children: <Widget>[
        Icon(
          icon,
          size: 28,
          color: Colors.black,
        ),
        SizedBox(
          height: 8.0,
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w300,
            color: Colors.black,
          ),
        ),
      ],
    );
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
              width: size.width * 0.95,
              margin: EdgeInsets.symmetric(vertical: 0.0),
              decoration: contenedorCampos(),
              child: _crearCampos(),
            ),
            divider(),
            Text(
              'IMPORTANTE:',
              style: kTitleCardStyle,
              textAlign: TextAlign.left,
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
                Text(
                  'Definir si la atención se realizará el fin de semana.',
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
                Text(
                  'Se recomienda que los días asignados sean \n cumplidos  por el voluntario.',
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
    lunes = InputCheckBox('Lunes', selectLunes);
    martes = InputCheckBox('Martes', selectMartes);
    miercoles = InputCheckBox('Miércoles', selectMiercoles);
    jueves = InputCheckBox('Jueves', selectJueves);
    viernes = InputCheckBox('Viernes', selectViernes);
    sabado = InputCheckBox('Sábado', selectSabado);
    domingo = InputCheckBox('Domingo', selectDomingo);

    lunesH = InputTextField(
        FaIcon(FontAwesomeIcons.clock, color: AppTheme.themeVino,),
        'Atención',
        '',
        'Ej: 08:00  a 13:30',
        false);
    martesH = InputTextField(
        FaIcon(FontAwesomeIcons.clock, color: AppTheme.themeVino,),
        'Atención',
        '',
        'Ej: 08:00  a 13:30',
        false);
    miercolesH = InputTextField(
        FaIcon(FontAwesomeIcons.clock, color: AppTheme.themeVino,),
        'Atención',
        '',
        'Ej: 08:00  a 13:30',
        false);
    juevesH = InputTextField(
        FaIcon(FontAwesomeIcons.clock, color: AppTheme.themeVino,),
        'Atención',
        '',
        'Ej: 08:00  a 13:30',
        false);
    viernesH = InputTextField(
        FaIcon(FontAwesomeIcons.clock, color: AppTheme.themeVino,),
        'Atención',
        '',
        'Ej: 08:00  a 13:30',
        false);
    sabadoH = InputTextField(
        FaIcon(FontAwesomeIcons.clock, color: AppTheme.themeVino,),
        'Atención',
        '',
        'Ej: 08:00  a 13:30',
        false);
    domingoH = InputTextField(
        FaIcon(FontAwesomeIcons.clock, color: AppTheme.themeVino,),
        'Atención',
        '',
        'Ej: 08:00  a 13:30',
        false);

    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: lunesH,
            ),
            Expanded(
              child: lunes,
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: martesH,
            ),
            Expanded(
              child: martes,
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: miercolesH,
            ),
            Expanded(
              child: miercoles,
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: juevesH,
            ),
            Expanded(
              child: jueves,
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: viernesH,
            ),
            Expanded(
              child: viernes,
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: sabadoH,
            ),
            Expanded(
              child: sabado,
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: domingoH,
            ),
            Expanded(
              child: domingo,
            ),
          ],
        ),
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
      intSabado = 1;
      selectSabado = true;
    }
    if (domingo.objectValue == true) {
      intDomingo = 1;
      selectDomingo = true;
    }

    entity.idInstitucion = int.parse(prefs.idInsitucion);
    entity.idInstitucionPersonal = -1;
    entity.perLunes = intLunes;
    entity.perMartes = intMartes;
    entity.perMiercoles = intMiercoles;
    entity.perJueves = intJueves;
    entity.perViernes = intViernes;
    entity.perSabado = intSabado;
    entity.perDomingo = intDomingo;
    entity.perLunesH = lunesH.objectValue;
    entity.perMartesH = martesH.objectValue;
    entity.perMiercolesH = miercolesH.objectValue;
    entity.perJuevesH = juevesH.objectValue;
    entity.perViernesH = viernesH.objectValue;
    entity.perSabadoH = sabadoH.objectValue;
    entity.perDomingoH = domingoH.objectValue;
    entity.usuario = prefs.correoElectronico;

    final dataMap = generic.add(entity, urlAddAtencionInstitucion);

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
