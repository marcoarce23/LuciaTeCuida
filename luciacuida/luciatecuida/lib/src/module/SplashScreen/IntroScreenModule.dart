import 'package:auto_size_text/auto_size_text.dart';
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
                Colors.white,
                Colors.white,
                Colors.white,
                Colors.white,
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
                  height: 500.0,
                  child: PageView(
                    physics: ClampingScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Image(
                                image: AssetImage(
                                  'assets/image/onboarding0.png',
                                ),
                                height: 150.0,
                                width: 150.0,
                              ),
                            ),

                            SizedBox(height: 15.0),
                            AutoSizeText(
                              'SomosUnoBolivia, es una APP social de voluntariados.',
                              style: kTitleStyleBlack,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              minFontSize: 15.0,
                              overflow: TextOverflow.ellipsis,
                            ),

                            SizedBox(height: 15.0),

                            Flexible(
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Column(
                                        children: <Widget>[
                                          SizedBox(width: 11.0),
                                          FaIcon(
                                              FontAwesomeIcons
                                                  .handHoldingMedical,
                                              color: AppTheme.themeVino,
                                              size: 35.0),
                                        ],
                                      ),
                                      
                                          AutoSizeText(
                                            'Para todas las personas que requieren\n de una ayuda médica gratuita.',
                                            style: kSubtitleStyleBlack,
                                            maxLines: 2,
                                            minFontSize: 17.0,
                                            overflow: TextOverflow.clip,
                                             softWrap: true,
                                            textAlign: TextAlign.justify,
                                          ),
                                      
                                    ],
                                  ),
                                  SizedBox(height: 20.0),

                                  Row(
                                    children: <Widget>[
                                      Column(
                                        children: <Widget>[
                                          SizedBox(width: 11.0),
                                          FaIcon(
                                              FontAwesomeIcons
                                                  .handHoldingHeart,
                                              color: AppTheme.themeVino,
                                              size: 35.0),
                                        ],
                                      ),
                                      
                                          AutoSizeText(
                                            'Una alternativa para recibir asistencia\n telefónica, on-line o audiovisual.',
                                            style: kSubtitleStyleBlack,
                                            maxLines: 2,
                                            minFontSize: 17.0,
                                            overflow: TextOverflow.clip,
                                             softWrap: true,
                                            textAlign: TextAlign.justify,
                                          ),
                                      
                                      
                                    ],
                                  ),

SizedBox(height: 20.0),
                                  Row(
                                    children: <Widget>[
                                      Column(
                                        children: <Widget>[
                                          SizedBox(width: 11.0),
                                          FaIcon(
                                              FontAwesomeIcons.handHoldingWater
                                                  ,
                                              color: AppTheme.themeVino,
                                              size: 35.0),
                                        ],
                                      ),
                                      
                                          AutoSizeText(
                                            'Es un lugar donde podras encontrar\n material multimedia y eventos del \nvoluntariado para tu aprendizaje.',
                                            style: kSubtitleStyleBlack,
                                            maxLines: 3,
                                            minFontSize: 17.0,
                                            overflow: TextOverflow.clip,
                                             softWrap: true,
                                            textAlign: TextAlign.justify,
                                          ),
                                      
                                      
                                    ],
                                  ),

                                ],
                              ),
                            ),

                            //  ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Image(
                                image: AssetImage(
                                  'assets/image/onboarding2.png',
                                ),
                                height: 150.0,
                                width: 150.0,
                              ),
                            ),
                            SizedBox(height: 10.0),
                            AutoSizeText(
                              'QUIENES FORMAN PARTE ?',
                              style: kTitleStyleBlack,
                              maxLines: 2,
                              minFontSize: 15.0,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 15.0),

                            Flexible(
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Column(
                                        children: <Widget>[
                                          SizedBox(width: 7.0),
                                          FaIcon(
                                              FontAwesomeIcons.peopleCarry
                                                  ,
                                              color: AppTheme.themeVino,
                                              size: 35.0),
                                        ],
                                      ),
                                      SizedBox(width: 7.0),
                                          AutoSizeText(
                                            'Grupo de personas que de forma\n voluntaria y dedicación brindan\n apoyo a las personas que estan\nbuscando ayuda.',
                                            style: kSubtitleStyleBlack,
                                            maxLines: 4,
                                            minFontSize: 16,
                                            overflow: TextOverflow.clip,
                                             softWrap: true,
                                            textAlign: TextAlign.justify,
                                          ),
                                      
                                    ],
                                  ),
                                  SizedBox(height: 20.0),

                                  Row(
                                    children: <Widget>[
                                      Column(
                                        children: <Widget>[
                                          SizedBox(width: 11.0),
                                          FaIcon(
                                              FontAwesomeIcons
                                                  .peopleArrows,
                                              color: AppTheme.themeVino,
                                              size: 35.0),
                                        ],
                                      ),
                                      
                                          AutoSizeText(
                                            'Personas que se preocupan por \n tu salud y bienestar.',
                                            style: kSubtitleStyleBlack,
                                            maxLines: 2,
                                            minFontSize: 17.0,
                                            overflow: TextOverflow.clip,
                                             softWrap: true,
                                            textAlign: TextAlign.justify,
                                          ),
                                      
                                      
                                    ],
                                  ),

SizedBox(height: 20.0),
                                  Row(
                                    children: <Widget>[
                                      Column(
                                        children: <Widget>[
                                          SizedBox(width: 11.0),
                                          FaIcon(
                                              FontAwesomeIcons.diagnoses
                                                  ,
                                              color: AppTheme.themeVino,
                                              size: 35.0),
                                        ],
                                      ),
                                      
                                          AutoSizeText(
                                            'Grupo de personas interesadas\nen bridnarte material de apoyo y\n eventos para tu aprendizaje.',
                                            style: kSubtitleStyleBlack,
                                            maxLines: 3,
                                            minFontSize: 17.0,
                                            overflow: TextOverflow.clip,
                                             softWrap: true,
                                            textAlign: TextAlign.justify,
                                          ),
                                      
                                      
                                    ],
                                  ),

                                ],
                              ),
                            ),
                            // ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Image(
                                image: AssetImage(
                                  'assets/image/onboarding1.png',
                                ),
                                height: 150.0,
                                width: 150.0,
                              ),
                            ),
                            SizedBox(height: 5.0),
                            Column(
                              children: <Widget>[
                                AutoSizeText(
                                  'SOLO TE RECOMENDAMOS',
                                  style: kTitleStyleBlack,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            SizedBox(height: 18.0),
                            Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    SizedBox(width: 10.0),
                                    FaIcon(FontAwesomeIcons.firstAid,
                                        color: AppTheme.themeVino, size: 30.0),
                                    SizedBox(width: 10.0),
                                    AutoSizeText(
                                      'Hacer buen uso de la aplicación, en \ntu tiempo y cuando lo necesites.',
                                      style: kSubtitleStyleBlack,
                                      maxLines: 2,
                                      minFontSize: 16.0,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.justify,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 12.0),
                                Row(
                                  children: <Widget>[
                                    SizedBox(width: 10.0),
                                    FaIcon(FontAwesomeIcons.listUl,
                                        color: AppTheme.themeVino, size: 30.0),
                                    SizedBox(width: 10.0),
                                    AutoSizeText(
                                      'Brindar información real y veridica \n a las personas con las que te \ncomuniques a través de la APP \nSomosUnoBolivia.',
                                      style: kSubtitleStyleBlack,
                                      maxLines: 4,
                                      minFontSize: 16.0,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.justify,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 12.0),
                                Row(
                                  children: <Widget>[
                                    SizedBox(width: 10.0),
                                    FaIcon(FontAwesomeIcons.users,
                                        color: AppTheme.themeVino, size: 30.0),
                                    SizedBox(width: 10.0),
                                    AutoSizeText(
                                      'Comparte la aplicación con tus \namig@s, familiares y personas\n para que podamos llegar a mas\n familias bolvianas.',
                                      style: kSubtitleStyleBlack,
                                      maxLines: 4,
                                      minFontSize: 16.0,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.justify,
                                    ),
                                  ],
                                ),
                               
                              ],
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
                          FontAwesomeIcons.handshake,
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
