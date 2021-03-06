import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:luciatecuida/src/Model/Entity.dart';
import 'package:luciatecuida/src/Model/Generic.dart';
import 'package:luciatecuida/src/Model/PreferenceUser.dart';
import 'package:luciatecuida/src/Theme/ThemeModule.dart';
import 'package:luciatecuida/src/Util/Util.dart';
import 'package:luciatecuida/src/Widget/DrawerWidget/DrawerWiguet.dart';
import 'package:luciatecuida/src/module/Citizen/CitizenEmergency/CitizenEmergencyModule.dart';
import 'package:luciatecuida/src/module/Citizen/CitizenEvents/CitizenEventsModule.dart';
import 'package:luciatecuida/src/module/Citizen/CitizenHelp/CitizenHelpModule.dart';
import 'package:luciatecuida/src/module/Citizen/CitizenInstitution/CitizenListInstitucionModule.dart';
import 'package:luciatecuida/src/module/Citizen/CitizenMultimedia/CitizenMultimediaModule.dart';
import 'package:luciatecuida/src/module/Citizen/CitizenPanicButton/CitizenPanicButtonModule.dart';
import 'package:luciatecuida/src/module/Citizen/Entity/EventEntityModule.dart';
import 'package:luciatecuida/src/module/Citizen/Entity/InformationEntity.dart';
import 'package:luciatecuida/src/module/Citizen/Multimedia/MultimediaModule.dart';
import 'package:luciatecuida/src/module/Citizen/Voluntary/EventModule.dart';
import 'package:luciatecuida/src/module/Citizen/Voluntary/FoundVoluntaryModule.dart';
import 'package:luciatecuida/src/module/Citizen/Voluntary/InformationVoluntary.dart';
import 'package:luciatecuida/src/module/Contactos/ContactAppModule.dart';
import 'package:luciatecuida/src/module/Contactos/ContatGeneralModule.dart';
import 'package:luciatecuida/src/module/Plasma/PlasmaModule.dart';
import 'package:luciatecuida/src/module/Settings/RoutesModule.dart';
import 'package:luciatecuida/src/module/SplashScreen/Acerca.dart';
import 'package:luciatecuida/src/module/SplashScreen/IntroScreenModule.dart';
import 'package:luciatecuida/src/module/Login/SiginDemo.dart';
import 'package:luciatecuida/src/module/UtilModule/PageViewModule.dart';

class HomePageModule extends StatefulWidget {
  static final String routeName = 'home';
  HomePageModule({Key key}) : super(key: key);

  @override
  _HomePageModuleState createState() => _HomePageModuleState();
}

class _HomePageModuleState extends State<HomePageModule> {
  final prefs = new PreferensUser();
  final generic = new Generic();
  int _selectedIndex = 0;
  int valorExpedido = 60;

  @override
  void initState() {
    generic.add(
        new TokenImei(
            correo1: prefs.correoElectronico,
            imei: prefs.imei,
            token: prefs.token),
        urlAddTokenImei);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    prefs.ultimaPagina = HomePageModule.routeName;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          toolbarOpacity: 0.7,
          iconTheme: IconThemeData(color: AppTheme.themeVino, size: 12),
          elevation: 0,
          title: Row(
            children: <Widget>[
              Text("PANTALLA PRINCIPAL.", style: kTitleAppBar),
              SizedBox(width: 10.0),
              FaIcon(
                FontAwesomeIcons.handshake,
                color: AppTheme.themeVino,
                size: 18,
              ),
            ],
          )),
      body: metodoHome(),
      drawer: DrawerCitizen(),
      bottomNavigationBar: _bottomNavigationBar(context),
    );
  }

  Widget metodoHome() {
    return Stack(
      children: <Widget>[
        fondoApp(),
        SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[],
                  ),
                ),
                _crearExpedido(),
                _botonesRedondeados(),
                // divider(),
                Text(
                  'versión 1.0.8',
                  textAlign: TextAlign.left,
                ),
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
            ),
          ),
        )
      ],
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

      if (_selectedIndex == 0) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ContactAppModule()),
        );
      }

      if (_selectedIndex == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CitizenEventsModule()),
        );
      }
      if (_selectedIndex == 2) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CitizenMultimediaModule()),
        );
      }
    });
  }

  List<DropdownMenuItem<String>> getDropDown(AsyncSnapshot snapshot) {
    List<DropdownMenuItem<String>> lista = new List();

    for (var i = 0; i < snapshot.data.length; i++) {
      GetClasificador item = snapshot.data[i];
      lista.add(DropdownMenuItem(
        child: Text(item.detalle),
        value: item.id.toString(),
      ));
    }
    return lista;
  }

  Widget texto() {
    if (int.parse(prefs.idPersonal) > 0) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        child: AutoSizeText(
          'Ud. esta brindando atención en el Departamento de ${obtenerDepartamento(prefs.idDepartamento)}. Si desea cambiar seleccione nuevamente.',
          style: knoteTitleCardStyle,
          maxLines: 3,
          minFontSize: 13.0,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.justify,
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        child: AutoSizeText(
          'Si desea brindar ayuda o recibirla seleccione el departamento.',
          style: knoteTitleCardStyle,
          maxLines: 2,
          minFontSize: 13.0,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.justify,
        ),
      );
    }
  }

  Widget _crearExpedido() {
    return Center(
        child: FutureBuilder(
            future: generic.getAll(new GetClasificador(), urlGetDepartamento,
                primaryKeyGetDepartamento),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: <Widget>[
                    texto(),

                    Row(
                      children: <Widget>[
                        SizedBox(width: 10.0),
                        Text(
                          'Departamentos habilitados:',
                          style: knoteTitleCardStyle,
                        ),
                        DropdownButton(
                          icon: FaIcon(FontAwesomeIcons.angleDown,
                              color: AppTheme.themeVino),
                          value: valorExpedido.toString(), //valor
                          items: getDropDown(snapshot),
                          onChanged: (value) {
                            setState(() {
                              valorExpedido = int.parse(value);
                              prefs.idDepartamento = valorExpedido;
                              //  prefs.departamento = child;
                            });
                          },
                        ),
                      ],
                    ),

                    // SizedBox(width: 15.0),
                  ],
                );
              } else {
                return CircularProgressIndicator();
              }
            }));
  }

  Widget _bottomNavigationBar(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
          canvasColor: Colors
              .white, //AppTheme.themeVino, //Color.fromRGBO(55, 57, 84, 1.0),
          primaryColor: AppTheme.themeVino,
          textTheme: Theme.of(context)
              .textTheme
              .copyWith(caption: TextStyle(color: Colors.black45))),
      child: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.contact_phone, size: 20.0),
              title: Text('Contactenos')),
          BottomNavigationBarItem(
              icon: Icon(Icons.event_available, size: 20.0),
              title: Text('Eventos')),
          BottomNavigationBarItem(
              icon: Icon(Icons.ondemand_video, size: 20.0),
              title: Text('Multimedia')),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _botonesRedondeados() {
    if (prefs.idPersonal != '-2') {
      return Wrap(children: <Widget>[
        _crearBotonRedondeado(
            Colors.purpleAccent,
            FaIcon(FontAwesomeIcons.procedures,
                color: Colors.white, size: 35.0),
            'Ayuda Urgente',
            '2',
            16.0,
            CitizenPanicButtonModule(),
            0,
            ""),
        _crearBotonRedondeado(
            Colors.blue,
            FaIcon(FontAwesomeIcons.userMd, color: Colors.white, size: 35.0),
            'Consulta a voluntarios',
            '1',
            14.0,
            FoundVoluntaryModule(),
            0,
            ""),
        _crearBotonRedondeado(
            Colors.pinkAccent,
            FaIcon(FontAwesomeIcons.userInjured,
                color: Colors.white, size: 35.0),
            'Ayuda a una persona',
            '3',
            14.0,
            HelpFriendAllModule(),
            0,
            ""),
        _crearBotonRedondeado(
            Colors.deepPurple,
            FaIcon(FontAwesomeIcons.pumpMedical,
                color: Colors.white, size: 40.0),
            'Banco Plasma',
            '5',
            15.0,
            PlasmaAllModule(),
            0,
            ""),

        _crearBotonRedondeado(
            Colors.orangeAccent,
            FaIcon(FontAwesomeIcons.laptopMedical,
                color: Colors.white, size: 35.0),
            'Prueba de control',
            '6',
            16.0,
            HomePageModule(),
            1,
            "https://omi.app/covid-19/welcome"),

        _crearBotonRedondeado(
            Colors.green,
            FaIcon(FontAwesomeIcons.school, color: Colors.white, size: 35.0),
            'Organizaciones',
            '6',
            16.0,
            CitizenListInstitucionModule(),
            0,
            ""),

        _crearBotonRedondeado(
            Colors.deepPurple,
            FaIcon(FontAwesomeIcons.viber, color: Colors.white, size: 40.0),
            'Números de urgencia',
            '5',
            15.0,
            ContactGeneralModule(),
            0,
            ""),

        _crearBotonRedondeado(
            Colors.cyan,
            FaIcon(FontAwesomeIcons.tty, color: Colors.white, size: 38.0),
            'Violencia IntraFamiliar',
            '6',
            14.0,
            ContactGeneralModule(),
            0,
            ""),

        // _crearBotonRedondeado(
        //     Colors.indigoAccent,
        //     FaIcon(FontAwesomeIcons.users, color: Colors.white, size: 35.0),
        //     'Voluntarios',
        //     '4',
        //     16.0,
        //     FoundVoluntaryModule(),
        //     0,
        //     ""),
      ]);
    } else {
      return Wrap(children: <Widget>[
        _crearBotonRedondeado(
            Colors.deepPurple,
            FaIcon(FontAwesomeIcons.viber, color: Colors.white, size: 40.0),
            'Números de urgencia',
            '5',
            15.0,
            ContactGeneralModule(),
            0,
            ""),
        _crearBotonRedondeado(
            Colors.cyan,
            FaIcon(FontAwesomeIcons.tty, color: Colors.white, size: 38.0),
            'Violencia IntraFamiliar',
            '6',
            14.0,
            ContactGeneralModule(),
            0,
            ""),
      ]);
    }
  }

  Widget _crearBotonRedondeado(Color color, FaIcon icono, String texto,
      String valor, double size, Widget widget, int acceso, String link) {
    return InkWell(
      onTap: () {
        if (acceso == 1) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PageViewModule(
                      title: 'TEST DE PRUEBA', selectedUrl: link)));
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => widget),
          );
        }
      },
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Container(
            height: 87.0,
            width: 160,
            margin: EdgeInsets.all(5.0),
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomRight,
              stops: [0.1, 0.4, 0.7, 0.9],
              colors: [
                AppTheme.themeVino,
                AppTheme.themeVino,
                AppTheme.themeVino,
                AppTheme.themeVino,
              ],
            )),
            //  borderRadius: BorderRadius.circular(20.0)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                SizedBox(height: 5.0),
                CircleAvatar(
                  backgroundColor: color,
                  radius: 30.0,
                  child: icono,
                  //Icon(icono, color: Colors.white, size: 42.0),
                ),
                Text(texto,
                    style: TextStyle(color: AppTheme.white, fontSize: size)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DrawerCitizen extends StatelessWidget {
  final prefs = new PreferensUser();

  @override
  Widget build(BuildContext context) {
    if (prefs.idPersonal == '-2') {
      return Drawer(
          child: ListView(
        children: <Widget>[
          DrawerHeader(
            decoration: boxDecoration(),
            child: Container(
                child: Column(
              children: <Widget>[
                Material(
                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    elevation: 60.0,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ImageOvalNetwork(
                          imageNetworkUrl: prefs.avatarImagen,
                          sizeImage: Size.fromWidth(70)),
                    )),
                Flexible(
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          prefs.nombreUsuario,
                          style: TextStyle(
                              color: AppTheme.themePlomo, fontSize: 18.0),
                          softWrap: true,
                          overflow: TextOverflow.clip,
                        ),
                      ),
                      AutoSizeText(
                        prefs.correoElectronico,
                        style: TextStyle(
                            color: AppTheme.themePlomo, fontSize: 16.0),
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
              ],
            )),
          ),
          CustomListTile(
              Icons.add_to_home_screen,
              '   Acerca de la aplicación',
              () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AcercaModule()),
                  )),
          CustomListTile(Icons.exit_to_app, '    Cerrar Sesión', () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignInDemo()),
            );
          }),
        ],
      ));
    }

    if (prefs.idPersonal != '-1') {
      return Drawer(
          child: ListView(
        children: <Widget>[
          DrawerHeader(
            decoration: boxDecoration(),
            child: Container(
                child: Column(
              children: <Widget>[
                Material(
                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    elevation: 60.0,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ImageOvalNetwork(
                          imageNetworkUrl: prefs.avatarImagen,
                          sizeImage: Size.fromWidth(70)),
                    )),
                Flexible(
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          prefs.nombreUsuario,
                          style: TextStyle(
                              color: AppTheme.themePlomo, fontSize: 18.0),
                          softWrap: true,
                          overflow: TextOverflow.clip,
                        ),
                      ),
                      AutoSizeText(
                        prefs.correoElectronico,
                        style: TextStyle(
                            color: AppTheme.themePlomo, fontSize: 16.0),
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
              ],
            )),
          ),
          CustomListTile(
              Icons.add_call,
              '    Atiende las solicitudes',
              () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CitizenEmergencyModule()),
                  )),
          CustomListTile(
              Icons.business,
              '    Registra tu Organización',
              () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EntityAllModule()),
                  )),
          CustomListTile(
              Icons.event_available,
              '    Eventos de la Organización',
              () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EventAllModule()),
                  )),
          CustomListTile(
              Icons.event_note,
              '    Eventos del Voluntario',
              () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EventVoluntaryAllModule()),
                  )),
          CustomListTile(
              Icons.ondemand_video,
              '    Material Multimedia',
              () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MultimediaAllModule()),
                  )),
          CustomListTile(
              Icons.person_add,
              '    Registrate como voluntario',
              () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => VoluntaryAllModule()),
                  )),
          CustomListTile(
              Icons.share,
              '    Comparte la aplicación',
              () => sharedText(
                  'Comparte la App - SomosUnoBolivia',
                  '🔺*SomosUnoBolivia*🔺 \n Una aplicación de voluntarios que apoyan a personas que requieren apoyo en COVID-19, médicina en general.\n💬Atención *GRATUITA Y VIRTUAL* personalizada de manera virtual y gratuita. \n 📲 Puede descargar la app desde: https://play.google.com/store/apps/details?id=bo.SomosUnoBolivia',
                  'text/html')),
          CustomListTile(
              Icons.add_to_home_screen,
              '   Acerca de la aplicación',
              () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => IntroScreenModule()),
                  )),
          CustomListTile(Icons.exit_to_app, '    Cerrar Sesión', () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignInDemo()),
            );
          }),
        ],
      ));
    } else {
      return Drawer(
          child: ListView(
        children: <Widget>[
          DrawerHeader(
            decoration: boxDecoration(),
            child: Container(
                child: Column(
              children: <Widget>[
                Material(
                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    elevation: 60.0,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ImageOvalNetwork(
                          imageNetworkUrl: prefs.avatarImagen,
                          sizeImage: Size.fromWidth(70)),
                    )),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        prefs.nombreUsuario,
                        style: TextStyle(
                            color: AppTheme.themePlomo, fontSize: 18.0),
                      ),
                      Text(
                        prefs.correoElectronico,
                        style: TextStyle(
                            color: AppTheme.themePlomo, fontSize: 18.0),
                      ),
                    ],
                  ),
                ),
              ],
            )),
          ),
          CustomListTile(
              Icons.business,
              '    Registra tu Organización',
              () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EntityAllModule()),
                  )),
          CustomListTile(
              Icons.person_add,
              '    Registrate como voluntario',
              () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => VoluntaryAllModule()),
                  )),
          CustomListTile(
              Icons.share,
              '    Comparte la aplicación',
              () => sharedText(
                  'Comparte la App - SomosUnoBolivia',
                  '🔺*SomosUnoBolivia*🔺 \n Una aplicación de voluntarios que apoyan a personas que requieren apoyo en COVID-19, médicina en general.\n💬Atención *GRATUITA Y VIRTUAL* personalizada de manera gratuita y virtual. \n 📲 Puede descargar la app desde: https://play.google.com/store/apps/details?id=bo.SomosUnoBolivia',
                  'text/html')),
          CustomListTile(
              Icons.phone_android,
              '    Acerca de la aplicación',
              () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AcercaModule()),
                  )),
          CustomListTile(
              Icons.exit_to_app,
              '    Cerrar Sesión',
              () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignInDemo()),
                  )),
        ],
      ));
    }
  }
}
