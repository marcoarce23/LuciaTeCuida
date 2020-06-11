import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:luciatecuida/src/Model/PreferenceUser.dart';
import 'package:luciatecuida/src/Theme/ThemeModule.dart';
import 'package:luciatecuida/src/module/HomePage/HomePageModule.dart';
import 'package:page_transition/page_transition.dart';

class IntroScreenModule extends StatefulWidget {
  static final String routeName = 'introScreen';

  @override
  _IntroScreenModuleState createState() => _IntroScreenModuleState();
}

class _IntroScreenModuleState extends State<IntroScreenModule> {
  final prefs = new PreferensUser();
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  void initState() {
    prefs.ultimaPagina = IntroScreenModule.routeName;
    super.initState();
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? AppTheme.themeVino : Colors.black54,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              // begin: Alignment.topCenter,
              // end: Alignment.bottomRight,
              // stops: [0.1, 0.4, 0.7, 0.9],
              colors: [
                Colors.white, Colors.white, Colors.white, Colors.white,
                // Color.fromRGBO(237, 237, 236, 1.0),
                // Color.fromRGBO(252, 252, 252, 1.0),
                // Color.fromRGBO(251, 251, 251, 1.0),
                // Color.fromRGBO(239, 240, 239, 1.0),
                //     Color.fromRGBO(245, 173, 53, 1.0),
                //     Color.fromRGBO(236, 220, 109, 1.0),
                //     Color.fromRGBO(70, 191, 167 , 1.0),
                // Color(0xFF3594DD),
                // Color(0xFF4563DB),
                // Color(0xFF5036D5),
                // Color(0xFF5B16D0),
              ],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: () => Navigator.push(
                        context,
                        PageTransition(
                          curve: Curves.bounceOut,
                          type: PageTransitionType.rotate,
                          alignment: Alignment.topCenter,
                          child: HomePageModule(),
                        )),
                    child: Text(
                      'Iniciar',
                      style: TextStyle(
                        color: AppTheme.themeVino,
                        fontSize: 22.0,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 480.0,
                  child: PageView(
                    physics: ClampingScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: <Widget>[
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Image(
                                image: AssetImage(
                                  'assets/image/onboarding0.png',
                                ),
                                height: 180.0,
                                width: 180.0,
                              ),
                            ),
                            Text(
                              'Lucia Te Cuida, es una APP social para tod@s.',
                              style: kTitleStyleBlack,
                              textAlign: TextAlign.center,
                              softWrap: true,
                              overflow: TextOverflow.clip,
                            ),
                            SizedBox(height: 15.0),
                            Expanded(
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      SizedBox(width: 11.0),
                                      FaIcon(
                                          FontAwesomeIcons.handHoldingMedical,
                                          color: AppTheme.themeVino,
                                          size: 35.0),
                                      SizedBox(width: 11.0),
                                      Expanded(
                                        child: Text(
                                          'Para todas las personas que requieren de una ayuda médica gratuita.',
                                          style: kSubtitleStyleBlack,
                                          softWrap: true,
                                          overflow: TextOverflow.clip,
                                          textAlign: TextAlign.justify,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10.0),
                                  Row(
                                    children: <Widget>[
                                      FaIcon(FontAwesomeIcons.handHoldingHeart,
                                          color: AppTheme.themeVino,
                                          size: 35.0),
                                      SizedBox(width: 11.0),
                                      Text(
                                        'Personas que requieren de apoyo espiritual,\nde motivacional y emocional.',
                                        style: kSubtitleStyleBlack,
                                        softWrap: true,
                                        overflow: TextOverflow.clip,
                                        textAlign: TextAlign.justify,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 11.0),
                                  Row(
                                    children: <Widget>[
                                      FaIcon(FontAwesomeIcons.handHoldingWater,
                                          color: AppTheme.themeVino,
                                          size: 35.0),
                                      SizedBox(width: 10.0),
                                      Text(
                                        'Es una aplicación tan humana que pre_\ntende dar una esperanza a las personas.',
                                        style: kSubtitleStyleBlack,
                                        softWrap: true,
                                        overflow: TextOverflow.clip,
                                        textAlign: TextAlign.justify,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Image(
                                image: AssetImage(
                                  'assets/image/onboarding2.png',
                                ),
                                height: 180.0,
                                width: 180.0,
                              ),
                            ),
                            SizedBox(height: 10.0),
                            Text(
                              'QUIENES FORMAN PARTE ?',
                              style: kTitleStyleBlack,
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 13.0),
                            Expanded(
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      FaIcon(FontAwesomeIcons.peopleCarry,
                                          color: AppTheme.themeVino,
                                          size: 35.0),
                                      SizedBox(width: 10.0),
                                      Text(
                                        'Grupo de voluntarios comprometidos\n y dedicados a brindarte un apoyo.',
                                        style: kSubtitleStyleBlack,
                                        softWrap: true,
                                        overflow: TextOverflow.clip,
                                        textAlign: TextAlign.justify,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 13.0),
                                  Row(
                                    children: <Widget>[
                                      FaIcon(FontAwesomeIcons.peopleArrows,
                                          color: AppTheme.themeVino,
                                          size: 35.0),
                                      SizedBox(width: 13.0),
                                      Text(
                                        'Personas que nos preocupa tu salud,\n nos preocupa tu bienestar.',
                                        style: kSubtitleStyleBlack,
                                        softWrap: true,
                                        overflow: TextOverflow.clip,
                                        textAlign: TextAlign.justify,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 13.0),
                                  Row(
                                    children: <Widget>[
                                      FaIcon(FontAwesomeIcons.diagnoses,
                                          color: AppTheme.themeVino,
                                          size: 35.0),
                                      SizedBox(width: 10.0),
                                      Text(
                                        'Grupo de ciudadanos bolivianos que \n convecidos con nuestro trabajo\npodemos hacer a diferencia en tu vida.',
                                        style: kSubtitleStyleBlack,
                                        softWrap: true,
                                        overflow: TextOverflow.clip,
                                        textAlign: TextAlign.justify,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 13.0),
                                  Row(
                                    children: <Widget>[
                                      FaIcon(FontAwesomeIcons.diagnoses,
                                          color: AppTheme.themeVino,
                                          size: 35.0),
                                      SizedBox(width: 10.0),
                                      Text(
                                        'COnisderar que el traajo de la gente es de \n voluntariado en funcion........',
                                        style: kSubtitleStyleBlack,
                                        softWrap: true,
                                        overflow: TextOverflow.clip,
                                        textAlign: TextAlign.justify,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Image(
                                image: AssetImage(
                                  'assets/image/onboarding1.png',
                                ),
                                height: 180.0,
                                width: 180.0,
                              ),
                            ),
                            SizedBox(height: 5.0),
                            Column(
                              children: <Widget>[
                                Text(
                                  'SOLO TE RECOMENDAMOS.',
                                  style: kTitleStyleBlack,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            SizedBox(height: 12.0),
                            Expanded(
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      FaIcon(FontAwesomeIcons.firstAid,
                                          color: AppTheme.themeVino,
                                          size: 30.0),
                                      SizedBox(width: 10.0),
                                      Text(
                                        'Hacer buen uso de la aplicación, el tiempo \ntuyo y el nuestro es valioso.',
                                        style: kSubtitleStyleBlack,
                                        softWrap: true,
                                        overflow: TextOverflow.clip,
                                        textAlign: TextAlign.justify,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 12.0),
                                  Row(
                                    children: <Widget>[
                                      FaIcon(FontAwesomeIcons.listUl,
                                          color: AppTheme.themeVino,
                                          size: 30.0),
                                      SizedBox(width: 10.0),
                                      Text(
                                        'Brindar información real y veridica a las \npersonas con las que tengas un contacto \na traves de la aplicación LuciaTeCuida.',
                                        style: kSubtitleStyleBlack,
                                        softWrap: true,
                                        overflow: TextOverflow.clip,
                                        textAlign: TextAlign.justify,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 12.0),
                                  Row(
                                    children: <Widget>[
                                      FaIcon(FontAwesomeIcons.users,
                                          color: AppTheme.themeVino,
                                          size: 30.0),
                                      SizedBox(width: 10.0),
                                      Text(
                                        'Difunde el uso de la aplicación con tus \namig@s, familiares y personas para que \npodamos llegar a mas personas.',
                                        style: kSubtitleStyleBlack,
                                        softWrap: true,
                                        overflow: TextOverflow.clip,
                                        textAlign: TextAlign.justify,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      FaIcon(FontAwesomeIcons.diagnoses,
                                          color: AppTheme.themeVino,
                                          size: 35.0),
                                      SizedBox(width: 10.0),
                                      Text(
                                        'COnisderar que el traajo de la gente es de \nvoluntariado en funcion........',
                                        style: kSubtitleStyleBlack,
                                        softWrap: true,
                                        overflow: TextOverflow.clip,
                                        textAlign: TextAlign.justify,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(),
                ),
                _currentPage != _numPages - 1
                    ? Expanded(
                        child: Align(
                          alignment: FractionalOffset.bottomRight,
                          child: FlatButton(
                            onPressed: () {
                              _pageController.nextPage(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.ease,
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  'Siguiente',
                                  style: TextStyle(
                                    color: AppTheme.themeVino,
                                    fontSize: 22.0,
                                  ),
                                ),
                                SizedBox(width: 10.0),
                                Icon(
                                  Icons.arrow_forward,
                                  color: AppTheme.themeVino,
                                  size: 30.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Text(''),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: _currentPage == _numPages - 1
          ? Container(
              height: 50.0,
              width: double.infinity,
              color: Colors.white54,
              child: GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    PageTransition(
                      curve: Curves.bounceOut,
                      type: PageTransitionType.rotate,
                      alignment: Alignment.topCenter,
                      child: HomePageModule(),
                    )),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Comenzar',
                          style: TextStyle(
                            color: AppTheme.themeVino,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 10.0),
                        FaIcon(
                          FontAwesomeIcons.keybase,
                          color: AppTheme.themeVino,
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          : Text(''),
    );
  }
}
