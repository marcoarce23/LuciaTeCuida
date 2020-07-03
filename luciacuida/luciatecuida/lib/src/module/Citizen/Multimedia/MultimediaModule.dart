import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import 'package:luciatecuida/src/module/Citizen/Multimedia/ListMultimediaModule.dart';
import 'package:luciatecuida/src/module/HomePage/HomePageModule.dart';
import 'package:luciatecuida/src/module/Settings/RoutesModule.dart';
import 'package:file_picker/file_picker.dart';

class MultimediaAllModule extends StatefulWidget {
  static final String routeName = 'multimedia';
  const MultimediaAllModule({Key key}) : super(key: key);

  @override
  _MultimediaAllModuleState createState() => _MultimediaAllModuleState();
}

class _MultimediaAllModuleState extends State<MultimediaAllModule> {
  final prefs = new PreferensUser();
  final generic = new Generic();

  int page = 0;
  final List<Widget> optionPage = [MultimediaModule(), ListMultimediaModule()];

  void _onItemTapped(int index) {
    setState(() {
      page = index;
    });
  }

  @override
  void initState() {
    prefs.ultimaPagina = MultimediaAllModule.routeName;
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
        title: Text("MATERIAL MULTIMEDIA", style: kTitleAppBar),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: DataSearchMultimedia());
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
                FontAwesomeIcons.playCircle,
                size: 25,
              ),
              title: Text('Multimedia')),
          BottomNavigationBarItem(
              icon: FaIcon(
                FontAwesomeIcons.photoVideo,
                size: 25,
              ),
              title: Text('Publicaciones')),
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

class MultimediaModule extends StatefulWidget {
  static final String routeName = 'multimedia';
  MultimediaModule({Key key}) : super(key: key);
//
  @override
  _MultimediaModuleState createState() => _MultimediaModuleState();
}

class _MultimediaModuleState extends State<MultimediaModule> {
  InputMultilineField titulo;
  InputMultilineField resumen;
  InputTextField detalle;
  InputDropDown especialidad;
  InputDropDown tipoMaterial;

  int valor = 0;
  int valorTipoMaterial = 74;
  int valorTipoEspecialidad = 11;

  bool _save = false;
  String _fecha = '';
  File foto;
  var result;
  String imagenPDF =
      'https://res.cloudinary.com/propia/image/upload/v1592950093/rohprekln9plcyolgw0d.jpg';
  String imagenVideo =
      'https://res.cloudinary.com/propia/image/upload/v1592950136/hy2vrcig1hwdikhjzx2b.jpg';
  String imagen =
      'http://res.cloudinary.com/propia/image/upload/v1592167496/djsbl74vjdwtso6zrst7.jpg';
  String imagenDefault =
      'http://res.cloudinary.com/propia/image/upload/v1592167496/djsbl74vjdwtso6zrst7.jpg';
  TextEditingController _inputFieldDateInicioController =
      new TextEditingController();
  TextEditingController _inputFieldDateFinController =
      new TextEditingController();

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final generic = new Generic();
  final prefs = new PreferensUser();

  Multimedia entity = new Multimedia();

  String _pdfPath = '';

  @override
  void initState() {
    prefs.ultimaPagina = MultimediaModule.routeName;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (valor == 0) imagen = imagen;
    if (valor == 1) imagen = imagenPDF;
    if (valor == 2) imagen = imagenVideo;

    final Multimedia entityData = ModalRoute.of(context).settings.arguments;

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
      icon: FaIcon(
        FontAwesomeIcons.images,
        color: AppTheme.themeVino,
      ),
      onPressed: _seleccionarFoto,
    );
  }

  _crearIconAppCamara() {
    return IconButton(
      icon: FaIcon(
        FontAwesomeIcons.cameraRetro,
        color: AppTheme.themeVino,
      ),
      onPressed: _tomarFoto,
    );
  }

  _crearIconAppVideo() {
    return IconButton(
      icon: FaIcon(
        FontAwesomeIcons.youtube,
        color: AppTheme.themeVino,
      ),
      onPressed: _pickVideo,
    );
  }

  _crearIconAppPDF() {
    return IconButton(
      icon: FaIcon(
        FontAwesomeIcons.solidFilePdf,
        color: AppTheme.themeVino,
      ),
      onPressed: _pickPDF,
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
                height: 135.0,
              ),
            ),
            Container(
              width: size.width * 0.96,
              margin: EdgeInsets.symmetric(vertical: 0.0),
              decoration: contenedorCarretes(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text('CARGAR MATERIAL',
                      style: TextStyle(
                        color: AppTheme.themeVino,
                        fontSize: 16.0,
                      )),
                  _crearIconAppImagenes(),
                  _crearIconAppCamara(),
                  _crearIconAppVideo(),
                  _crearIconAppPDF(),
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
    titulo = InputMultilineField(
        FaIcon(FontAwesomeIcons.chalkboardTeacher, color: AppTheme.themeVino),
        '(*) Nombre del material',
        entity.mulTitulo,
        'Ingrese el nombre del material',
        true);
    resumen = InputMultilineField(
        FaIcon(FontAwesomeIcons.clipboardList, color: AppTheme.themeVino),
        '(*) Resumen sobre material',
        entity.mulResumen,
        'Registre resumen sobre el matarial',
        true);

    especialidad = InputDropDown(
        FaIcon(FontAwesomeIcons.userMd, color: AppTheme.themeVino),
        '(*) Especialidad:',
        entity.idaCategoria.toString(),
        urlGetClasificador + '10');

    tipoMaterial = InputDropDown(
        FaIcon(FontAwesomeIcons.userMd, color: AppTheme.themeVino),
        '(*) Tipo Material:',
        '74',
        urlGetClasificador + '73');

    return Column(
      children: <Widget>[
        Text(
          '(*) Campos obligatorios. ',
          style: kCamposTitleStyle,
          textAlign: TextAlign.left,
        ),
        //  tipoMaterial,
        _crearMaterial(),

        //  especialidad,
        _crearEspecialidad(),
        titulo,
        resumen,
        _crearFechaInicio('Fecha Inicio'),
        _crearFechaFin('Fecha Fin'),
        divider(),
        _crearBoton(resource.save),
      ],
    );
  }

  List<DropdownMenuItem<String>> getDropDownMaterial(AsyncSnapshot snapshot) {
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

  Widget _crearMaterial() {
    return Center(
        child: FutureBuilder(
            future: generic.getAll(new GetClasificador(),
                urlGetClasificador + '73', primaryKeyGetClasifidor),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Row(
                  children: <Widget>[
                    SizedBox(width: 35.0),
                    Text('Tipo de Material'),
                    SizedBox(width: 15.0),
                    DropdownButton(
                      icon: FaIcon(FontAwesomeIcons.sort,
                          color: AppTheme.themeVino),
                      value: valorTipoMaterial.toString(), //valor
                      items: getDropDownMaterial(snapshot),
                      onChanged: (value) {
                        setState(() {
                          valorTipoMaterial = int.parse(value);
                          //print('valorTipoMaterial $valorTipoMaterial');
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
    List<DropdownMenuItem<String>> listaE = new List();

    for (var i = 0; i < snapshot.data.length; i++) {
      GetClasificador item = snapshot.data[i];
      listaE.add(DropdownMenuItem(
        child: Text(item.nombre),
        value: item.id.toString(),
      ));
    }
    return listaE;
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
                          print('valorTipoEspecialidad $valorTipoEspecialidad');
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

  _selectDateInicio(BuildContext context) async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(2020, 6),
        lastDate: new DateTime(2025, 12),
        locale: Locale('es', 'ES'));

    if (picked != null) {
      setState(() {
        _fecha = DateFormat("dd/MM/yyyy").format(picked);
        _inputFieldDateInicioController.text = _fecha;
        entity.detFechaInicio = _inputFieldDateInicioController.text;
      });
    }
  }

  _selectDateFin(BuildContext context) async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: new DateTime(2020, 12), //new DateTime.now(),
        firstDate: new DateTime(2020, 6),
        lastDate: new DateTime(2025, 12),
        locale: Locale('es', 'ES'));

    if (picked != null) {
      setState(() {
        _fecha = DateFormat("dd/MM/yyyy").format(picked);
        _inputFieldDateFinController.text = _fecha;
        entity.detFechaFin = _inputFieldDateFinController.text;
      });
    }
  }

  Widget _crearFechaInicio(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
      child: TextField(
        enableInteractiveSelection: false,
        controller: _inputFieldDateInicioController,
        decoration: InputDecoration(
            // border: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(20.0)
            // ),
            hintText: '(*) Fecha inicio del material',
            labelText: '(*) Fecha inicio del material',
            //    suffixIcon: Icon(Icons.perm_contact_calendar),
            icon: FaIcon(FontAwesomeIcons.calendarAlt,
                color: AppTheme.themeVino)),
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
          _selectDateInicio(context);
        },
      ),
    );
  }

  Widget _crearFechaFin(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
      child: TextField(
        enableInteractiveSelection: false,
        controller: _inputFieldDateFinController,
        decoration: InputDecoration(
            // border: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(20.0)
            // ),
            hintText: '(*) Fecha fin del material',
            labelText: '(*) Fecha fin del material',
            //    suffixIcon: Icon(Icons.perm_contact_calendar),
            icon: FaIcon(FontAwesomeIcons.calendarAlt,
                color: AppTheme.themeVino)),
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
          _selectDateFin(context);
        },
      ),
    );
  }

  _crearBoton(String text) {
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
    if (!formKey.currentState.validate()) return;

    formKey.currentState.save();
    setState(() {
      _save = true;
    });

    entity.idcovMultimedia = 0;
    entity.idaCovInstitucion = int.parse(prefs.idInsitucion);
    entity.idaTIpoMaterial = valorTipoEspecialidad;
    entity.idaCategoria = valorTipoMaterial;
    entity.mulTitulo = titulo.objectValue;
    entity.mulResumen = resumen.objectValue;
    entity.detFechaFin = _inputFieldDateFinController.text;
    entity.detFechaInicio = _inputFieldDateInicioController.text;
    entity.usuario = prefs.correoElectronico;

    //print('IMPRIMIR ENTITY MULENLACE: ${entity.mulEnlace}');
    await generic.add(entity, urlAddMultimedia).then((respuesta) {
      result = respuesta["TIPO_RESPUESTA"];
      //print('resultado:$result');

      if (result == "0") {
        scaffoldKey.currentState
            .showSnackBar(messageOk("Se insertó correctamente"));

        enviarNotificaciones(
            urlGetToken + '2/${prefs.idInsitucion}',
            'multimedia',
            'Nuevo Material',
            titulo.objectValue,
            'Fecha del evento',
            _inputFieldDateInicioController.text);
      } else
        scaffoldKey.currentState
            .showSnackBar(messageNOk("Error, vuelta a intentarlo"));

      setState(() {
        _save = false;
      });
    });
  }

  // _seleccionarVideo() async => _procesarVideo(VideoSource.gallery);
  _seleccionarFoto() async {
    valor = 0;
    _procesarImagen(ImageSource.gallery);
  }

  _tomarFoto() async {
    valor = 0;
    _procesarImagen(ImageSource.camera);
  }

  _procesarImagen(ImageSource origen) async {
    foto = await ImagePicker.pickImage(source: origen);

    if (foto != null) {
      imagen = await generic.subirImagen(foto);
    }
    setState(() {
      entity.mulEnlace = imagen;
    });
  }

  _procesarFile(String file) async {
    valor = 1;

    if (file != null) {
      imagen = await generic.subirImagenFile(file);
    }
    setState(() {
      entity.mulEnlace = imagen;
      //print(          'cargadodefecto PDF ${entity.mulEnlace} y enlace defecto $imagenPDF y el valor de pdf es: $imagen');
    });
  }

  _procesarVideo2(String file) async {
    valor = 2;

    if (file != null) {
      imagen = await generic.subirVideo(file);
    }
    setState(() {
      entity.mulEnlace = imagen;
      //print('cargadod e iagen ${entity.mulEnlace}');
    });
  }

  void _pickPDF() async {
    try {
      var _extension = 'PDF';
      _pdfPath = await FilePicker.getFilePath(
          type: FileType.custom,
          allowedExtensions: (_extension?.isNotEmpty ?? false)
              ? _extension?.replaceAll(' ', '')?.split(',')
              : null);

      setState(() {});
      if (_pdfPath == '') {
        return;
      }
      valor = 1;

      _procesarFile(_pdfPath);
    } on PlatformException catch (e) {
      scaffoldKey.currentState
          .showSnackBar(messageNOk("Error, ${e.toString()}"));
    }
  }

  void _pickVideo() async {
    try {
      var _extension = 'MP4';
      _pdfPath = await FilePicker.getFilePath(
          type: FileType.custom,
          allowedExtensions: (_extension?.isNotEmpty ?? false)
              ? _extension?.replaceAll(' ', '')?.split(',')
              : null);

      setState(() {});
      if (_pdfPath == '') {
        return;
      }
      //print("File path11: " + _pdfPath);
      _procesarVideo2(_pdfPath);
      // setState(() {
      //   _isLoading = true;
      // });
    } on PlatformException catch (exception) {
      scaffoldKey.currentState.showSnackBar(
          messageNOk("Error: ${exception.toString()}, vuelta a intentarlo"));
    }
  }
}
