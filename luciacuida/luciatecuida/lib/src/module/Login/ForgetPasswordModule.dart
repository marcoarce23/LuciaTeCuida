import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

import 'package:luciatecuida/src/Model/Entity.dart';
import 'package:luciatecuida/src/Model/Generic.dart';
import 'package:luciatecuida/src/Model/PreferenceUser.dart';
import 'package:luciatecuida/src/Widget/GeneralWidget.dart';
import 'package:luciatecuida/src/Widget/InputField/InputFieldWidget.dart';
import 'package:luciatecuida/src/module/Login/SignUpModule.dart';
import 'package:luciatecuida/src/module/Settings/RoutesModule.dart';

class ForgetPassword extends StatefulWidget {
  static final String routeName = 'forget';

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  bool _save = false;
  String imagen = 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80';
  File foto;
  
  final formKey = GlobalKey<FormState>();
  final generic = new Generic();
  final prefs = new PreferensUser();
  var result;

  InputEmailField correo;
  InputTextPassword contrasenia;
  InputTextPassword contrasenia2;

  LoginSigIn entity = new LoginSigIn();

  @override
  void initState() {
    prefs.ultimaPagina = ForgetPassword.routeName;
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('RESETEAR CONTRASEÑA'),
          backgroundColor: Colors.orange,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.photo_size_select_actual),
              onPressed: _seleccionarFoto,
            ),
            IconButton(
              icon: Icon(Icons.camera_alt),
              onPressed: _tomarFoto,
            ),
          ],
        ),
        body: Stack(
          children: <Widget>[
         //   crearFondoForm(context, imagen),
            _crearForm(context),
          ],
        ));
  }

  Widget _crearForm(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            SafeArea(
              child: Container(
                height: 160.0,
              ),
            ),
            Container(
              width: size.width * 0.90,
              margin: EdgeInsets.symmetric(vertical: 10.0),
              // padding: EdgeInsets.symmetric( vertical: 30.0 ),
              decoration: _crearContenedorCampos(),
              child: _crearCampos(),
            ),
            SizedBox(height: 5.0),
            _dividerOr(),
            copyRigth(),
          ],
        ),
      ),
    );
  }

  Widget _crearCampos() {
    correo = InputEmailField(
        FaIcon(FontAwesomeIcons.user, color: Colors.orange),
        'Correo electrónico',
        '',
        'Ingresar su correo electrónico',
        'ej: cuenta@correo.com', true);
    contrasenia = InputTextPassword(
        FaIcon(FontAwesomeIcons.expeditedssl, color: Colors.orange),
        'Contraseña:',
        '',
        'Ingrese su contraseña', true);

    contrasenia2 = InputTextPassword(
        FaIcon(FontAwesomeIcons.expeditedssl, color: Colors.orange),
        'Repita Contraseña:',
        '',
        'Repita contraseña', true);

    return Column(
      children: <Widget>[
        SizedBox(height: 15.0),
        Text('Cambiar la contraseña."', style: TextStyle(fontSize: 20.0)),
        correo,
        contrasenia,
        contrasenia2,
        _crearBoton('Resetear'),
      ],
    );
  }

  _crearContenedorCampos() {
    return BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.black26,
              blurRadius: 3.0,
              offset: Offset(0.0, 5.0),
              spreadRadius: 3.0)
        ]);
  }

  Widget _crearBoton(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 65.0),
      width: MediaQuery.of(context).size.width,
      child: RaisedButton.icon(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
        color: Colors.blue,
        textColor: Colors.white,
        label: Text(
          'Resetear',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        icon: Icon(Icons.check),
        onPressed: (_save) ? null : _submit,
      ),
    );
  }

  void _submit() async {
    if (!formKey.currentState.validate()) return;

    formKey.currentState.save();
    setState(() {
      _save = true;
    });

    if (contrasenia.objectValue != contrasenia2.objectValue) {
      entity.idUsuario = prefs.userId;
      entity.password = contrasenia.objectValue;

      final dataMap = generic.add(entity, urlAddSignIn);

      await dataMap.then((x) => result = x["TIPO_RESPUESTA"]);
      if (result == '0')
        Navigator.of(context).push(CupertinoPageRoute(
            builder: (BuildContext context) => SignUpModule()));
      else
        Navigator.of(context).push(CupertinoPageRoute(
            builder: (BuildContext context) => ForgetPassword()));
    } else {
      print('las contraseñas no coinciden');
    }
    setState(() {
      _save = false;
    });
  }

  Widget _dividerOr() {
    return Container(
      //   margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          SizedBox(height: 5.0),
          Text('Sabías Que ?'),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _seleccionarFoto() async {
    _procesarImagen(ImageSource.gallery);
  }

  _tomarFoto() async {
    _procesarImagen(ImageSource.camera);
  }

  _procesarImagen(ImageSource origen) async {
    foto = await ImagePicker.pickImage(source: origen);

    if (foto != null) {
      entity.avatar = imagen;
    }
    setState(() {});
  }
}
