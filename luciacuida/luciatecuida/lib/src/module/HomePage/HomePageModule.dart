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
import 'package:luciatecuida/src/module/Citizen/Multimedia/ListDetailModule.dart';
import 'package:luciatecuida/src/module/Citizen/Multimedia/MultimediaModule.dart';
import 'package:luciatecuida/src/module/Citizen/Voluntary/EventModule.dart';
import 'package:luciatecuida/src/module/Citizen/Voluntary/FoundVoluntaryModule.dart';
import 'package:luciatecuida/src/module/Citizen/Voluntary/InformationVoluntary.dart';
import 'package:luciatecuida/src/module/Contactos/ContactAppModule.dart';
import 'package:luciatecuida/src/module/Contactos/ContatGeneralModule.dart';
import 'package:luciatecuida/src/module/Settings/RoutesModule.dart';
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

  List<Widget> _widgetOptions = <Widget>[
    Text(""),
  ];

  @override
  void initState() {
    generic.add( new TokenImei (correo1: prefs.correoElectronico, imei: prefs.imei, token:prefs.token), urlAddTokenImei);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    prefs.ultimaPagina = HomePageModule.routeName;
    //  generic.add( new TokenImei (correo1: prefs.correoElectronico, imei: prefs.imei, token:prefs.token), urlAddTokenImei);

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
                FontAwesomeIcons.keybase,
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
                _botonesRedondeados()
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
print('_selectedIndex $_selectedIndex');

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
        child: Text(item.nombre),
        value: item.id.toString(),
      ));
    }
    return lista;
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
                    SizedBox(width: 10.0),
                    Text('DEPARTAMENTOS HABILITADOS:'),
                    SizedBox(width: 15.0),
                    DropdownButton(
                      icon: FaIcon(FontAwesomeIcons.angleDown,
                          color: AppTheme.themeVino),
                      value: valorExpedido.toString(), //valor
                      items: getDropDown(snapshot),
                      onChanged: (value) {
                        setState(() {
                          valorExpedido = int.parse(value);
                          prefs.idDepartamento = value;
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
              icon: Icon(Icons.perm_contact_calendar, size: 20.0),
              title: Text('Contactenos')),
          BottomNavigationBarItem(
              icon: Icon(Icons.event_note, size: 20.0), title: Text('Eventos')),
          BottomNavigationBarItem(
              icon: Icon(Icons.perm_media, size: 20.0),
              title: Text('Multimedia')),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _botonesRedondeados() {
    return Wrap(children: <Widget>[
      _crearBotonRedondeado(Colors.purpleAccent, Icons.hotel, 'Ayuda Urgente',
          '2', 16.0, CitizenPanicButtonModule(), 0, ""),
      _crearBotonRedondeado(Colors.blue, Icons.add_comment,
          'Consulta a voluntarios', '1', 14.0, FoundVoluntaryModule(), 0, ""),
      _crearBotonRedondeado(Colors.pinkAccent, Icons.accessible_forward,
          'Ayuda a una persona', '3', 14.0, HelpFriendAllModule(), 0, ""),
      _crearBotonRedondeado(Colors.deepPurple, Icons.phone_in_talk,
          'Números de urgencia', '5', 15.0, ContactGeneralModule(), 0, ""),
      _crearBotonRedondeado(
          Colors.cyan,
          Icons.add_to_queue,
          'Prueba de control',
          '6',
          16.0,
          HomePageModule(),
          1,
          "https://omi.app/covid-19/welcome"),
      _crearBotonRedondeado(
          Colors.cyan,
          Icons.add_to_queue,
          'Violencia IntraFamiliar',
          '6',
          14.0,
          ContactGeneralModule(),
          0,
          ""),
_crearBotonRedondeadoImage(Colors.green, 'assets/instituciones.png',
          'Organizaciones', '6', 16.0, CitizenListInstitucionModule(), 0, ""),

      _crearBotonRedondeadoImage(Colors.amberAccent, 'assets/eventos.png',
          'Voluntarios', '4', 18.0, CitizenListInstitucionModule(), 0, ""),
 
      
    ]);
  }

  Widget _crearBotonRedondeado(Color color, IconData icono, String texto,
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
            height: 100.0,
            width: 160,
            margin: EdgeInsets.all(9.0),
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomRight,
              stops: [0.1, 0.4, 0.7, 0.9],
              colors: [
                AppTheme.themeVino, AppTheme.themeVino, AppTheme.themeVino,
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
                  child: Icon(icono, color: Colors.white, size: 42.0),
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

  Widget _crearBotonRedondeadoImage(Color color, String image, String texto,
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
            height: 100.0,
            width: 160,
            margin: EdgeInsets.all(9.0),
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomRight,
              stops: [0.1, 0.4, 0.7, 0.9],
              colors: [
                AppTheme.themeVino, AppTheme.themeVino, AppTheme.themeVino,
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
                  child: Image.asset(image, width: 40.0, height: 40.0),
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
    print('prefs.idPersonal : ${prefs.idPersonal}');
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
                      Expanded(
                        child: Text(
                          prefs.correoElectronico,
                          style: TextStyle(
                              color: AppTheme.themePlomo, fontSize: 16.0),
                          softWrap: true,
                          overflow: TextOverflow.clip,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )),
          ),

          //callWhatsAppAdvanced('Queremos compartir la ��������������������������������� http://bit.ly/mrPlayStore app')),
          //openWeb('http://mapacovid19.ruta88.net/'),
          //sharedImage('assets/image/twitter.jpg','twitter','twitter.jpg','jpg','imagen de apoyo JPG'),
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => SignInDemo()),
          // )),

          // CustomListTile(
          //     Icons.business,
          //     'Inicio',
          //     () => Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //               builder: (context) => PageViewModule(title: 'TEST DE PRUEBA', selectedUrl: 'https://omi.app/covid-19/welcome')),
          //         )),

          // CustomListTile(
          //     Icons.business,
          //     'Conoce las instituciones',
          //     () => Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //               builder: (context) => CitizenListInstitucionModule()),
          //         )),
          // CustomListTile(
          //     Icons.perm_phone_msg,
          //     'Consulta a un voluntario',
          //     () => Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //               builder: (context) => FoundVoluntaryModule()),
          //         )),
          // CustomListTile(
          //     Icons.hotel,
          //     'Pedir ayuda urgente',
          //     () => Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //               builder: (context) => CitizenPanicButtonModule()),
          //         )),
          CustomListTile(
              Icons.accessible_forward,
              'Ayuda a una persona',
              () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HelpFriendAllModule()),
                  )),
          // CustomListTile(
          //     Icons.event_available,
          //     'Eventos vigentes',
          //     () => Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //               builder: (context) => CitizenEventsModule()),
          //         )),
          // CustomListTile(
          //     Icons.play_circle_outline,
          //     'Ver Multimedia',
          //     () => Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //               builder: (context) => CitizenMultimediaModule()),
          //         )),
          // CustomListTile(
          //     Icons.edit_location,
          //     'Registra tu Institución',
          //     () => Navigator.push(
          //           context,
          //           MaterialPageRoute(builder: (context) => EntityAllModule()),
          //         )),

          CustomListTile(
              Icons.add_comment,
              'Atiende las solicitudes',
              () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CitizenEmergencyModule()),
                  )),
          // CustomListTile(
          //   Icons.map,
          //   'Mapa de solicitudes',
          //   () => openWeb('http://mapacovid19.ruta88.net/'),
          //   // Navigator.push(
          //   //       context,
          //   //       MaterialPageRoute(builder: (context) => MapAdressModule()),
          //   //     )
          // ),
          CustomListTile(
              Icons.edit_location,
              'Registra tu Institución',
              () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EntityAllModule()),
                  )),

          CustomListTile(
              Icons.event_available,
              'Crear Eventos-Entidades',
              () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EventAllModule()),
                  )),
          CustomListTile(
              Icons.event_note,
              'Crear Eventos-Voluntarios',
              () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EventVoluntaryAllModule()),
                  )),
          CustomListTile(
              Icons.image,
              'Cargar Multimedia',
              () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MultimediaAllModule()),
                  )),
          CustomListTile(
              Icons.airline_seat_individual_suite,
              'Registrar Atención médica',
              () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ListMaterialModule()),
                  )),
          CustomListTile(
              Icons.person_add,
              'Registrate como voluntario',
              () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => VoluntaryAllModule()),
                  )),
          CustomListTile(
              Icons.share,
              'Comparte la aplicación',
              () => sharedText('Comparte la aplicación LuciaTeCuida',
                  'Comparte la app http://bit.ly/mrPlayStore', 'text/html')),
          CustomListTile(
              Icons.bubble_chart,
              'Acerca de Lucia Te Cuida',
              () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => IntroScreenModule()),
                  )),
          CustomListTile(Icons.exit_to_app, 'Cerrar Sesión', () {
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
              Icons.accessible_forward,
              'Ayuda a una persona',
              () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HelpFriendAllModule()),
                  )),
          // CustomListTile(
          //     Icons.event_available,
          //     'Eventos vigentes',
          //     () => Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //               builder: (context) => CitizenEventsModule()),
          //         )),
          // CustomListTile(
          //     Icons.play_circle_outline,
          //     'Ver Multimedia',
          //     () => Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //               builder: (context) => CitizenMultimediaModule()),
          //         )),
          CustomListTile(
              Icons.edit_location,
              'Registra Institución',
              () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EntityAllModule()),
                  )),
          CustomListTile(
              Icons.person_add,
              'Registrate como voluntario',
              () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => VoluntaryAllModule()),
                  )),
          CustomListTile(
              Icons.share,
              'Comparte la aplicación',
              () => sharedText('Te contamos que existe una aplicación de grupos de voluntariados de diversas áreas. Queremos compartir la aplicación "EstamosContigo" y que nos ayudes a compartir',
                  'Comparte la app http://bit.ly/mrPlayStore', 'text/html')),
          CustomListTile(
              Icons.bubble_chart,
              'Acerca de Lucia Te Cuida',
              () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => IntroScreenModule()),
                  )),
          CustomListTile(
              Icons.exit_to_app,
              'Cerrar Sesión',
              () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignInDemo()),
                  )),
        ],
      ));
    }
  }
}
