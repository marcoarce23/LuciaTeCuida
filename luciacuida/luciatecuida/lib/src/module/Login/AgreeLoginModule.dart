import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:luciatecuida/src/Model/Entity.dart';
import 'package:luciatecuida/src/Model/Generic.dart';
import 'package:luciatecuida/src/Model/PreferenceUser.dart';
import 'package:luciatecuida/src/Widget/InputField/InputFieldWidget.dart';
import 'package:luciatecuida/src/Widget/Message/Message.dart';
import 'package:luciatecuida/src/module/SplashScreen/IntroScreenModule.dart';
import 'package:page_transition/page_transition.dart';

class AgreeLoginModule extends StatefulWidget {
  static final String routeName = 'agree';
  @override
  _AgreeLoginModuleState createState() => _AgreeLoginModuleState();
}

class _AgreeLoginModuleState extends State<AgreeLoginModule> {
  InputCheckBox agree;
  InputEmailField correo;

  bool selectAgree = false;
  int intAgree = 0;

  final formKey = GlobalKey<FormState>();
  final generic = new Generic();
  final prefs = new PreferensUser();
  var result;
final scaffoldKey = GlobalKey<ScaffoldState>();
  LoginSigIn entity = new LoginSigIn();

  @override
  void initState() {
    super.initState();
    prefs.ultimaPagina = AgreeLoginModule.routeName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomRight,
                  stops: [0.1, 0.4, 0.7, 0.9],
                  colors: [
                    Color(0xFF3594DD),
                    Color(0xFF4563DB),
                    Color(0xFF5036D5),
                    Color(0xFF5B16D0),
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
                          Text('Estamos contigo. Beinvenido'),
                          Text('Lucia Te Cuida. La App de nuestro corazón'),
                          Image(
                              image: AssetImage("assets/buu.PNG"),
                              height: 250.0),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.0),
                    _acepto('Acepto los términos de la aplicación'),
                    _leerAcuerdo(),
                    _crearBoton('Siguiente'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _acepto(String text) {
    return SwitchListTile(
      value: selectAgree,
      title: Text(text),
      // subtitle: 'LEa con cuidad los termnos de referencia',
      dense: true,
      activeColor: Colors.orange,
      onChanged: (value) => setState(() {
        selectAgree = value;
      }),
    );
  }

  Widget _crearBoton(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 110.0),
      width: MediaQuery.of(context).size.width,
      child: RaisedButton.icon(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        color: Colors.blue,
        textColor: Colors.white,
        label: Text(text),
        icon: Icon(Icons.save),
        onPressed: () {
print(selectAgree);
          if(selectAgree ==true)
        Navigator.push(
        context,
        PageTransition(
          curve: Curves.bounceOut,
          type: PageTransitionType.rotate,
          alignment: Alignment.topCenter,
          child: IntroScreenModule(),
        ),
      );
      else
      {
  print("No ha aceptado los acuerdos.");
     scaffoldKey.currentState.showSnackBar(messageNOk("No ha aceptado los acuerdos."));
        }
        }
      ),
    );
  }

 
  _leerAcuerdo() {
    return FlatButton(
      child: Text('Leer el acuerdo aca.. Aqui.'),
      onPressed: () => Navigator.push(
        context,
        PageTransition(
          curve: Curves.bounceOut,
          type: PageTransitionType.rotate,
          alignment: Alignment.topCenter,
          child: IntroScreenModule(),
        ),

      ),
    );
  }
}
