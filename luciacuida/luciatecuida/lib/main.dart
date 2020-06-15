
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:luciatecuida/src/Model/PreferenceUser.dart';
import 'package:luciatecuida/src/Provider/NotificacionesModule.dart';
import 'package:luciatecuida/src/Provider/PushNotificationProvider.dart';
import 'package:luciatecuida/src/module/Citizen/CitizenEmergency/CitizenEmergencyModule.dart';
import 'package:luciatecuida/src/module/Citizen/CitizenEvents/CitizenEventsModule.dart';
import 'package:luciatecuida/src/module/Citizen/CitizenHelp/CitizenHelpModule.dart';
import 'package:luciatecuida/src/module/Citizen/CitizenHelp/ListCitizenHelpModule.dart';
import 'package:luciatecuida/src/module/Citizen/CitizenInstitution/CitizenListInstitucionModule.dart';
import 'package:luciatecuida/src/module/Citizen/CitizenMultimedia/CitizenMultimediaModule.dart';
import 'package:luciatecuida/src/module/Citizen/CitizenPanicButton/CitizenPanicButtonModule.dart';
import 'package:luciatecuida/src/module/Citizen/CitizenPanicButton/ListCitizenPanic.dart';
import 'package:luciatecuida/src/module/Citizen/Entity/AtentionEntityodule.dart';
import 'package:luciatecuida/src/module/Citizen/Entity/EntityModule.dart';
import 'package:luciatecuida/src/module/Citizen/Entity/EventEntityModule.dart';
import 'package:luciatecuida/src/module/Citizen/Entity/InformationEntity.dart';
import 'package:luciatecuida/src/module/Citizen/Entity/ListEntityModule.dart';
import 'package:luciatecuida/src/module/Citizen/Multimedia/ListMultimediaModule.dart';
import 'package:luciatecuida/src/module/Citizen/Multimedia/MultimediaModule.dart';
import 'package:luciatecuida/src/module/Citizen/Voluntary/AtentionModule.dart';
import 'package:luciatecuida/src/module/Citizen/Voluntary/EventModule.dart';
import 'package:luciatecuida/src/module/Citizen/Voluntary/FoundVoluntaryModule.dart';
import 'package:luciatecuida/src/module/Citizen/Voluntary/InformationVoluntary.dart';
import 'package:luciatecuida/src/module/Citizen/Voluntary/ListEventModule.dart';
import 'package:luciatecuida/src/module/Citizen/Voluntary/ListVoluntary.dart';
import 'package:luciatecuida/src/module/Citizen/Voluntary/VoluntaryModule.dart';
import 'package:luciatecuida/src/module/HomePage/HomePageModule.dart';
import 'package:luciatecuida/src/module/Login/AgreeLoginModule.dart';
import 'package:luciatecuida/src/module/Login/ForgetPasswordModule.dart';
import 'package:luciatecuida/src/module/Login/SignUpModule.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:luciatecuida/src/module/Map/MapAdressModule.dart';
import 'package:luciatecuida/src/module/SplashScreen/IntroScreenModule.dart';
import 'package:luciatecuida/src/module/SplashScreen/SplashScreenModule.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new PreferensUser();
  await prefs.initPrefs();
  runApp(MyApp());
//  DevicePreview(
//     enabled: !kReleaseMode,
//     builder: (context) => MyApp(),
//   );
}


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
  final prefs = new PreferensUser();
  String token;

  @override
  void initState() {
    super.initState();
    
    final pushProvider = new PushNotificationProvider();
    pushProvider.initNotifications();
    pushProvider.mensajes.listen((data) {
         print('Argumento del Push: $data');

         if(data == 'ayudaPersona')
             navigatorKey.currentState.pushNamed('CiudadanoEmergencia', arguments: data );

        else if(data == 'Voluntario')
             navigatorKey.currentState.pushNamed('EncuentraVoluntario', arguments: data );
        
         else if(data == 'organizacion')
             navigatorKey.currentState.pushNamed('ListaInstituciones', arguments: data );
        
         else if(data == 'emergencia')
             navigatorKey.currentState.pushNamed('CiudadanoEmergencia', arguments: data );
        
         else if(data == 'eventos')
             navigatorKey.currentState.pushNamed('CiudadanoEventos', arguments: data );
        
         else if(data == 'multimedia')
             navigatorKey.currentState.pushNamed('CiudadanoMultimedia', arguments: data );

      }
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));

    return MaterialApp(
      title: 'ESTAMOS CONTIGO',
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Colors.white,
      ),

      //MULTILENGUAGE
      
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', 'US'), // English
        const Locale('es', 'ES'), // Hebrew
      ],


     // initialRoute: prefs.ultimaPagina,
    //  home: new FilePickerDemo(),//MapAdressModule(),
        home: new SplashScreenModule(),//FilePickerDemo(),

        routes: <String, WidgetBuilder>{
          'Splash': (BuildContext context) => new SplashScreenModule(),
        'notificaciones': (BuildContext context) => new NotificacionesModule(),
        'login': (BuildContext context) => new SignUpModule(),
        'forget': (BuildContext context) => new ForgetPassword(),
        'agree': (BuildContext context) => new AgreeLoginModule(),
        'introScreen': (BuildContext context) => new IntroScreenModule(),
        'home': (BuildContext context) => new HomePageModule(),
        'mapAtencion': (BuildContext context) => new MapAdressModule(),

        'voluntarioAll' : (BuildContext context) => new VoluntaryAllModule(),

        
        'lisVoluntary': (BuildContext context) => new ListVoluntaryModule(),
        'ListEventVoluntary': (BuildContext context) => new ListEventModule(),
        'eventVoluntary': (BuildContext context) => EventModule(),
        'atentionVoluntary': (BuildContext context) => AtentionModule(),
        'multimedia': (BuildContext context) => MultimediaModule(),
       
        'AtentionEntity': (BuildContext context) => AtentionEntityModule(),
        'entidad': (BuildContext context) => new EntityModule(),
        'entidadGeneral': (BuildContext context) => new EntityAllModule(),
        'listaEntidad': (BuildContext context) => new ListEntityModule(),
        'eventEntity': (BuildContext context) => new ListEntityModule(),
        'eventoEntidad': (BuildContext context) => new EventEntityModule(),


'helpCitizen': (BuildContext context) => new  CitizenHelpModule(),
"ListaCiudadanoAyuda": (BuildContext context) =>     new ListCitizenHelpModule(),
'voluntary': (BuildContext context) => new VoluntaryModule(),
 'listMultimedia': (BuildContext context) => ListMultimediaModule(),


      //  "CiudadanoAlertaEmergencia":(BuildContext context)=> new  CitizenAlertEmergency(),
        "CiudadanoEmergencia": (BuildContext context) =>     new CitizenEmergencyModule(),
        "CiudadanoEventos": (BuildContext context) => new CitizenEventsModule(),
        //"CiudadanoEventosDetalle":(BuildContext context)=> new CitizenEventsDetailModule(),
        
        //"CiudadanoInstitucion":(BuildContext context)=> new CitizenInstitutionModule(),
        "ListaInstituciones": (BuildContext context) =>     new CitizenListInstitucionModule(),
        //"ImagenDetalle":(BuildContext context)=> new CitizenImageDetailModule(),
        "CiudadanoMultimedia": (BuildContext context) =>    new CitizenMultimediaModule(),
        "CiudadanoBotonPanico": (BuildContext context) =>   new CitizenPanicButtonModule(),
        "ListaCiudadanoPanico": (BuildContext context) =>   new ListCitizenPanic(),
        //"EncontrarTodosLosVoluntariosPorGrupo":(BuildContext context)=> new FoundAllVoluntaryGroupModule(),
        //"EncontrarTodosLosVoluntarios":(BuildContext context)=> new FoundAllVoluntaryModule(),
        "EncuentraVoluntario": (BuildContext context) => new FoundVoluntaryModule(),
      },
    );
  }
}

































      // routes: <String, WidgetBuilder>{
      //   'Splash': (BuildContext context) => new SplashScreenModule(),
      //   'citizen': (BuildContext context) => new CitizenModule(),
      //   'login': (BuildContext context) => new SignUpModule(),
      //   'forgetPassword': (BuildContext context) => new ForgetPassword(),
      //   'registerLogin': (BuildContext context) => new AgreeLoginModule(),
      //   'sliderShowModule': (BuildContext context) => new SliderShowModule(),
      //   'mensaje': (BuildContext context) => new MensajePage(),
      // },