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
        title: Text( "AYUDA A UN AMIGO(A)",  style: kTitleAppBar),
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
              title: Text('Ayudalo')),
          BottomNavigationBarItem(
              icon: FaIcon(
                FontAwesomeIcons.calendarCheck,
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

  ImageOvalNetwork imagenProfesional() => ImageOvalNetwork( imageNetworkUrl: prefs.avatarImagen, sizeImage: Size.fromWidth(45));

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
              FaIcon(FontAwesomeIcons.userMd, color: AppTheme.themeVino),
            ),
            SizedBox(height: 5.0),
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
        FaIcon(FontAwesomeIcons.accessibleIcon,
            color: Color.fromRGBO(165, 5, 5, 0.7)),
        'Persona a ayudar',
        registroAmigo.regPersona,
        'Ingrese el nombre de la persona',
        true);
    telefono = InputPhoneField(
        FaIcon(FontAwesomeIcons.phoneVolume,
            color: Color.fromRGBO(165, 5, 5, 0.7)),
        'Telefono de referencia',
        registroAmigo.regTelefono,
        'Registre un numero telefónico de referencia',
        true);
    ubicacion = InputMultilineField(
        FaIcon(FontAwesomeIcons.home, color: Color.fromRGBO(165, 5, 5, 0.7)),
        'Donde la encuentro',
        registroAmigo.regUbicacion,
        'Lugar donde se encuentra la persona a ayudar',
        true);

    tipoAyuda = InputDropDown(
        FaIcon(FontAwesomeIcons.plusCircle,
            color: Color.fromRGBO(165, 5, 5, 0.7)),
        'Tipo de ayuda',
        '49',
        urlGetClasificador + '/47');

    return Column(
      children: <Widget>[
        nombre,
        telefono,
        ubicacion,
        tipoAyuda,
        _crearTipoPrioridad(),
        divider(),
        _crearBoton(resource.save),
      ],
    );
  }

  Widget _crearTipoPrioridad() {
    return Row(
      children: <Widget>[
        SizedBox(width: 35.0),
        Text('Prioridad:'),
        SizedBox(width: 15.0),
        DropdownButton(
          value: _opcionSeleccionadaPrioridad,
          icon: FaIcon(FontAwesomeIcons.longArrowAltDown,
              color: Color.fromRGBO(165, 5, 5, 0.7)),
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
    registroAmigo.regTipoAPoyo = int.parse(tipoAyuda.objectValue);
    registroAmigo.latitud = latLng.latitude;
    registroAmigo.longitud = latLng.longitude;
    registroAmigo.usuario = prefs.userId;

    final dataMap = generic.add(registroAmigo, urlAddVoluntary);

    await dataMap.then((respuesta) => result = respuesta["TIPO_RESPUESTA"]);
    print('resultado:$result');

    if (result == "0") {
      scaffoldKey.currentState
          .showSnackBar(messageOk("Se registro correctamente."));
     // Navigator.of(context).push(CupertinoPageRoute(
      //    builder: (BuildContext context) => ListCitizenHelpModule()));
    } else
      scaffoldKey.currentState
          .showSnackBar(messageNOk("Error, vuelta a intentarlo"));

    setState(() {
      _save = false;
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
