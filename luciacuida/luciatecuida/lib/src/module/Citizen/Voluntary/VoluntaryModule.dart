import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:luciatecuida/src/Model/Entity.dart';
import 'package:luciatecuida/src/Model/Generic.dart';
import 'package:luciatecuida/src/Model/PreferenceUser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:luciatecuida/src/Theme/ThemeModule.dart';
import 'package:luciatecuida/src/Util/Resource.dart' as resource;

import 'package:luciatecuida/src/Util/Util.dart';
import 'package:luciatecuida/src/Widget/GeneralWidget.dart';
import 'package:luciatecuida/src/Widget/InputField/InputFieldWidget.dart';
import 'package:luciatecuida/src/Widget/Message/Message.dart';
import 'package:luciatecuida/src/module/Citizen/Voluntary/InformationVoluntary.dart';
import 'package:luciatecuida/src/module/Settings/RoutesModule.dart';

class VoluntaryModule extends StatefulWidget {
  static final String routeName = 'voluntary';
  const VoluntaryModule({Key key}) : super(key: key);

  @override
  _VoluntaryModuleState createState() => _VoluntaryModuleState();
}

class _VoluntaryModuleState extends State<VoluntaryModule> {
  //InputDropDown tipoEntidad;
  InputDropDown tipoEspecialidad;
  InputTextField nombre;
  InputEmailField email;
  InputPhoneField telefono;
  InputTextField ci;
  InputMultilineField complmementario;
  InputUrlField facebook;
  InputUrlField twitter;
  InputUrlField paginaWeb;
  InputDropDown expedido;
  InputSexo sexo;
  InputNumberField token;

  int _valorId = 0;

  int _group = 1;
  int estado = 0;
  int _selectedRadio = 1;
  bool _save = false;
  bool esCovid = false;
    bool readOnly = false;
  File foto;
  String imagen =
      'https://res.cloudinary.com/propia/image/upload/v1590675803/xxxykvu7m2d4nwk4gaf6.jpg';

  var result;
  int valorExpedido = 60;
  int valorTipoEspecialidad = 11;
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final generic = new Generic();
  final prefs = new PreferensUser();
  Voluntary entity = new Voluntary();

  @override
  void initState() {
    super.initState();
    prefs.ultimaPagina = VoluntaryModule.routeName;
  }

  @override
  Widget build(BuildContext context) {
     print('prefs.userId es: ${prefs.userId}');

    final Voluntary entityData = ModalRoute.of(context).settings.arguments;

    if (entityData != null) {
      entity = entityData;
      _valorId = entity.idcovPersonal;
      estado = 1;
      readOnly = true;
    }

    return Scaffold(
      key: scaffoldKey,
      body: Stack(
        children: <Widget>[
          
          fondoApp(),
          
          crearFondo(context, imagen),
          _crearForm(context),
        ],
      ),
      floatingActionButton: generaFloatButtonInformationVoluntary(context),
    );
  }

  _crearIconAppImagenes() {
    return IconButton(
      icon: Icon(
        Icons.photo_size_select_actual,
        color: AppTheme.themeVino,
      ),
      onPressed: _seleccionarFoto,
    );
  }

  _crearIconAppCamara() {
    return IconButton(
      icon: Icon(
        Icons.camera_alt,
        color: AppTheme.themeVino,
      ),
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
                  Text('CARGA TU IMAGEN - AVATAR',
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
    token = InputNumberField(
        FaIcon(FontAwesomeIcons.barcode, color: AppTheme.themeVino),
        'Ingrese solo números para el token:',
        '0000',
        'Ej: 023431',
        true, readOnly);

    nombre = InputTextField(
        FaIcon(FontAwesomeIcons.userFriends, color: AppTheme.themeVino),
        'Nombre completo voluntario:',
        entity.perNombrepersonal,
        'Ingrese nombre completo',
        true);
    ci = InputTextField(
        FaIcon(FontAwesomeIcons.idCard, color: AppTheme.themeVino),
        'Documento Identidad:',
        entity.perCI,
        'Ingrese documento',
        false);
    telefono = InputPhoneField(
        FaIcon(FontAwesomeIcons.mobileAlt, color: AppTheme.themeVino),
        'Telefono de referencia',
        entity.perTelefono,
        'Ingrese teléfono',
        true);
    complmementario = InputMultilineField(
        FaIcon(FontAwesomeIcons.commentAlt, color: AppTheme.themeVino),
        'Información complementaria:',
        entity.perInformacionComplementaria,
        'Ingrese la información complementaria',
        false);
    email = InputEmailField(
        FaIcon(FontAwesomeIcons.envelopeOpen, color: AppTheme.themeVino),
        'Correo Electronico:',
        entity.perCorreo,
        'Ej: correo@gmail.com',
        'Ingrese su correo electronico',
        false);
    facebook = InputUrlField(
        FaIcon(FontAwesomeIcons.facebook, color: AppTheme.themeVino),
        'Cuenta Facebook:',
        entity.perFacebbok,
        'Ingrese su cuenta Facebook',
        false);
    twitter = InputUrlField(
        FaIcon(FontAwesomeIcons.twitter, color: AppTheme.themeVino),
        'Cuenta Twitter:',
        entity.perTwitter,
        'Ingrese su cuenta Twitter',
        false);
    paginaWeb = InputUrlField(
        FaIcon(FontAwesomeIcons.internetExplorer, color: AppTheme.themeVino),
        'Pagina Web/block:',
        entity.perPaginaWeb,
        'Ingrese su página web/bloc',
        false);

    return FadeInLeft(
      duration: Duration(milliseconds: 250),
      child: Column(
        children: <Widget>[
          SizedBox(height: 10),
          // tipoEntidad,
          token,
          _crearEspecialidad(),
          _crearEsCovid('Voluntario COVID-19'),
          nombre,
          telefono,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: ci,
              ),
              _crearExpedido(),
            ],
          ),

          Row(
            children: <Widget>[
              SizedBox(width: 23.0),
              FaIcon(FontAwesomeIcons.male, color: AppTheme.themeVino),
              SizedBox(width: 15.0),
              Text('Masculino'),
              Radio(
                value: 0,
                groupValue: _group,
                onChanged: (T) {
                  _selectedRadio = T;
                  setState(() {
                    _group = T;
                  });
                },
              ),
              Text('Femenino'),
              Radio(
                value: 1,
                groupValue: _group,
                onChanged: (T) {
                  _selectedRadio = T;
                  setState(() {
                    _group = T;
                  });
                },
              ),
            ],
          ),

          complmementario,

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              contenedorSubTitulo(
                context,
                40.0,
                'REDES-SOCIALES',
                FaIcon(FontAwesomeIcons.chromecast, color: Colors.white60),
              ),
            ],
          ),
          email,
          facebook,
          twitter,
          paginaWeb,
          divider(),
          _crearBoton(resource.save),
        ],
      ),
    );
  }

  Widget _crearExpedido() {
    return Center(
        child: FutureBuilder(
            future: generic.getAll(new GetClasificador(),
                urlGetClasificador + '53', primaryKeyGetClasifidor),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Row(
                  children: <Widget>[
                    SizedBox(width: 35.0),
                    Text('Exp.'),
                    SizedBox(width: 15.0),
                    DropdownButton(
                      icon: FaIcon(FontAwesomeIcons.sort,
                          color: AppTheme.themeVino),
                      value: valorExpedido.toString(), //valor
                      items: getDropDown(snapshot),
                      onChanged: (value) {
                        setState(() {
                          valorExpedido = int.parse(value);
                        });
                      },
                    ),
                  ],
                );
              } else {
                return CircularProgressIndicator();
              }
            }));
  }

  List<DropdownMenuItem<String>> getDropDown(AsyncSnapshot snapshot) {
    List<DropdownMenuItem<String>> lista = new List();

    for (var i = 0; i < snapshot.data.length; i++) {
      GetClasificador item = snapshot.data[i];
      lista.add(DropdownMenuItem(
        child: Text(item.nombre),
        value: item.id.toString(),
      ));
    }
    return lista;
  }

  Widget _crearEspecialidad() {
    return Center(
        child: FutureBuilder(
            future: generic.getAll(new GetClasificador(),
                urlGetClasificador + '10', primaryKeyGetClasifidor),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Row(
                  children: <Widget>[
                    SizedBox(width: 35.0),
                    Text('Especialidad'),
                    SizedBox(width: 15.0),
                    DropdownButton(
                      icon: FaIcon(FontAwesomeIcons.sort,
                          color: AppTheme.themeVino),
                      value: valorTipoEspecialidad.toString(), //valor
                      items: getDropDown(snapshot),
                      onChanged: (value) {
                        setState(() {
                          valorTipoEspecialidad = int.parse(value);
                        });
                      },
                    ),
                  ],
                );
              } else {
                return CircularProgressIndicator();
              }
            }));
  }

  Widget _crearEsCovid(String text) {
    return SwitchListTile(
      value: esCovid,
      title: Text(text),
      subtitle: Text('Habilitar opción si será voluntario.'),
      activeColor: AppTheme.themeVino,
      onChanged: (value) => setState(() {
        esCovid = value;
      }),
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
    print('prefs.userId es: ${prefs.userId}');

    entity.foto = imagen;
    entity.idaEstado =81;
    if (!formKey.currentState.validate()) return;

    formKey.currentState.save();
    setState(() {
      _save = true;
    });

print('TOKENNN : ${token.objectValue}');
    entity.idcovPersonal = _valorId;
    entity.idcovInstitucion = int.parse(token.objectValue);
    entity.idcovLogin = int.parse(prefs.userId);
    entity.idaTipopersonal = valorTipoEspecialidad;
    entity.perNombrepersonal = nombre.objectValue;
    entity.perApellido = '.';
    entity.perCorreo = email.objectValue;
    entity.perTelefono = telefono.objectValue;
    if (esCovid)
      entity.perAyudacovid = 1;
    else
      entity.perAyudacovid = 0;
    entity.perCI = ci.objectValue;
    entity.idaExtension = valorExpedido;
    entity.idaSexo = _selectedRadio;
    entity.perInformacionComplementaria = complmementario.objectValue;
    entity.perFacebbok = facebook.objectValue;
    entity.perTwitter = twitter.objectValue;
    entity.perPaginaWeb = paginaWeb.objectValue;
    entity.usuario = prefs.correoElectronico;
    entity.estadoUsuario = 81;

    final dataMap = generic.add(entity, urlAddPersonal);

    await dataMap.then((respuesta) => result = respuesta["TIPO_RESPUESTA"]);

    if (result != "-1" || result != '-2') {
      print('VLARO DEL LSIT: $result');
      final list = result.split('|');
      prefs.idInsitucion = list[0];
      prefs.idPersonal = list[1];

      if (estado == 0) {
        enviarNotificaciones(
            urlGetToken + '2/${prefs.idInsitucion}',
            'Voluntario',
            'Nuevo voluntario',
            nombre.objectValue,
            'Bienvenido al Grupo',
            prefs.nombreInstitucion);
      }
             Navigator.of(context).push(CupertinoPageRoute(
          builder: (BuildContext context) => InformationVoluntary()));
      

     

      if (result == "-1")
        scaffoldKey.currentState
            .showSnackBar(messageNOk("Error, vuelta a intentarlo"));
      if (result == "2")
        scaffoldKey.currentState
            .showSnackBar(messageNOk("Error, TOKEN INVALIDO"));

      setState(() {
        _save = false;
      });
    }
  }

  _seleccionarFoto() async => _procesarImagen(ImageSource.gallery);
  _tomarFoto() async => _procesarImagen(ImageSource.camera);

  _procesarImagen(ImageSource origen) async {
    foto = await ImagePicker.pickImage(source: origen);

    if (foto != null) {
      imagen = await generic.subirImagen(foto);
    }

    setState(() {
      entity.foto = imagen;
      print('cargadod e iagen ${entity.foto}');
    });
  }
}
