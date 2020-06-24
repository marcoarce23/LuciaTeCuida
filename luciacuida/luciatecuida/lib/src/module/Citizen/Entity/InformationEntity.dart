import 'package:auto_size_text/auto_size_text.dart';
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
import 'package:luciatecuida/src/module/HomePage/HomePageModule.dart';
import 'package:luciatecuida/src/module/Settings/RoutesModule.dart';

class EntityAllModule extends StatefulWidget {
  static final String routeName = 'entidadGeneral';
  const EntityAllModule({Key key}) : super(key: key);

  @override
  _EntityAllModuleState createState() => _EntityAllModuleState();
}

class _EntityAllModuleState extends State<EntityAllModule> {
  final prefs = new PreferensUser();
  final generic = new Generic();
  int page = 0;

  final List<Widget> optionPage = [
    InformationEntityModule(),
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
        title: Text("INSTITUCIONES", style: kTitleAppBar),
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
                FontAwesomeIcons.fileInvoice,
                size: 25,
              ),
              title: Text('Registro')),
          BottomNavigationBarItem(
              icon: FaIcon(
                FontAwesomeIcons.school,
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
    );
  }
}

class InformationEntityModule extends StatefulWidget {
  InformationEntityModule({Key key}) : super(key: key);

  @override
  _InformationEntityModuleState createState() =>
      _InformationEntityModuleState();
}

class _InformationEntityModuleState extends State<InformationEntityModule> {
  final generic = new Generic();
  final prefs = new PreferensUser();
  var result;
  String _esCovid = 'NO';
  Institucion entityItem;

  @override
  void initState() {
    prefs.ultimaPagina = ListEntityModule.routeName;
    super.initState();
  }

 

  // Widget _crearImagen(BuildContext context) {
  //   return Container(
  //     width: double.infinity,
  //     child: GestureDetector(
  //       onTap: () {},
  //       child: Image(
  //         image: NetworkImage(
  //             'https://images.pexels.com/photos/814499/pexels-photo-814499.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
  //         height: 160.0,
  //         fit: BoxFit.cover,
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    //print(        'prefs.idCreacionInsitucion para crear: ${prefs.idCreacionInsitucion}');
    final size = MediaQuery.of(context).size;

    if (prefs.idCreacionInsitucion == 0) {
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
              SizedBox(height: 10.0),
              AutoSizeText(
                'INFORMACIÓN IMPORTANTE',
                style: kSubTitleCardStyle,
                maxLines: 2,
                minFontSize: 15.0,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.0),
              AutoSizeText(
                '1. Token = Un número de seis (6) caracteres.',
                style: kSubTitleCardStyle,
                maxLines: 2,
                minFontSize: 15.0,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.justify,
              ),
              AutoSizeText(
                '2. Ingresar la cuenta de Facebook (Si tuviera).',
                style: kSubTitleCardStyle,
                maxLines: 2,
                minFontSize: 15.0,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.justify,
              ),
              AutoSizeText(
                '3. Ingresar la cuenta de Twitter (Si tuviera).',
                style: kSubTitleCardStyle,
                maxLines: 2,
                minFontSize: 15.0,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.justify,
              ),
              AutoSizeText(
                '4. Ingresar su cuenta YouTube (Si tuviera).',
                style: kSubTitleCardStyle,
                maxLines: 2,
                minFontSize: 15.0,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.justify,
              ),
              AutoSizeText(
                '5. Ingresar su página Web/Bloc (Si tuviera).',
                style: kSubTitleCardStyle,
                maxLines: 2,
                minFontSize: 15.0,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 10.0),
              Row(
                children: <Widget>[
                  _crearBotonOrganizacion('Crear Organización'),
                ],
              ),
              copyRigth(),
            ],
          ),
          floatingActionButton: generaFloatbuttonHome(context),
        ),
      );
    } else {
      //print('prefs.idCreacionInsitucion ELSEE: ${prefs.idCreacionInsitucion}');
      return Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 5.0),
            Container(
              // width: size.width * 0.96,
              margin: EdgeInsets.symmetric(vertical: 0.0),
              child: contenedorTitulo(
                context,
                40.0,
                'INFORMACIÓN DE TU ORGANIZACIÓN',
                FaIcon(FontAwesomeIcons.city, color: AppTheme.themeVino),
              ),
            ),
            divider(),
            futureItemsEntity(context),
            copyRigth(),
          ],
        ),
        floatingActionButton: generaFloatbuttonHome(context),
      );
    }
  }

  Widget futureItemsEntity(BuildContext context) {
    return FutureBuilder(
        future: generic.getAll(new Institucion(),
            urlGetInstitucion + prefs.idCreacionInsitucion.toString(), primaryKeyGetInsitucion),
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
                      padding: EdgeInsets.only(top: 3.0),
                      child: Column(
                        children: <Widget>[
                          Align(
                            child: RadialProgress(
                              width: 4,
                              goalCompleted: 0.90,
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
                    Text('ANTES DE CREAR TU ORGANIZACIÓN',
                        style: kSigsTitleStyle),
                    divider(),
                    listEntity(context, entityItem),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: <Widget>[
                        _crearBotonOrganizacion('Editar Datos'),
                      ],
                    ),
                    SizedBox(
                      height: 14.0,
                    ),
                    Text('HORARIOS DE ATENCIÓN', style: kSigsTitleStyle),
                    divider(),
                    SizedBox(
                      height: 7.0,
                    ),
                    listEntityAtencion(context, entityItem),
                    SizedBox(
                      height: 7.0,
                    ),
                    _crearBotonAtencion('Editar Atención'),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget listEntity(BuildContext context, Institucion entityItem) {
    if (entityItem.esSucursal != 0) _esCovid = 'SI';

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
                      Icons.business,
                      color: AppTheme.themeVino,
                      size: 15,
                    ),
                    Text(
                      '${entityItem.nombreInstitucion} ',
                      style: kSubTitleCardStyle,
                      overflow: TextOverflow.clip,
                      softWrap: true,
                    ),
                  ],
                )),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.calendar_view_day,
                      color: AppTheme.themeVino,
                      size: 15,
                    ),
                    Expanded(
                      child: Text(
                        'Token (Código de Seguridad) : ${entityItem.token}',
                        style: kSubTitleCardStyle,
                        overflow: TextOverflow.clip,
                        softWrap: true,
                      ),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.map,
                      color: AppTheme.themeVino,
                      size: 15,
                    ),
                    Expanded(
                      child: Text(
                        'Departamento: ${entityItem.desUbicacion}',
                        style: kSubTitleCardStyle,
                        overflow: TextOverflow.clip,
                        softWrap: true,
                      ),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.adjust,
                      color: AppTheme.themeVino,
                      size: 15,
                    ),
                    Expanded(
                      child: Text(
                        'Sucursal: $_esCovid',
                        style: kSubTitleCardStyle,
                        overflow: TextOverflow.clip,
                        softWrap: true,
                      ),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.chat,
                      color: AppTheme.themeVino,
                      size: 15,
                    ),
                    Expanded(
                      child: Text(
                        'Tipo de Institución: ${entityItem.desInsitucion}',
                        style: kSubTitleCardStyle,
                        overflow: TextOverflow.clip,
                        softWrap: true,
                      ),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.phone_android,
                      color: AppTheme.themeVino,
                      size: 15,
                    ),
                    Expanded(
                      child: Text(
                        'Teléfono : ${entityItem.telefono}',
                        style: kSubTitleCardStyle,
                        overflow: TextOverflow.clip,
                        softWrap: true,
                      ),
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
                      child: Text(
                        'Ubicación: ${entityItem.direccion}',
                        style: kSubTitleCardStyle,
                        overflow: TextOverflow.clip,
                        softWrap: true,
                      ),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.mail,
                      color: AppTheme.themeVino,
                      size: 15,
                    ),
                    Expanded(
                      child: Text(
                        'Correo Electrónico: ${entityItem.perCorreoElectronico}',
                        style: kSubTitleCardStyle,
                        overflow: TextOverflow.clip,
                        softWrap: true,
                      ),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.featured_play_list,
                      color: AppTheme.themeVino,
                      size: 15,
                    ),
                    Text(
                      'Información Complementaria:',
                      style: kSubTitleCardStyle,
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    AutoSizeText(
                      entityItem.perInformacionComp,
                      style: kSubTitleCardStyle,
                      maxLines: 2,
                      minFontSize: 15.0,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                          'Tus RRSS :',
                          style: kSubTitleCardStyle,
                        ),
                      ],
                    ),
                    SizedBox(width: 10.0),
                    Column(
                      children: <Widget>[
                        generaHTTP_ICON(
                          entityItem.perPaginaWeb,
                          FaIcon(
                            FontAwesomeIcons.chrome,
                            size: 25,
                            color: AppTheme.themeVino,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 10.0),
                    Column(
                      children: <Widget>[
                        generaHTTP_ICON(
                          entityItem.perFacebbok,
                          FaIcon(
                            FontAwesomeIcons.facebook,
                            size: 25,
                            color: AppTheme.themeVino,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 10.0),
                    Column(
                      children: <Widget>[
                        generaHTTP_ICON(
                          entityItem.perTwitter,
                          FaIcon(
                            FontAwesomeIcons.twitter,
                            size: 25,
                            color: AppTheme.themeVino,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 10.0),
                    Column(
                      children: <Widget>[
                        generaHTTP_ICON(
                          entityItem.perYouTube,
                          FaIcon(
                            FontAwesomeIcons.youtube,
                            size: 25,
                            color: AppTheme.themeVino,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 10.0),
                    Column(
                      children: <Widget>[
                        generaHTTP_ICON(
                          entityItem.perPaginaWeb,
                          FaIcon(
                            FontAwesomeIcons.edge,
                            size: 25,
                            color: AppTheme.themeVino,
                          ),
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
    );
  }

  Widget listEntityAtencion(BuildContext context, Institucion entityItem) {
    return Container(
      child: Row(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                  child: Row(
                children: <Widget>[
                  Icon(
                    Icons.calendar_today,
                    color: AppTheme.themeVino,
                    size: 15,
                  ),
                  Text(
                    'Lunes : ${entityItem.lunesH} ',
                    style: kTitleWelcomeStyle,
                  ),
                ],
              )),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.calendar_today,
                    color: AppTheme.themeVino,
                    size: 15,
                  ),
                  Text(
                    'Martes: ${entityItem.martesH}',
                    style: kTitleWelcomeStyle,
                  )
                ],
              ),
              Container(
                  child: Row(
                children: <Widget>[
                  Icon(
                    Icons.calendar_today,
                    color: AppTheme.themeVino,
                    size: 15,
                  ),
                  Text(
                    'Miercoles: ${entityItem.miercolesH}',
                    style: kTitleWelcomeStyle,
                  ),
                ],
              )),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.calendar_today,
                    color: AppTheme.themeVino,
                    size: 15,
                  ),
                  Text(
                    'Jueves: ${entityItem.juevesH}',
                    style: kTitleWelcomeStyle,
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.calendar_today,
                    color: AppTheme.themeVino,
                    size: 15,
                  ),
                  Text(
                    'Viernes: ${entityItem.viernesH}',
                    style: kTitleWelcomeStyle,
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.calendar_today,
                    color: AppTheme.themeVino,
                    size: 15,
                  ),
                  Text(
                    'Sábado: ${entityItem.sabadoH}',
                    style: kTitleWelcomeStyle,
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.calendar_today,
                    color: AppTheme.themeVino,
                    size: 15,
                  ),
                  Text(
                    'Domingo: ${entityItem.domingoH}',
                    style: kTitleWelcomeStyle,
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _crearBotonOrganizacion(String text) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 60.0),
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
              Navigator.pushNamed(context, 'entidad', arguments: entityItem),
        ),
      ),
    );
  }

  Widget _crearBotonAtencion(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 80.0),
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
        onPressed: () => Navigator.pushNamed(context, 'AtentionEntity',
            arguments: entityItem),
      ),
    );
  }
}
