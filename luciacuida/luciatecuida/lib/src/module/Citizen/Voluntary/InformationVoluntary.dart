import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:luciatecuida/src/Model/Entity.dart';
import 'package:luciatecuida/src/Model/Generic.dart';
import 'package:luciatecuida/src/Model/PreferenceUser.dart';
import 'package:luciatecuida/src/Theme/ThemeModule.dart';
import 'package:luciatecuida/src/Util/SearchDelegate/DataSearch.dart';
import 'package:luciatecuida/src/Util/Util.dart';
import 'package:luciatecuida/src/Widget/GeneralWidget.dart';
import 'package:luciatecuida/src/module/Citizen/Entity/ListEntityModule.dart';
import 'package:luciatecuida/src/module/Citizen/Voluntary/ListVoluntary.dart';
import 'package:luciatecuida/src/module/HomePage/HomePageModule.dart';
import 'package:luciatecuida/src/module/Settings/RoutesModule.dart';

class VoluntaryAllModule extends StatefulWidget {
  static final String routeName = 'voluntarioAll';
  const VoluntaryAllModule({Key key}) : super(key: key);

  @override
  _VoluntaryAllModuleState createState() => _VoluntaryAllModuleState();
}

class _VoluntaryAllModuleState extends State<VoluntaryAllModule> {
  final prefs = new PreferensUser();
  final generic = new Generic();
  int page = 0;

  final List<Widget> optionPage = [
    InformationVoluntary(),
    ListVoluntaryModule(),
    ListEntityModule()
  ];

  void _onItemTapped(int index) {
    setState(() {
      page = index;
    });
  }

  @override
  void initState() {
    prefs.ultimaPagina = VoluntaryAllModule.routeName;
    page = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          toolbarOpacity: 0.7,
          iconTheme: IconThemeData(color: AppTheme.themeVino, size: 12),
          elevation: 0,
          title: Text("ACERCA VOLUNTARIADO", style: kTitleAppBar),
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
                title: Text('Registro')),
            BottomNavigationBarItem(
                icon: FaIcon(
                  FontAwesomeIcons.calendarCheck,
                  size: 25,
                ),
                title: Text('Voluntariados')),
            BottomNavigationBarItem(
                icon: FaIcon(
                  FontAwesomeIcons.users,
                  size: 25,
                ),
                title: Text('Organizaciones')),
          ],
          currentIndex: page,
          unselectedItemColor: Colors.black54,
          selectedItemColor: AppTheme.themeVino,
          onTap: _onItemTapped,
        ),
        body: optionPage[page],
      ),
    );
  }
}

class InformationVoluntary extends StatefulWidget {
  @override
  _InformationVoluntaryState createState() => _InformationVoluntaryState();
}

class _InformationVoluntaryState extends State<InformationVoluntary> {
  final generic = new Generic();
  final prefs = new PreferensUser();
  var result;
  String _esCovid = 'NO';
  Voluntary entityItem;

  @override
  Widget build(BuildContext context) {
    print('prefs.idInstitucion para crear: ${prefs.idInsitucion}');
    print('prefs.idPersonal para crear: ${prefs.idPersonal}');

    final size = MediaQuery.of(context).size;

    if (prefs.idPersonal == '-1' && prefs.idInsitucion != '-1') {
      print('prefs.idPersonalXXXX: ${prefs.idPersonal}');

      return SafeArea(
              child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 5.0),
              Container(
                width: size.width * 0.96,
                margin: EdgeInsets.symmetric(vertical: 0.0),
                child: contenedorTitulo(
                  context,
                  40.0,
                  'INFORMACIÓN DE TU PERFIL',
                  FaIcon(FontAwesomeIcons.city, color: AppTheme.themeVino),
                ),
              ),
              Row(
                children: <Widget>[
                  _crearBotonOrganizacion('Crear Voluntario', context),
                ],
              ),
              copyRigth(),
            ],
          ),
          floatingActionButton: generaFloatbuttonHome(context),
        ),
      );
    }

    if (prefs.idPersonal != '-1' && prefs.idInsitucion != '-1') {
      print('prefs.idInsiTArget: ${prefs.idPersonal}');
      return SafeArea(
              child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 5.0),
              Container(
                width: size.width * 0.96,
                margin: EdgeInsets.symmetric(vertical: 0.0),
                child: contenedorTitulo(
                  context,
                  40.0,
                  'INFORMACIÓN DE TU PERFIL',
                  FaIcon(FontAwesomeIcons.peopleArrows,
                      color: AppTheme.themeVino),
                ),
              ),
              divider(),
              futureItemsEntity(context),
              copyRigth(),
            ],
          ),
          floatingActionButton: generaFloatbuttonHome(context),
        ),
      );
    }
  }

  Widget futureItemsEntity(BuildContext context) {
    return FutureBuilder(
        future: generic.getAll(new Voluntary(),
            urlGetVoluntario + prefs.idPersonal, primaryKeyGetVoluntario),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
              break;
            default:
              return listItemsEntity(context, snapshot);
          }
        });
  }

  Widget listItemsEntity(BuildContext context, AsyncSnapshot snapshot) {
    final size = MediaQuery.of(context).size;

    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: ClampingScrollPhysics(),
        itemCount: snapshot.data.length,
        itemBuilder: (context, index) {
          entityItem = snapshot.data[index];

          return Column(
            children: <Widget>[
              Container(
                width: size.width * 0.97,
                margin: EdgeInsets.symmetric(vertical: 0.0),
                //  decoration: boxDecorationList(),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 0.0),
                      child: Column(
                        children: <Widget>[
                          Align(
                            child: RadialProgress(
                              width: 2.5,
                              goalCompleted: 0.85,
                              progressColor: AppTheme.themeVino,
                              progressBackgroundColor: Colors.white,
                              child: Container(
                                  child: ImageOvalNetwork(
                                      imageNetworkUrl: entityItem.foto,
                                      sizeImage: Size.fromWidth(90))),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text('INFORMACIÓN DE VOLUNTARIADO', style: kSigsTitleStyle),
                    divider(),
                    listEntity(context, entityItem),
                    SizedBox(height: 15.0),
                    Row(
                      children: <Widget>[
                        _crearBotonOrganizacion('Editar Datos', context),
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text('HORARIOS DE ATENCIÓN', style: kSigsTitleStyle),
                    divider(),
                    listEntityAtencion(context, entityItem),
                    SizedBox(height: 10.0),
                    _crearBotonAtencion('Editar Atención', context),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget listEntity(BuildContext context, Voluntary entityItem) {
    if (entityItem.perAyudacovid != 0) _esCovid = 'SI';

    return Container(
      child: Row(
        children: <Widget>[
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.gamepad,
                      color: AppTheme.themeVino,
                      size: 15,
                    ),
                    Expanded(
                      child: Text(
                        '${entityItem.perNombrepersonal} ',
                        style: kSubTitleCardStyle,
                        overflow: TextOverflow.clip,
                        softWrap: true,
                      ),
                    ),
                  ],
                )),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.place,
                      color: AppTheme.themeVino,
                      size: 15,
                    ),
                    Expanded(
                      child: Text(
                          'DOcumento: ${entityItem.perCI} exp.${entityItem.desExpedido} ',
                          style: kSubTitleCardStyle,
                          overflow: TextOverflow.clip,
                          softWrap: true),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.place,
                      color: AppTheme.themeVino,
                      size: 15,
                    ),
                    Expanded(
                      child: Text('Asistencia Covid: $_esCovid',
                          style: kSubTitleCardStyle,
                          overflow: TextOverflow.clip,
                          softWrap: true),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.place,
                      color: AppTheme.themeVino,
                      size: 15,
                    ),
                    Expanded(
                      child: Text('Especialidad: ${entityItem.desEspecialidad}',
                          style: kSubTitleCardStyle,
                          overflow: TextOverflow.clip,
                          softWrap: true),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.place,
                      color: AppTheme.themeVino,
                      size: 15,
                    ),
                    Expanded(
                      child: Text('Teléfono : ${entityItem.perTelefono}',
                          style: kSubTitleCardStyle,
                          overflow: TextOverflow.clip,
                          softWrap: true),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.place,
                      color: AppTheme.themeVino,
                      size: 15,
                    ),
                    Expanded(
                      child: Text('Organización: ${entityItem.desInstitucion}',
                          style: kSubTitleCardStyle,
                          overflow: TextOverflow.clip,
                          softWrap: true),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.place,
                      color: AppTheme.themeVino,
                      size: 15,
                    ),
                    Expanded(
                      child: Text('Correo Electrónico: ${entityItem.perCorreo}',
                          style: kSubTitleCardStyle,
                          overflow: TextOverflow.clip,
                          softWrap: true),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.place,
                      color: AppTheme.themeVino,
                      size: 15,
                    ),
                    Expanded(
                      child: Text('Página Web: ${entityItem.perPaginaWeb}',
                          style: kSubTitleCardStyle,
                          overflow: TextOverflow.clip,
                          softWrap: true),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.place,
                      color: AppTheme.themeVino,
                      size: 15,
                    ),
                    Expanded(
                      child: Text('Facebook: ${entityItem.perFacebbok}',
                          style: kSubTitleCardStyle,
                          overflow: TextOverflow.clip,
                          softWrap: true),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.place,
                      color: AppTheme.themeVino,
                      size: 15,
                    ),
                    Expanded(
                      child: Text('Twitter: ${entityItem.perTwitter}',
                          style: kSubTitleCardStyle,
                          overflow: TextOverflow.clip,
                          softWrap: true),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.place,
                      color: AppTheme.themeVino,
                      size: 15,
                    ),
                    Text(
                      'Información Complementaria:',
                      style: kSubTitleCardStyle,
                    ),
                    Expanded(
                      child: Text('${entityItem.perInformacionComplementaria}',
                          style: kSubTitleCardStyle,
                          overflow: TextOverflow.clip,
                          softWrap: true),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget listEntityAtencion(BuildContext context, Voluntary entityItem) {
    return Column(
      children: <Widget>[
        Row(children: <Widget>[
          Column(
            children: <Widget>[
              Text(
                'Lunes : ${entityItem.lunes == 0 ? '(NO)' : '(SI)'}',
                style: kTitleWelcomeStyle,
              ),
            ],
          ),
          SizedBox(
            width: 35.0,
          ),
          Column(
            children: <Widget>[
              Text(
                'Martes : ${entityItem.martes == 0 ? '(NO)' : '(SI)'}',
                style: kTitleWelcomeStyle,
              ),
            ],
          ),
          SizedBox(
            width: 40.0,
          ),
          Column(
            children: <Widget>[
              Text(
                'Miércoles : ${entityItem.miercoles == 0 ? '(NO)' : '(SI)'}',
                style: kTitleWelcomeStyle,
              ),
            ],
          ),
        ]),
        SizedBox(height: 10.0),
        Row(children: <Widget>[
          Column(
            children: <Widget>[
              Text(
                'Jueves : ${entityItem.jueves == 0 ? '(NO)' : '(SI)'}',
                style: kTitleWelcomeStyle,
              ),
            ],
          ),
          SizedBox(
            width: 20.0,
          ),
          Column(
            children: <Widget>[
              Text(
                'Viernes : ${entityItem.viernes == 0 ? '(NO)' : '(SI)'}',
                style: kTitleWelcomeStyle,
              ),
            ],
          ),
          SizedBox(
            width: 40.0,
          ),
          Column(
            children: <Widget>[
              Text(
                'Sábado : ${entityItem.sabado == 0 ? '(NO)' : '(SI)'}',
                style: kTitleWelcomeStyle,
              ),
            ],
          ),
        ]),
        SizedBox(height: 10.0),
        Row(children: <Widget>[
          Column(
            children: <Widget>[
              Text(
                'Domingo : ${entityItem.domingo == 0 ? '(NO)' : '(SI)'}',
                style: kTitleWelcomeStyle,
              ),
            ],
          ),
        ]),
      ],
    );
  }

  Widget _crearBotonOrganizacion(String text, BuildContext context) {
    return Expanded(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 90.0),
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
          icon: FaIcon(FontAwesomeIcons.edit, color: Colors.white),
          onPressed: () =>
              Navigator.pushNamed(context, 'voluntary', arguments: entityItem),
        ),
      ),
    );
  }

  Widget _crearBotonAtencion(String text, BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 90.0),
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
        icon: FaIcon(FontAwesomeIcons.edit, color: Colors.white),
        onPressed: () => Navigator.pushNamed(context, 'atentionVoluntary',
            arguments: entityItem),
      ),
    );
  }
}
