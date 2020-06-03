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
import 'package:luciatecuida/src/Util/SearchDelegate/DataSearch.dart';
import 'package:luciatecuida/src/Util/Util.dart';
import 'package:luciatecuida/src/Widget/GeneralWidget.dart';
import 'package:luciatecuida/src/Widget/InputField/InputFieldWidget.dart';
import 'package:luciatecuida/src/Widget/Message/Message.dart';
import 'package:luciatecuida/src/module/Citizen/Entity/AtentionEntityodule.dart';
import 'package:luciatecuida/src/module/Citizen/Entity/ListEntityModule.dart';
import 'package:luciatecuida/src/module/HomePage/HomePageModule.dart';
import 'package:luciatecuida/src/module/Map/MapAdressModule.dart';
import 'package:luciatecuida/src/module/Settings/RoutesModule.dart';
import 'package:luciatecuida/src/Util/Validator.dart' as validator;

class EntityAllModule extends StatefulWidget {
  static final String routeName = 'entidad';
  const EntityAllModule({Key key}) : super(key: key);

  @override
  _EntityAllModuleState createState() => _EntityAllModuleState();
}

class _EntityAllModuleState extends State<EntityAllModule> {
  final prefs = new PreferensUser();
  final generic = new Generic();
  int page = 0;

  final List<Widget> optionPage = [
    EntityModule(),
    AtentionEntityModule(),
    ListEntityModule()
  ];

  void _onItemTapped(int index) {
    setState(() {
      page = index;
    });
  }

  @override
  void initState() {
    prefs.ultimaPagina = EntityAllModule.routeName;
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
        title: Text("INSTITUCIONES - GRUPOS", style: kTitleAppBar),
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
              title: Text('Institucion')),
          BottomNavigationBarItem(
              icon: FaIcon(
                FontAwesomeIcons.calendarCheck,
                size: 25,
              ),
              title: Text('Atención')),
          BottomNavigationBarItem(
              icon: FaIcon(
                FontAwesomeIcons.users,
                size: 25,
              ),
              title: Text('Listado')),
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
  bool esSucursal = false;
  File foto;
  double latitud = 0.0;
  double longitud = 0.0;
  LatLng latLng = LatLng(0, 0);
  int valorInstitucion = 3;
  int valorDepartamento = 60;

  String imagen =
      'https://res.cloudinary.com/propia/image/upload/v1590675803/xxxykvu7m2d4nwk4gaf6.jpg';
  var result;

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final generic = new Generic();
  final prefs = new PreferensUser();
  Institucion entity = new Institucion();
  Institucion entityData = new Institucion();

  String sToken;

  @override
  void initState() {
    prefs.ultimaPagina = EntityModule.routeName;
    //_cargarEntity();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
     if (prefs.idInsitucion != '0') {
       Institucion entityData= new Institucion();
      generic.getAll(new Institucion(), urlGetInstitucion + prefs.idInsitucion, primaryKeyGetInsitucion)
          .then((value) {
        print('llego al fXXXX ${value.length}');
        if (value.length > 0)
               entityData  = value[0];

       
            print('desInsitucion ${entityData.desInsitucion}');
            print('desUbicacion ${entityData.desUbicacion}');
            print('direccion ${entityData.direccion}');
          print('esSucursal ${entityData.esSucursal}');
          print('foto ${entityData.foto}');
            print('idInstitucion ${entityData.idInstitucion}');
            print('insLat ${entityData.insLat}');
            print('token ${entityData.token}');
          print('insLng ${entityData.insLng}');
          print('nombreInstitucion ${entityData.nombreInstitucion}');
            print('perCorreoElectronico ${entityData.perCorreoElectronico}');
            print('perFacebbok ${entityData.perFacebbok}');
          print('perYouTube ${entityData.perYouTube}');
          sToken = entityData.token;
print('sToken $sToken');
          valorInstitucion = entityData.tipoInstitucion;
          valorDepartamento = entityData.ubicacion;
          imagen = entityData.foto;
        //   telefono.objectValue = 'ddddddd';
          // if(entityData.esSucursal == 0)
          // {
          //    esSucursal =true;
          // }
          
          // else {esSucursal =false;}
      }
    );
//  setState(() {
//               entity.ubicacion = entityD.ubicacion;
//               entity.telefono = entityD.telefono;
//               esSucursal =true;
//             });
        
    }

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
  //   nombre = InputTextField(
  //       FaIcon(FontAwesomeIcons.city, color: AppTheme.themeVino),
  //       'Nombre de la institución:',
  //       entity.nombreInstitucion,
  //       'Ingrese el nombre',
  //       true);
  //   token = InputPhoneField(
  //       FaIcon(FontAwesomeIcons.creditCard, color: AppTheme.themeVino),
  //       'Ingrese el número de token:',
  //       sToken,
  //       'Ej: 214213 - solo números',
  //       true);
  //  //  // getWidget2(sToken, 'Dirección/ubicacion:', FaIcon(FontAwesomeIcons.dotCircle, color: AppTheme.themeVino), 'Ingrese su dirección/ubicación', true );
  //   direccion = InputMultilineField(
  //       FaIcon(FontAwesomeIcons.dotCircle, color: AppTheme.themeVino),
  //       'Dirección/ubicacion:',
  //       entity.direccion,
  //       'Ingrese su dirección/ubicación',
  //       true);
  //   telefono = InputPhoneField(
  //       FaIcon(FontAwesomeIcons.mobileAlt, color: AppTheme.themeVino),
  //       'Telefono de referencia',
  //       entity.telefono,
  //       'Ingrese el número de referencia',
  //       true);
  //   informacion = InputMultilineField(
  //       FaIcon(FontAwesomeIcons.listAlt, color: AppTheme.themeVino),
  //       'Información complementaria:',
  //       entity.perInformacionComp,
  //       'Informacióm complementaria',
  //       false);
  //   facebook = InputTextField(
  //       FaIcon(FontAwesomeIcons.facebook, color: AppTheme.themeVino),
  //       'Cuenta Facebook:',
  //       entity.perFacebbok,
  //       'Ingrese la cuenta Facebook',
  //       false);
  //   twitter = InputTextField(
  //       FaIcon(FontAwesomeIcons.twitter, color: AppTheme.themeVino),
  //       'Cuenta Twitter:',
  //       entity.perTwitter,
  //       'Ingrese la cuenta Twitter',
  //       false);
  //   paginaWeb = InputUrlField(
  //       FaIcon(FontAwesomeIcons.edge, color: AppTheme.themeVino),
  //       'Pagina Web/block:',
  //       entity.perPaginaWeb,
  //       'Página/block oficial',
  //       false);
  //   youtube = InputTextField(
  //       FaIcon(FontAwesomeIcons.youtube, color: AppTheme.themeVino),
  //       'Cuenta YouTube:',
  //       entity.perYouTube,
  //       'Ingrese la cuenta YouTube',
  //       false);
  //   email = InputEmailField(
  //       FaIcon(FontAwesomeIcons.mailBulk, color: AppTheme.themeVino),
  //       'Correo Electronico:',
  //       entity.perCorreoElectronico,
  //       'Ingrese el correo electrónico',
  //       'Ingrese su correo electronico',
  //       false);

    return Column(
      children: <Widget>[
        _crearTipoInstitucion(),
        _crearDpto(),
        _crearSucursal('Es sucursal'),
        _crearToken(),
     //   token,
        // nombre,
        // direccion,
        // telefono,
        // informacion,
        contenedorSubTitulo(
          context,
          40.0,
          'REDES-SOCIALES',
          FaIcon(FontAwesomeIcons.chromecast, color: Colors.white60),
        ),
        SizedBox(height: 5.0),
        // facebook,
        // twitter,
        // paginaWeb,
        // youtube,
        // email,
        _crearBoton(resource.save),
      ],
    );
  }

 Widget _crearToken() {
   print('sToken $sToken');
    print('sToken en WIDGETTTTT ${entityData.token}');
      return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
      child: TextFormField(
        initialValue: entityData.token,
        enableInteractiveSelection: true,
        enableSuggestions: true,
        autocorrect: true,
        autovalidate: false,
        maxLength: 10,
        toolbarOptions: ToolbarOptions(copy: true, cut:true, paste: true, selectAll: true),
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          focusColor: Colors.blue,
          hintText: 'widget.hint',
          labelText: 'widget.text',
          icon:FaIcon(FontAwesomeIcons.creditCard, color: AppTheme.themeVino),
        ),
        onChanged: (value) {
          setState(() {
            sToken = value;
          });
        },
        validator: (value) => validator.validateTextfieldEmpty(value, true),
        onSaved: (value) => sToken= value,
      ),
    );
  }


  Widget _crearSucursal(String text) {
    return SwitchListTile(
      value: esSucursal,
      title: Text(text),
      activeColor: AppTheme.themeVino,
      onChanged: (value) => setState(() {
        esSucursal = value;
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
                          print(
                              'valor combo ingresado ENTITY MEDICINA: $valorDepartamento y valueeee: $value');
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
                          print(
                              'valor combo ingresado ENTITY MEDICINA: $valorInstitucion y valueeee: $value');
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



  //          entity.idInstitucion = entityD.idInstitucion;
  //  entity.nombreInstitucion = entityD.nombreInstitucion ;
  //   });

  //  print('valor entitty nombreee ${entityData.nombreInstitucion}');
  // entity.idInstitucion = entityData.idInstitucion;
  //  entity.nombreInstitucion = entityData.nombreInstitucion ;
  // entity.insLat = entity.insLat;
  // entity.insLng = entity.insLng;
  // entity.token = entity.token;
  // valorInstitucion = entityData.tipoInstitucion;
  // valorDepartamento = entityData.ubicacion;
  /*     if(entityData.esSucursal == 0) esSucursal  = false;
      else esSucursal  = true;
      
      entity.token = entityData.token;
      entity.nombreInstitucion = entityData.nombreInstitucion ;
     
      entity.direccion = entityData.direccion;
      entity.telefono = entityData.telefono;
      entity.perInformacionComp = entityData.perInformacionComp;
      entity.perFacebbok = entityData.perFacebbok;
      entity.perTwitter = entityData.perTwitter;
      entity.perPaginaWeb = entityData.perPaginaWeb;
      entity.perYouTube = entityData.perYouTube;
      entity.perCorreoElectronico = entityData.perCorreoElectronico ;
      entity.usuario = entityData.usuario; */

  _crearIconAppImagenes() {
    return IconButton(
      icon: Icon(
        Icons.photo_size_select_actual,
        color: AppTheme.themeVino,
      ),
      onPressed: _seleccionarFoto,
    );
  }

  _crearIconAppMap() {
    return IconButton(
        icon: Icon(
          Icons.map,
          color: AppTheme.themeVino,
        ),
        onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MapAdressModule()),
            ));
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

    entity.idInstitucion = 0;
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
    entity.usuario = prefs.userId;

    final dataMap = generic.add(entity, urlAddInstitucion);
    await dataMap.then((respuesta) => result = respuesta["TIPO_RESPUESTA"]);
    print('resultado:$result');

    if (result != "-1" || result != "-2") {
      prefs.idInsitucion = result;

      Navigator.of(context).push(CupertinoPageRoute(
          builder: (BuildContext context) => ListEntityModule()));

      enviarNotificaciones(
          urlGetToken + '2/${prefs.idInsitucion}',
          'organizacion',
          'Nueva organización',
          nombre.objectValue,
          'Bienvenido a la aplicación',
          'Estamos Contigo');
    }
    if (result == "-1") {
      scaffoldKey.currentState
          .showSnackBar(messageNOk('Error, vuelta a intentarlo'));
    }
    if (result == "2") {
      scaffoldKey.currentState
          .showSnackBar(messageNOk("Error, El TOKEN esta siendo utilizado"));
    }

    setState(() {
      _save = false;
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
