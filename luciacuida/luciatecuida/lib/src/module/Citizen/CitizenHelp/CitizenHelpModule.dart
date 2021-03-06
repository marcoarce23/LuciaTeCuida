import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
import 'package:luciatecuida/src/module/Citizen/CitizenHelp/ListCitizenHelpModule.dart';
import 'package:luciatecuida/src/module/HomePage/HomePageModule.dart';
import 'package:luciatecuida/src/module/Settings/RoutesModule.dart';

class HelpFriendAllModule extends StatefulWidget {
  static final String routeName = 'amigo';
  const HelpFriendAllModule({Key key}) : super(key: key);

  @override
  _HelpFriendAllModuleState createState() => _HelpFriendAllModuleState();
}

class _HelpFriendAllModuleState extends State<HelpFriendAllModule> {
  final prefs = new PreferensUser();
  final generic = new Generic();
  int page = 0;
  final List<Widget> optionPage = [
    CitizenHelpModule(),
    ListCitizenHelpModule()
  ];

  void _onItemTapped(int index) {
    setState(() {
      page = index;
    });
  }

  @override
  void initState() {
    prefs.ultimaPagina = HelpFriendAllModule.routeName;
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
        title: Text("AYUDA A UN PERSONA", style: kTitleAppBar),
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
                FontAwesomeIcons.userMd,
                size: 25,
              ),
              title: Text('Ayudalo')),
          BottomNavigationBarItem(
              icon: FaIcon(
                FontAwesomeIcons.users,
                size: 25,
              ),
              title: Text('Solicitudes')),
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

class CitizenHelpModule extends StatefulWidget {
  static final String routeName = 'helpCitizen';
  @override
  _CitizenHelpModuleState createState() => _CitizenHelpModuleState();
}

class _CitizenHelpModuleState extends State<CitizenHelpModule> {
  InputTextField nombre;
  InputPhoneField telefono;
  InputMultilineField ubicacion;
  InputDropDown tipoAyuda;

  bool _save = false;
  int valorTipoAyuda = 50;
  String _opcionSeleccionadaPrioridad = '';
  var result;
  var list;

  List<String> _tipoPrioridad = ['Muy Alta', 'Alta', 'Media'];

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final generic = new Generic();
  final prefs = new PreferensUser();
  RegistroAmigo registroAmigo = new RegistroAmigo();

  @override
  void initState() {
    _opcionSeleccionadaPrioridad = 'Muy Alta';
    prefs.ultimaPagina = CitizenHelpModule.routeName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final RegistroAmigo registroAmigoData =
        ModalRoute.of(context).settings.arguments;

    if (registroAmigoData != null) registroAmigo = registroAmigoData;

    return Scaffold(
      key: scaffoldKey,
      body: Stack(
        children: <Widget>[
          fondoApp(),
          _crearForm(),
        ],
      ),
      floatingActionButton: generaFloatbuttonHome(context),
    );
  }

  Widget informacionProfesional(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.all(5.0),
        width: MediaQuery.of(context).size.width - 30,
        decoration: boxDecorationList(),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // imagenProfesional(),
                // SizedBox(width: 15.0),
                //   cabeceraInformativa(),
              ],
            ),
            divider(),
          ],
        ),
      ),
    );
  }

  ImageOvalNetwork imagenProfesional() => ImageOvalNetwork(
      imageNetworkUrl: prefs.avatarImagen, sizeImage: Size.fromWidth(45));

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

  Widget _crearForm() {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            //  informacionProfesional(context),
            contenedorTitulo(
              context,
              40.0,
              'REGISTRO DE DATOS',
              FaIcon(FontAwesomeIcons.plusSquare, color: AppTheme.themeVino),
            ),
            SizedBox(height: 7.0),

            AutoSizeText(
              'Estamos en el Departamento de : ${obtenerDepartamento(prefs.idDepartamento)} ',
              style: kSubTitleCardStyle,
              maxLines: 2,
              minFontSize: 15.0,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.justify,
            ),

            SizedBox(height: 7.0),

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
        FaIcon(FontAwesomeIcons.userInjured, color: AppTheme.themeVino),
        '(*) Persona a ayudar',
        registroAmigo.regPersona,
        'Ingrese el nombre de la persona',
        true);
    telefono = InputPhoneField(
        FaIcon(FontAwesomeIcons.viber, color: AppTheme.themeVino),
        '(*) Telefono de referencia',
        registroAmigo.regTelefono,
        'Registre un numero telefónico de referencia',
        true,
        10);
    ubicacion = InputMultilineField(
        FaIcon(FontAwesomeIcons.home, color: AppTheme.themeVino),
        '(*) Donde la encuentro',
        registroAmigo.regUbicacion,
        'Lugar donde se encuentra la persona a ayudar',
        true);

    return Column(
      children: <Widget>[
        Text(
          '(*) Campos obligatorios. ',
          style: kCamposTitleStyle,
          textAlign: TextAlign.left,
        ),
        nombre,
        telefono,
        ubicacion,
        _crearTipoAyuda(),
        _crearTipoPrioridad(),
        divider(),
        _crearBoton(resource.save),
      ],
    );
  }

  List<DropdownMenuItem<String>> getDropDownAyuda(AsyncSnapshot snapshot) {
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

  Widget _crearTipoAyuda() {
    return Center(
        child: FutureBuilder(
            future: generic.getAll(new GetClasificador(),
                urlGetClasificador + '47', primaryKeyGetClasifidor),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Row(
                  children: <Widget>[
                    SizedBox(width: 35.0),
                    Text('Tipo de ayuda:'),
                    SizedBox(width: 15.0),
                    DropdownButton(
                      icon: FaIcon(FontAwesomeIcons.userMd,
                          color: AppTheme.themeVino),
                      value: valorTipoAyuda.toString(),
                      items: getDropDownAyuda(snapshot),
                      onChanged: (value) {
                        setState(() {
                          valorTipoAyuda = int.parse(value);

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

  Widget _crearTipoPrioridad() {
    return Row(
      children: <Widget>[
        SizedBox(width: 35.0),
        Text('Prioridad:'),
        SizedBox(width: 15.0),
        DropdownButton(
          value: _opcionSeleccionadaPrioridad,
          icon: FaIcon(FontAwesomeIcons.sort, color: AppTheme.themeVino),
          items: getOpcionesPrioridad(),
          onChanged: (opt) {
            setState(() {
              _opcionSeleccionadaPrioridad = opt;
            });
          },
        ),
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
    LatLng latLng;
    latLng = await getLocation().then((onvalue) => latLng = onvalue);

    if (!formKey.currentState.validate()) return;

    formKey.currentState.save();
    setState(() {
      _save = true;
    });

    registroAmigo.idcovRegistroAmigo = 0;
    registroAmigo.regPersona = nombre.objectValue;
    registroAmigo.regTelefono = telefono.objectValue;
    registroAmigo.regUbicacion = ubicacion.objectValue;
    registroAmigo.regPrioridad = _opcionSeleccionadaPrioridad;
    registroAmigo.regTipoAPoyo = valorTipoAyuda;
    registroAmigo.latitud = latLng.latitude;
    registroAmigo.longitud = latLng.longitude;
    registroAmigo.departamento = prefs.idDepartamento;
    registroAmigo.usuario = prefs.correoElectronico;

    final dataMap = generic.add(registroAmigo, urlAddVoluntary);
    await dataMap.then((respuesta) 
    { result = respuesta["TIPO_RESPUESTA"];

    if (result == "0") {
      scaffoldKey.currentState
          .showSnackBar(messageOk("Se registro correctamente."));

      enviarNotificaciones(
          urlGetToken + '4/${prefs.idInsitucion}',
          'ayudaPersona',
          'ayudaPersona',
          nombre.objectValue,
          'Teléfono de contacto',
          telefono.objectValue);
    } else
      scaffoldKey.currentState
          .showSnackBar(messageNOk("Error, vuelta a intentarlo"));

    setState(() {
      _save = false;
    });
    });
  }

  List<DropdownMenuItem<String>> getOpcionesPrioridad() {
    List<DropdownMenuItem<String>> lista = new List();

    _tipoPrioridad.forEach((tipoPrioridad) {
      lista.add(DropdownMenuItem(
        child: Text(tipoPrioridad),
        value: tipoPrioridad,
      ));
    });
    return lista;
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
}
