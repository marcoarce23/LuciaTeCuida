import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:luciatecuida/src/Model/Entity.dart';
import 'package:luciatecuida/src/Model/Generic.dart';
import 'package:luciatecuida/src/Model/PreferenceUser.dart';
import 'package:luciatecuida/src/Theme/ThemeModule.dart';
import 'package:luciatecuida/src/Widget/GeneralWidget.dart';
import 'package:luciatecuida/src/Widget/InputField/InputFieldWidget.dart';
import 'package:luciatecuida/src/Widget/Message/Message.dart';
import 'package:luciatecuida/src/module/Settings/RoutesModule.dart';
import 'package:luciatecuida/src/module/SplashScreen/IntroScreenModule.dart';
import 'package:page_transition/page_transition.dart';
import 'dart:async';
import 'package:imei_plugin/imei_plugin.dart';


class SignUpModule extends StatefulWidget {
  static final String routeName = 'login';

  @override
  _SignUpModuleState createState() => _SignUpModuleState();
}

class _SignUpModuleState extends State<SignUpModule> {
  InputEmailField correo;
  InputTextPassword contrasenia;

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final generic = new Generic();
  final prefs = new PreferensUser();
  LoginSigIn entity = new LoginSigIn();
  String _platformImei = 'Unknown';
  String uniqueId = "Unknown";
  String result2;
  var result;
  var result1;

  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
      'profile',
    ],
  );

  GoogleSignInAccount currentUser;
  get respuesta => null;

  @override
  void initState() {
    super.initState();
    prefs.ultimaPagina = SignUpModule.routeName;
    initPlatformState();

    // _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
    //   setState(() {
    //     _currentUser = account;
    //   });
    //   if (_currentUser != null) {
    //     _handleGetContact();
    //   }
    // });
    // _googleSignIn.signInSilently();

    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      setState(() {
        currentUser = account;
      });
    });
    _googleSignIn.signInSilently();
  }

//  Future<void> _handleGetContact() async {
//     setState(() {
//       _contactText = "Loading contact info...";
//     });
//     final http.Response response = await http.get(
//       'https://people.googleapis.com/v1/people/me/connections'
//       '?requestMask.includeField=person.names',
//       headers: await _currentUser.authHeaders,
//     );
//     if (response.statusCode != 200) {
//       setState(() {
//         _contactText = "People API gave a ${response.statusCode} "
//             "response. Check logs for details.";
//       });
//       print('People API ${response.statusCode} response: ${response.body}');
//       return;
//     }
//     final Map<String, dynamic> data = json.decode(response.body);
//     final String namedContact = _pickFirstNamedContact(data);
//     setState(() {
//       if (namedContact != null) {
//         _contactText = "I see you know $namedContact!";
//       } else {
//         _contactText = "No contacts to display.";
//       }
//     });
//   }

//  String _pickFirstNamedContact(Map<String, dynamic> data) {
//     final List<dynamic> connections = data['connections'];
//     final Map<String, dynamic> contact = connections?.firstWhere(
//       (dynamic contact) => contact['names'] != null,
//       orElse: () => null,
//     );
//     if (contact != null) {
//       final Map<String, dynamic> name = contact['names'].firstWhere(
//         (dynamic name) => name['displayName'] != null,
//         orElse: () => null,
//       );
//       if (name != null) {
//         return name['displayName'];
//       }
//     }
//     return null;
//   }

//   Future<void> _handleSignIn() async {
//     try {
//       await _googleSignIn.signIn();

//       _googleSignIn.signIn();
//     } catch (error) {
//       scaffoldKey.currentState
//           .showSnackBar(messageNOk('Se produjo un error: ${error.toString()}'));
//     }
//   }

  Future<void> initPlatformState() async {
    String platformImei = 'Failed to get platform version.';
    String idunique;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformImei =
          await ImeiPlugin.getImei(shouldShowRequestPermissionRationale: false);
      idunique = await ImeiPlugin.getId();
    } catch (error) {
      scaffoldKey.currentState
          .showSnackBar(messageNOk('Se produjo un error: ${error.toString()}'));
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformImei = platformImei;
      uniqueId = idunique;
    });
  }

  Future<void> _handleSignOut() => _googleSignIn.disconnect();

  Future<void> handleSignIn() async {
    try {
      await _googleSignIn.signIn();
      _googleSignIn.signIn().then((value) {
        final dataMap1 = generic.getAll(
            entity, getLogin + '${currentUser.email}/${prefs.token}/${prefs.imei}', primaryKeyGetLogin);

        dataMap1.then((value) {
          if (value.length > 0) {
            for (int i = 0; i < value.length; i++) {
              entity = value[i];
            }
            prefs.imei = entity.imei;
            prefs.nombreUsuario = entity.nombrePersona;
            prefs.correoElectronico = entity.correo;
            prefs.avatarImagen = entity.avatar;
            prefs.nombreInstitucion = entity.nombreInstitucion;
            prefs.idInsitucion = entity.idInstitucion;
            prefs.idPersonal = entity.idPersonal;
            prefs.userId = entity.idUsuario;

            Navigator.push(
                context,
                PageTransition(
                  curve: Curves.bounceOut,
                  type: PageTransitionType.rotate,
                  alignment: Alignment.topCenter,
                  child: IntroScreenModule(),
                ));
          } else {
            entity.idUsuario = currentUser.id;
            entity.idInstitucion = '-1';
            entity.nombrePersona = currentUser.displayName;
            entity.nombreInstitucion = '-1';
            entity.usuario = currentUser.email;
            entity.correo = currentUser.email;
            entity.avatar = (currentUser.photoUrl == null)
                ? 'https://res.cloudinary.com/propia/image/upload/v1590675803/xxxykvu7m2d4nwk4gaf6.jpg'
                : currentUser.photoUrl;
            entity.password = '-1';
            entity.tokenDispositivo = prefs.token;
            entity.imei = _platformImei;
            entity.primeraVez = '-1';

            final dataMap = generic.add(entity, urlAddSignIn);
            dataMap.then((respuesta) => result = respuesta["TIPO_RESPUESTA"]);

            if (result != "-1") {
              prefs.imei = _platformImei;
              prefs.nombreUsuario = currentUser.displayName;
              prefs.correoElectronico = currentUser.email;
              prefs.avatarImagen = currentUser.photoUrl;
              prefs.userId = result;

              Navigator.push(
                  context,
                  PageTransition(
                    curve: Curves.bounceOut,
                    type: PageTransitionType.rotate,
                    alignment: Alignment.topCenter,
                    child: IntroScreenModule(), //AgreeLoginModule(),
                  ));
            } else {
              scaffoldKey.currentState.showSnackBar(
                  messageNOk("Se produjo un error, vuelta a intentarlo"));
            }
          }
        });
      });
    } catch (error) {
      scaffoldKey.currentState
          .showSnackBar(messageNOk('Se produjo un error: ${error.toString()}'));
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        body: SingleChildScrollView(
                  child: SafeArea(
            child: Stack(
              children: <Widget>[
                //   crearFondo(context),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      // begin: Alignment.topCenter,
                      // end: Alignment.bottomRight,
                      // stops: [0.1, 0.4, 0.6, 0.9],
                      colors: [ Colors.white,Colors.white,Colors.white,Colors.white,
                        // Color.fromRGBO(254, 253, 253, 1.0),
                        // Color.fromRGBO(254, 253, 251, 1.0),
                        // Color.fromRGBO(235, 217, 211, 1.0),
                        // Color.fromRGBO(253, 252, 252, 1.0),
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 25.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Container(
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: 20.0),
                               Text('Bienvenido',
                                   style: kSigTitleStyle),
                              Text('a la aplicación', style: kSigTitleStyle),
                              Image(
                                  image: AssetImage("assets/buu.PNG"),
                                  height: 230.0),
                            ],
                          ),
                        ),
                        //   SizedBox(height: 20.0),
                        _crearForm(context),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget _crearForm(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            _dividerOr(),
            _gmailButton(),
            _botonInvitado('Entrar como invitado'),
            // _gmailButtonCerrar(),
            SizedBox(height: 15.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(width: 4.0),
                FaIcon(
                  FontAwesomeIcons.clipboardList,
                  color: AppTheme.themeVino,
                  size: 40.0,
                ),
                SizedBox(width: 5.0),
                Text(
                  ' Importante. Si deseas ingresar con otra\n cuenta Gmail, seleccionar la opcion "Cerrar\nSesión Google" y vuelva a ingresar.',
                  style: kSigssTitleStyle,
                ),
              ],
            ),

            copyRigth(),
          ],
        ),
      ),
    );
  }

  Widget _dividerOr() {
    return Container(
      //   margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Divider(
                    thickness: 1,
                  ),
                ),
              ),
              Text(
                'Si cuentas con correo GMAIL',
                style: kSigsTitleStyle,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Divider(
                    thickness: 1,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _gmailButton() {
    return OutlineButton(
      splashColor: Colors.black,
      onPressed: handleSignIn, // _handleSignIn,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.black),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/google_logo.png"), height: 20.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Inciar sesión con Google',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _botonInvitado(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 70.0),
      width: MediaQuery.of(context).size.width,
      child: RaisedButton.icon(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        color: AppTheme.themeVino,
        textColor: Colors.white,
        label: Text(
          text,
          style: kSubtitleStyle,
        ),
        icon: FaIcon(FontAwesomeIcons.peopleArrows, color: Colors.white),
        onPressed: () {
          prefs.imei = entity.imei;
          prefs.nombreUsuario = 'Invitado';
          prefs.correoElectronico = 'Invitado';
          prefs.nombreInstitucion = 'Invitado';
          prefs.idInsitucion = '0';
          prefs.idPersonal = '0';
          prefs.userId = '0';

          Navigator.push(
              context,
              PageTransition(
                curve: Curves.bounceOut,
                type: PageTransitionType.rotate,
                alignment: Alignment.topCenter,
                child: IntroScreenModule(),
              ));
        },
      ),
    );
  }

  Widget _gmailButtonCerrar() {
    return OutlineButton(
      splashColor: Colors.black,
      onPressed: _handleSignOut,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.black),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/google_logo.png"), height: 20.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                '    Cerrar sesión Google   ',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
