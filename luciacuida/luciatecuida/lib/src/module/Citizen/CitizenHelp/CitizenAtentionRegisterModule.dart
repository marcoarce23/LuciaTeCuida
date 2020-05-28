import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:luciatecuida/src/Model/Entity.dart';
import 'package:luciatecuida/src/Model/Generic.dart';
import 'package:luciatecuida/src/Model/PreferenceUser.dart';
import 'package:luciatecuida/src/Theme/ThemeModule.dart';
import 'package:luciatecuida/src/Util/SearchDelegate/DataSearch.dart';
import 'package:luciatecuida/src/Util/Util.dart';
import 'package:luciatecuida/src/Util/Validator.dart' as validator;
import 'package:luciatecuida/src/Util/Resource.dart' as resource;
import 'package:luciatecuida/src/Widget/GeneralWidget.dart';
import 'package:luciatecuida/src/module/HomePage/HomePageModule.dart';


class AtentionCitizenAllModule extends StatefulWidget {
  static final String routeName = 'atencionClinica';
  const AtentionCitizenAllModule({Key key}) : super(key: key);

  @override
  _AtentionCitizenAllModuleState createState() => _AtentionCitizenAllModuleState();
}

class _AtentionCitizenAllModuleState extends State<AtentionCitizenAllModule> {
  final prefs = new PreferensUser();
  final generic = new Generic();
  int page = 0;
  final List<Widget> optionPage = [
    CitizenAtentionRegisterModule(),
    //ListCitizenHelpModule()
  ];

  void _onItemTapped(int index) {
    setState(() {
      page = index;
    });
  }

  @override
  void initState() {
    prefs.ultimaPagina = AtentionCitizenAllModule.routeName;
    page = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.themeVino,
        toolbarOpacity: 0.7,
        iconTheme: IconThemeData(color: AppTheme.themeColorBlanco, size: 12),
        elevation: 0,
        title: Text( "ATENCIÓN PACIENTES",  style: kTitleAppBar),
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
        backgroundColor: Color.fromRGBO(165, 5, 5, 0.7),
        items: [
          BottomNavigationBarItem(
              icon: FaIcon(
                FontAwesomeIcons.userCircle,
                size: 25,
              ),
              title: Text('Registro')),
          BottomNavigationBarItem(
              icon: FaIcon(
                FontAwesomeIcons.calendarCheck,
                size: 25,
              ),
              title: Text('Atenciones')),
        ],
        currentIndex: page,
        unselectedItemColor: Colors.black87,
        selectedItemColor: Colors.white70,
        onTap: _onItemTapped,
      ),
      body: optionPage[page],
    );
  }
}

class CitizenAtentionRegisterModule extends StatefulWidget {
  CitizenAtentionRegisterModule({Key key}) : super(key: key);

  @override
  _CitizenAtentionRegisterModuleState createState() =>
      _CitizenAtentionRegisterModuleState();
}

class _CitizenAtentionRegisterModuleState
    extends State<CitizenAtentionRegisterModule> {
  bool _save = false;
  int _selectedRadio;
  String _opcionSeleccionadaPrioridad = '';
  String _fecha = '';
  TextEditingController _inputFieldDateController = new TextEditingController();

  List<String> _tipoPrioridad = [
    '<Seleccionar_Medio>',
    'Telefono',
    'WhatsApp',
    'Messenger',
    'Twitter',
    'Mensajeria'
  ];

  List<String> _tipoAyuda = [
    '<Seleccionar_Ayuda>',
    'Salud - Covid',
    'Salud',
    'Económica',
    'Alimentación'
  ];

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final generic = new Generic();
  Hospital hospital = new Hospital();

  @override
  void initState() {
    _selectedRadio = 0;
    _opcionSeleccionadaPrioridad = '<Seleccionar_Medio>';

    super.initState();
  }

  List<DropdownMenuItem<String>> getOpcionesTipoAyuda() {
    List<DropdownMenuItem<String>> lista = new List();

    _tipoAyuda.forEach((tipoAyuda) {
      lista.add(DropdownMenuItem(
        child: Text(tipoAyuda),
        value: tipoAyuda,
      ));
    });
    return lista;
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

  @override
  Widget build(BuildContext context) {
    final Hospital hospitalData = ModalRoute.of(context).settings.arguments;

    if (hospitalData != null) hospital = hospitalData;

 return Scaffold(
      key: scaffoldKey,
      body: Stack(
        children: <Widget>[
          _crearForm(),
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

  Widget _crearForm() {
   final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            informacionProfesional(context),
            contenedorTitulo(
              context,
              40.0,
              'REGISTRO DE DATOS',
              FaIcon(FontAwesomeIcons.userMd, color: Colors.white60),
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

  Widget  _crearCampos(BuildContext context) {
    return Column(
      children: <Widget>[

        _crearNombre('Nombre completo'),
        _crearFecha('Fecha de la atención'),
        _crearNombre('Edad'),
        _crearSexo(),
        _crearTelefonoContacto('Telefono de referencia'),
        _crearUbicacion('Apoyo realizado'),

        _crearTipoPrioridad(),
        divider(),
        _crearBoton(resource.save),
      ],
    );
  }

  _setSelectedRadio(int value) {
    setState(() {
      _selectedRadio = value;
    });
  }

  Widget _crearSexo() {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text('Masculino'),
          leading: Radio(
            value: 0,
            activeColor: Colors.orangeAccent,
            groupValue: _selectedRadio,
            onChanged: (value) {
              _setSelectedRadio(value);
            },
          ),
        ),
        ListTile(
          title: Text('Femenino'),
          leading: Radio(
            value: 1,
            activeColor: Colors.orangeAccent,
            groupValue: _selectedRadio,
            onChanged: (value) {
              _setSelectedRadio(value);
            },
          ),
        ),
      ],
    );
  }

  _selectDate(BuildContext context) async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(2020, 4),
        lastDate: new DateTime(2025, 12),
        locale: Locale('es', 'ES'));

    if (picked != null) {
      setState(() {
        _fecha = picked.toString().substring(0, 10);
        _inputFieldDateController.text = _fecha;
      });
    }
  }

  Widget _crearFecha(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
      child: TextField(
        enableInteractiveSelection: false,
        controller: _inputFieldDateController,
        decoration: InputDecoration(
            // border: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(20.0)
            // ),
            hintText: 'Fecha de la atención',
            labelText: 'Fecha de la atención',
            //    suffixIcon: Icon(Icons.perm_contact_calendar),
            icon: Icon(Icons.calendar_today, color: Colors.orange)),
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
          _selectDate(context);
        },
      ),
    );
  }

  Widget _crearNombre(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
      child: TextFormField(
        initialValue: hospital.nombre,
        textCapitalization: TextCapitalization.sentences,
        enableInteractiveSelection: true,
        enableSuggestions: true,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          focusColor: Colors.blue,
          hintText: 'Nombre',
          labelText: text,
          icon: Icon(Icons.person_pin, color: Colors.orange),
        ),
        validator: (value) => validator.validateTextfieldEmpty(value, true),
        onSaved: (value) => hospital.nombre = value,
      ),
    );
  }

  Widget _crearUbicacion(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
      child: TextFormField(
        textCapitalization: TextCapitalization.sentences,
        initialValue: hospital.nombre,
        enableInteractiveSelection: true,
        enableSuggestions: true,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          //  hintText: 'Ingrese el correo elecrrónico válido',
          focusColor: Colors.blue,
          labelText: text,
          icon: Icon(Icons.person_outline, color: Colors.orange),
        ),
        validator: (value) => validator.validateTextfieldEmpty(value, true),
        onSaved: (value) => hospital.nombre = value,
      ),
    );
  }

  Widget _crearTelefonoContacto(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
      child: TextFormField(
        initialValue: hospital.nombre,
        keyboardType: TextInputType.number,
        enableInteractiveSelection: true,
        enableSuggestions: true,
        decoration: InputDecoration(
          //  hintText: 'Ingrese el correo elecrrónico válido',
          focusColor: Colors.blue,
          labelText: text,
          icon: Icon(Icons.phone, color: Colors.orange),
        ),
        validator: (value) => validator.validateTextfieldEmpty(value, true),
        onSaved: (value) => hospital.nombre = value,
      ),
    );
  }

   Widget _crearTipoPrioridad() {
    return Row(
      children: <Widget>[
        SizedBox(width: 25.0),
        Text('Medio Atención:'),
        SizedBox(width: 10.0),
        DropdownButton(
          value: _opcionSeleccionadaPrioridad,
          icon: Icon(Icons.person_pin, color: Colors.orange),
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
          style: kSubtitleStyle,
        ),
        icon: FaIcon(FontAwesomeIcons.save, color: Colors.white),
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

    if (hospital.nombre == null) {
      // generic.add(citizen);
      print("INSERTOOOO");
    } else {
      //  generic.update(citizen);
      print("MODIFICO");
    }

    setState(() {
      _save = false;
    });

    //Navigator.of(context).push(CupertinoPageRoute(builder: (BuildContext context) => SliderShowModule()));
  }
}
