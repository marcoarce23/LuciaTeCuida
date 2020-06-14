import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
import 'package:luciatecuida/src/module/Citizen/Entity/InformationEntity.dart';
import 'package:luciatecuida/src/module/Settings/RoutesModule.dart';

class EntityModule extends StatefulWidget {
  static final String routeName = 'entidad';
  EntityModule({Key key}) : super(key: key);

  @override
  _EntityModuleState createState() => _EntityModuleState();
}

class _EntityModuleState extends State<EntityModule> {
  InputDropDown tipoInstitucion;
  InputDropDown ubicacion;
  InputTextField nombre;
  InputPhoneField token;
  InputMultilineField direccion;
  InputPhoneField telefono;
  InputMultilineField informacion;
  InputTextField facebook;
  InputTextField twitter;
  InputUrlField paginaWeb;
  InputTextField youtube;
  InputEmailField email;

  bool _save = false;

  File foto;
  double latitud = 0.0;
  double longitud = 0.0;
  LatLng latLng = LatLng(0, 0);
  int valorInstitucion = 3;
  int valorDepartamento = 60;
  int _valorId = 0;
    int estado = 0;
  bool bandera = false;
  bool esSucursal = false;

  String imagen =
      'https://res.cloudinary.com/propia/image/upload/v1590675803/xxxykvu7m2d4nwk4gaf6.jpg';
  var result;

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final generic = new Generic();
  final prefs = new PreferensUser();
  Institucion entity = new Institucion();

  @override
  void initState() {
    prefs.ultimaPagina = EntityModule.routeName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('entro EntityModule Build: ${ModalRoute.of(context).settings.arguments}');
    final Institucion entityData = ModalRoute.of(context).settings.arguments;

    if (entityData != null) {
      entity = entityData;
      _valorId = entityData.idInstitucion;

      if(bandera ==false)
      {
            valorInstitucion = entity.tipoInstitucion;
            valorDepartamento = entity.ubicacion;
            imagen = entity.foto;
          
            if (entity.esSucursal != 0) esSucursal = true;
            else esSucursal = false;
      }
 }

    return Scaffold(
      key: scaffoldKey,
      body: Stack(
        children: <Widget>[
          crearFondo(context, imagen),
          _crearForm(context),
        ],
      ),
      floatingActionButton: generaFloatButtonInformationEntity(context),
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
                  Text('CARGAR IMAGEN - INSTITUCION',
                      style: TextStyle(
                        color: AppTheme.themeVino,
                        fontSize: 15.0,
                      )),
                  //    _crearIconAppMap(),
                  _crearIconAppImagenes(),
                  _crearIconAppCamara(),
                ],
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Container(
              width: size.width * 0.92,
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
    nombre = InputTextField(
        FaIcon(FontAwesomeIcons.city, color: AppTheme.themeVino),
        'Nombre de la institución:',
        entity.nombreInstitucion,
        'Ingrese el nombre',
        true);
    token = InputPhoneField(
        FaIcon(FontAwesomeIcons.creditCard, color: AppTheme.themeVino),
        'Ingrese el número de token:',
        entity.token,
        'Ej: 214213 - solo números',
        true);
    direccion = InputMultilineField(
        FaIcon(FontAwesomeIcons.dotCircle, color: AppTheme.themeVino),
        'Dirección/ubicacion:',
        entity.direccion,
        'Ingrese su dirección/ubicación',
        true);
    telefono = InputPhoneField(
        FaIcon(FontAwesomeIcons.mobileAlt, color: AppTheme.themeVino),
        'Telefono de referencia',
        entity.telefono,
        'Ingrese el número de referencia',
        true);
    informacion = InputMultilineField(
        FaIcon(FontAwesomeIcons.listAlt, color: AppTheme.themeVino),
        'Información complementaria:',
        entity.perInformacionComp,
        'Informacióm complementaria',
        false);
    facebook = InputTextField(
        FaIcon(FontAwesomeIcons.facebook, color: AppTheme.themeVino),
        'Cuenta Facebook:',
        entity.perFacebbok,
        'Ingrese la cuenta Facebook',
        false);
    twitter = InputTextField(
        FaIcon(FontAwesomeIcons.twitter, color: AppTheme.themeVino),
        'Cuenta Twitter:',
        entity.perTwitter,
        'Ingrese la cuenta Twitter',
        false);
    paginaWeb = InputUrlField(
        FaIcon(FontAwesomeIcons.edge, color: AppTheme.themeVino),
        'Pagina Web/block:',
        entity.perPaginaWeb,
        'Página/block oficial',
        false);
    youtube = InputTextField(
        FaIcon(FontAwesomeIcons.youtube, color: AppTheme.themeVino),
        'Cuenta YouTube:',
        entity.perYouTube,
        'Ingrese la cuenta YouTube',
        false);
    email = InputEmailField(
        FaIcon(FontAwesomeIcons.mailBulk, color: AppTheme.themeVino),
        'Correo Electronico:',
        entity.perCorreoElectronico,
        'Ingrese el correo electrónico',
        'Ingrese su correo electronico',
        false);

    return Column(
      children: <Widget>[
        _crearTipoInstitucion(),
        _crearDpto(),
        _crearSucursal('Es sucursal'),
        token,
        nombre,
        direccion,
        telefono,
        informacion,
        contenedorSubTitulo(
          context,
          40.0,
          'REDES-SOCIALES',
          FaIcon(FontAwesomeIcons.chromecast, color: Colors.white60),
        ),
        SizedBox(height: 5.0),
        facebook,
        twitter,
        paginaWeb,
        youtube,
        email,
        _crearBoton(resource.save),
      ],
    );
  }

  Widget _crearSucursal(String text) {
    return SwitchListTile(
      value: esSucursal,
      title: Text(text),
      activeColor: AppTheme.themeVino,
      onChanged: (value) => setState(() {
        esSucursal = value;
        bandera = true;
      }),
    );
  }

  List<DropdownMenuItem<String>> getDropDownDpto(AsyncSnapshot snapshot) {
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

  Widget _crearDpto() {

    return Center(
        child: FutureBuilder(
            future: generic.getAll(new GetClasificador(),
                urlGetClasificador + '53', primaryKeyGetClasifidor),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Row(
                  children: <Widget>[
                    SizedBox(width: 35.0),
                    Text('Departamento'),
                    SizedBox(width: 15.0),
                    DropdownButton(
                      icon: FaIcon(FontAwesomeIcons.map,
                          color: AppTheme.themeVino),
                      value: valorDepartamento.toString(),
                      items: getDropDownDpto(snapshot),
                      onChanged: (value) {
                        setState(() {
                          valorDepartamento = int.parse(value);
                          bandera = true;
 
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

  Widget _crearTipoInstitucion() {

    return Center(
        child: FutureBuilder(
            future: generic.getAll(new GetClasificador(),
                urlGetClasificador + '2', primaryKeyGetClasifidor),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Row(
                  children: <Widget>[
                    SizedBox(width: 35.0),
                    Text('Especialidad'),
                    SizedBox(width: 15.0),
                    DropdownButton(
                      icon: FaIcon(FontAwesomeIcons.peopleArrows,
                          color: AppTheme.themeVino),
                      value: valorInstitucion.toString(),
                      items: getDropDown(snapshot),
                      onChanged: (value) {
                        setState(() {
                          valorInstitucion = int.parse(value);
                          bandera = true;
 
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
    latLng = await getLocation().then((onvalue) => latLng = onvalue);
    entity.foto = imagen;

    if (!formKey.currentState.validate()) return;

    formKey.currentState.save();
    setState(() {
      _save = true;
    });

    entity.idInstitucion = _valorId;
    entity.insLat = latLng.latitude;
    entity.insLng = latLng.longitude;
    entity.tipoInstitucion = valorInstitucion;

    if (esSucursal)
      entity.esSucursal = 1;
    else
      entity.esSucursal = 0;
    entity.token = token.objectValue;
    entity.nombreInstitucion = nombre.objectValue;
    entity.ubicacion = valorDepartamento;
    entity.direccion = direccion.objectValue;
    entity.telefono = telefono.objectValue;
    entity.perInformacionComp = informacion.objectValue;
    entity.perFacebbok = facebook.objectValue;
    entity.perTwitter = twitter.objectValue;
    entity.perPaginaWeb = paginaWeb.objectValue;
    entity.perYouTube = youtube.objectValue;
    entity.perCorreoElectronico = email.objectValue;
    entity.usuario = prefs.correoElectronico;

    print(
        'EL VALOR DE EL ID DE LA INSTITUCION:${entity.idInstitucion.toString()}');

    final dataMap = generic.add(entity, urlAddInstitucion);
    await dataMap.then((respuesta) {
      result = respuesta["TIPO_RESPUESTA"];
      print('resultado de la oepracio:$result');
    

      if (result != "-1" || result != "-2") {
        prefs.idCreacionInsitucion = int.parse(result);
        prefs.idInsitucion = result;
        
        Navigator.of(context).push(CupertinoPageRoute(
            builder: (BuildContext context) => InformationEntityModule()));
      }
      if (result == "-1") {
        scaffoldKey.currentState
            .showSnackBar(messageNOk('Error, vuelta a intentarlo'));
      }
      if (result == "2") {
        scaffoldKey.currentState
            .showSnackBar(messageNOk("Error, El TOKEN esta siendo utilizado"));
      }

      setState(() {  _save = false; });
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
      entity.foto = imagen;
    });
  }
}
