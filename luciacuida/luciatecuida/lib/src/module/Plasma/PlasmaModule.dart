import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
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
import 'package:luciatecuida/src/module/Plasma/ListPlasmaModule.dart';
import 'package:luciatecuida/src/module/Settings/RoutesModule.dart';

class PlasmaAllModule extends StatefulWidget {
  static final String routeName = 'plasmaAll';
  const PlasmaAllModule({Key key}) : super(key: key);

  @override
  _PlasmaAllModuleState createState() => _PlasmaAllModuleState();
}

class _PlasmaAllModuleState extends State<PlasmaAllModule> {
  final prefs = new PreferensUser();
  final generic = new Generic();
  int page = 0;

  final List<Widget> optionPage = [PlasmaModule(), ListPlasmaModule()];

  void _onItemTapped(int index) {
    setState(() {
      page = index;
    });
  }

  @override
  void initState() {
    prefs.ultimaPagina = PlasmaAllModule.routeName;
    page = 0;
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
          title: Text("BANCO DE PLASMA", style: kTitleAppBar),
        ),
        drawer: DrawerCitizen(),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          items: [
            BottomNavigationBarItem(
                icon: FaIcon(
                  FontAwesomeIcons.userMd,
                  size: 25,
                ),
                title: Text('Registro')),
            BottomNavigationBarItem(
                icon: FaIcon(
                  FontAwesomeIcons.pumpMedical,
                  size: 25,
                ),
                title: Text('Banco de Plasma')),
          ],
          currentIndex: page,
          unselectedItemColor: Colors.black54,
          selectedItemColor: AppTheme.themeVino,
          onTap: _onItemTapped,
        ),
        body: optionPage[page],
      ),
    );
  }
}

class PlasmaModule extends StatefulWidget {
  static final String routeName = 'plasma';
  PlasmaModule({Key key}) : super(key: key);

  @override
  _PlasmaModuleState createState() => _PlasmaModuleState();
}

class _PlasmaModuleState extends State<PlasmaModule> {
  InputTextField nombre;
  InputPhoneField telefono;
  InputTextField edad;
  InputMultilineField ubicacion;
  InputDropDown tipoAyuda;
  bool esRecuperado = false;
  bool _save = false;
  int valorTipoSangre = 118;
  int valorTipoFactor = 123;
  var result;
  var list;
  File foto;
  String imagen =
      'http://res.cloudinary.com/propia/image/upload/v1592167496/djsbl74vjdwtso6zrst7.jpg';

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final generic = new Generic();
  final prefs = new PreferensUser();
  BancoPlasma bancoPlasma = new BancoPlasma();

  @override
  void initState() {
    prefs.ultimaPagina = PlasmaModule.routeName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final BancoPlasma bancoPlasmaData =
        ModalRoute.of(context).settings.arguments;

    if (bancoPlasmaData != null) bancoPlasma = bancoPlasmaData;

    return Scaffold(
      key: scaffoldKey,
      body: Stack(
        children: <Widget>[
          fondoApp(),
          crearFondo(context, imagen),
          _crearForm(),
        ],
      ),
      floatingActionButton: generaFloatbuttonHome(context),
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

  Widget _crearForm() {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            // contenedorTitulo(
            //   context,
            //   40.0,
            //   'REGISTRO DE DATOS',
            //   FaIcon(FontAwesomeIcons.plusSquare, color: AppTheme.themeVino),
            // ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[],
            ),
            SafeArea(
              child: Container(
                height: 140.0,
              ),
            ),

            //     SizedBox(height: 7.0),

            Container(
              width: size.width * 0.96,
              margin: EdgeInsets.symmetric(vertical: 0.0),
              decoration: contenedorCarretes(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text('CARGA FOTO DE LA PRUEBA',
                      style: TextStyle(
                        color: AppTheme.themeVino,
                        fontSize: 16.0,
                      )),
                  _crearIconAppImagenes(),
                  _crearIconAppCamara(),
                ],
              ),
            ),
            SizedBox(height: 7.0),
            // SizedBox(
            //   height: 5.0,
            // ),

            // AutoSizeText(
            //   'Estamos en el Departamento de : ${obtenerDepartamento(prefs.idDepartamento)} ',
            //   style: kSubTitleCardStyle,
            //   maxLines: 2,
            //   minFontSize: 15.0,
            //   overflow: TextOverflow.ellipsis,
            //   textAlign: TextAlign.justify,
            // ),

            Container(
              width: size.width * 0.93,
              margin: EdgeInsets.symmetric(vertical: 0.0),
              decoration: contenedorCampos(),
              child: _crearCampos(context),
            ),
            copyRigth(),
          ],
        ),
      ),
    );
  }

  Widget _crearCampos(BuildContext context) {
    nombre = InputTextField(
        FaIcon(FontAwesomeIcons.pumpMedical, color: AppTheme.themeVino),
        '(*) Nombre de la persona',
        bancoPlasma.nombrePersona,
        'Ingrese el nombre de la persona',
        true);
    edad = InputTextField(
        FaIcon(FontAwesomeIcons.male, color: AppTheme.themeVino),
        '(*) Edad de la persona',
        bancoPlasma.edad == null ? '0' : bancoPlasma.edad.toString(),
        'Registre la edad',
        true);
    telefono = InputPhoneField(
        FaIcon(FontAwesomeIcons.viber, color: AppTheme.themeVino),
        '(*) Teléfono de contacto',
        bancoPlasma.telefono,
        'Número telefónico de contacto',
        true,
        10);
    ubicacion = InputMultilineField(
        FaIcon(FontAwesomeIcons.home, color: AppTheme.themeVino),
        '(*) Dirección/domicilio',
        bancoPlasma.direccion,
        'Dirección/domicilio ',
        true);

    return Column(
      children: <Widget>[
        Text(
          '(*) Campos obligatorios. ',
          style: kCamposTitleStyle,
          textAlign: TextAlign.left,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0),
          child: AutoSizeText(
            '- Nota: No puede ser donante si usted tiene: (Hepatitis, VIH, Tuberculósis, chagas).',
            style: knoteTitleCardStyle,
            maxLines: 3,
            minFontSize: 13.0,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: 5.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0),
          child: AutoSizeText(
            '- Nota: No puede ser donante si usted tiene enfernedad de base: (Diabétes, Presion alta, Cardiopatias).',
            style: knoteTitleCardStyle,
            maxLines: 3,
            minFontSize: 13.0,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.justify,
          ),
        ),

         

        SizedBox(height: 7.0),
        nombre,
        edad,
        telefono,
        ubicacion,
        _crearEsRecuperado('Paciente Recuperado COVID-19'),
        _crearTipoSangre(),
        _crearTipoFactor(),
        divider(),
        _crearBoton(resource.save),
        Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14.0),
                  child: AutoSizeText(
                      'Nota: Para ponerse en contacto con el grupo de whatsapp de donantes de plasma presiona en:',
                      style: knoteTitleCardStyle,
                      maxLines: 3,
                    minFontSize: 13.0,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.justify,
                      ),
                ),

                FlatButton(
                  color: Colors.green,
                  textColor: Colors.white,
                  disabledColor: Colors.grey,
                  disabledTextColor: Colors.black,
                  splashColor: Colors.white,
                  onPressed: () {
                    openWeb('https://chat.whatsapp.com/GULRUC5BCdF7zwenMxLnDy');
                  },
                  child: Text("WhatsApp Donantes"),
                ),
      ],
    );
  }

  Widget _crearEsRecuperado(String text) {
    return SwitchListTile(
      value: esRecuperado,
      title: Text(text),
      subtitle: Text('Si cuenta con su segunda prueba habilitar la opción.'),
      activeColor: AppTheme.themeVino,
      onChanged: (value) => setState(() {
        esRecuperado = value;
      }),
    );
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

  Widget _crearTipoSangre() {
    return Center(
        child: FutureBuilder(
            future: generic.getAll(new GetClasificador(),
                urlGetClasificador + '117', primaryKeyGetClasifidor),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Row(
                  children: <Widget>[
                    SizedBox(width: 35.0),
                    Text('Tipo de sangre:'),
                    SizedBox(width: 15.0),
                    DropdownButton(
                      icon: FaIcon(FontAwesomeIcons.sort,
                          color: AppTheme.themeVino),
                      value: valorTipoSangre.toString(),
                      items: getDropDown(snapshot),
                      onChanged: (value) {
                        setState(() {
                          valorTipoSangre = int.parse(value);

                          //print('valor combo ingresado ENTITY MEDICINA: $valorTipoAyuda y valueeee: $value');
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

  Widget _crearTipoFactor() {
    return Center(
        child: FutureBuilder(
            future: generic.getAll(new GetClasificador(),
                urlGetClasificador + '121', primaryKeyGetClasifidor),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Row(
                  children: <Widget>[
                    SizedBox(width: 35.0),
                    Text('Tipo de factor:'),
                    SizedBox(width: 15.0),
                    DropdownButton(
                      icon: FaIcon(FontAwesomeIcons.sort,
                          color: AppTheme.themeVino),
                      value: valorTipoFactor.toString(),
                      items: getDropDown(snapshot),
                      onChanged: (value) {
                        setState(() {
                          valorTipoFactor = int.parse(value);

                          //print('valor combo ingresado ENTITY MEDICINA: $valorTipoAyuda y valueeee: $value');
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
    bancoPlasma.foto = imagen;
    LatLng latLng;
    latLng = await getLocation().then((onvalue) => latLng = onvalue);

    if (!formKey.currentState.validate()) return;

    formKey.currentState.save();
    setState(() {
      _save = true;
    });

    if (esRecuperado)
      bancoPlasma.esRecuperado = 1;
    else
      bancoPlasma.esRecuperado = 0;

    bancoPlasma.idCovBancoPlasma = 0;
    bancoPlasma.nombrePersona = nombre.objectValue;
    bancoPlasma.edad = int.parse(edad.objectValue);
    bancoPlasma.telefono = telefono.objectValue;
    bancoPlasma.direccion = ubicacion.objectValue;
    bancoPlasma.idaTipoSangre = valorTipoSangre;
    bancoPlasma.idaTipoFactor = valorTipoFactor;
    bancoPlasma.departamento = prefs.idDepartamento;
    bancoPlasma.usuario = prefs.correoElectronico;
    bancoPlasma.latitud = latLng.latitude;
    bancoPlasma.longitud = latLng.longitude;
    print('valor plasma: $bancoPlasma');

    final dataMap = generic.add(bancoPlasma, urlAddPlasma);
    print('valor plasma: $dataMap');
    await dataMap.then((respuesta) {
      result = respuesta["TIPO_RESPUESTA"];

      if (result == "0") {
        scaffoldKey.currentState
            .showSnackBar(messageOk("Se registro correctamente."));

        // enviarNotificaciones(
        //     urlGetToken + '4/${prefs.idInsitucion}',
        //     'ayudaPersona',
        //     'ayudaPersona',
        //     nombre.objectValue,
        //     'Teléfono de contacto',
        //     telefono.objectValue);
      } else
        scaffoldKey.currentState
            .showSnackBar(messageNOk("Error, vuelta a intentarlo"));

      setState(() {
        _save = false;
      });
    });
  }

  List<DropdownMenuItem<String>> getipoAy(AsyncSnapshot snapshot) {
    List<DropdownMenuItem<String>> lista = new List();

    for (var i = 0; i < snapshot.data.length; i++) {
      GetClasificador item = snapshot.data[i];
      lista.add(DropdownMenuItem(
        child: Text(item.nombre),
        value: item.id.toString(), //tipoPrioridad.id,
      ));
    }
    return lista;
  }

  _seleccionarFoto() async => _procesarImagen(ImageSource.gallery);
  _tomarFoto() async => _procesarImagen(ImageSource.camera);

  _procesarImagen(ImageSource origen) async {
    foto = await ImagePicker.pickImage(source: origen);

    if (foto != null) {
      imagen = await generic.subirImagen(foto);
    }

    setState(() {
      bancoPlasma.foto = imagen;
      //print('cargadod e iagen ${entity.foto}');
    });
  }
}
