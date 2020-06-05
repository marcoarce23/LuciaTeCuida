import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:luciatecuida/src/Model/Entity.dart';
import 'package:luciatecuida/src/Model/Generic.dart';
import 'package:luciatecuida/src/Model/PreferenceUser.dart';
import 'package:luciatecuida/src/Theme/ThemeModule.dart';
import 'package:luciatecuida/src/Util/Util.dart';
import 'package:luciatecuida/src/Widget/GeneralWidget.dart';
import 'package:luciatecuida/src/module/Settings/RoutesModule.dart';

// class VoluntaryAllModule extends StatefulWidget {
//   static final String routeName = 'voluntario';
//   const VoluntaryAllModule({Key key}) : super(key: key);

//   @override
//   _VoluntaryAllModuleState createState() => _VoluntaryAllModuleState();
// }

// class _VoluntaryAllModuleState extends State<VoluntaryAllModule> {
//   final prefs = new PreferensUser();
//   final generic = new Generic();
//   int page = 0;

//   final List<Widget> optionPage = [
//     InformationVoluntary(),
//     VoluntaryModule(),
//    // AtentionModule(),
//     ListVoluntaryModule()
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       page = index;
//     });
//   }

//   @override
//   void initState() {
//     prefs.ultimaPagina = VoluntaryAllModule.routeName;
//     page = 0;
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         toolbarOpacity: 0.7,
//         iconTheme: IconThemeData(color: AppTheme.themeVino, size: 12),
//         elevation: 0,
//         title: Text("VOLUNTARIO", style: kTitleAppBar),
//         actions: <Widget>[
//           IconButton(
//             icon: Icon(Icons.search),
//             onPressed: () {
//               showSearch(context: context, delegate: DataSearchVoluntary());
//             },
//           )
//         ],
//       ),
//       drawer: DrawerCitizen(),
//       bottomNavigationBar: BottomNavigationBar(
//         backgroundColor: Colors.white,
//         items: [
//           BottomNavigationBarItem(
//               icon: FaIcon(
//                 FontAwesomeIcons.userCircle,
//                 size: 25,
//               ),
//               title: Text('Voluntario')),
//           BottomNavigationBarItem(
//               icon: FaIcon(
//                 FontAwesomeIcons.calendarCheck,
//                 size: 25,
//               ),
//               title: Text('Atención')),
//           BottomNavigationBarItem(
//               icon: FaIcon(
//                 FontAwesomeIcons.users,
//                 size: 25,
//               ),
//               title: Text('Integrantes')),
//         ],
//         currentIndex: page,
//         unselectedItemColor: Colors.black54,
//         selectedItemColor: AppTheme.themeVino,
//         onTap: _onItemTapped,
//       ),
//       body: optionPage[page],
//     );
//   }
// }

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

      return Scaffold(
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
      );
    }

    if (prefs.idPersonal != '-1' && prefs.idInsitucion != '-1') {
      print('prefs.idInsiTArget: ${prefs.idPersonal}');
      return Scaffold(
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
                    Text('INFORMACIÓN DE VOLUNTARIADO', style: kSigsTitleStyle),
                    SizedBox(
                      height: 7.0,
                    ),
                    listEntity(context, entityItem),
                    divider(),
                    Row(
                      children: <Widget>[
                        _crearBotonOrganizacion('Editar Información', context),
                      ],
                    ),
                    divider(),
                    Text('HORARIOS DE ATENCIÓN', style: kSigsTitleStyle),
                    SizedBox(
                      height: 7.0,
                    ),
                    listEntityAtencion(context, entityItem),
                    divider(),
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
          Column(
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
                  Text(
                    '${entityItem.perNombrepersonal} ',
                    style: kSubTitleCardStyle,
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
                  Text(
                    'DOcumento: ${entityItem.perCI} exp.${entityItem.desExpedido} ',
                    style: kSubTitleCardStyle,
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
                    'Asistencia Covid: $_esCovid',
                    style: kSubTitleCardStyle,
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
                    'Especialidad: ${entityItem.desEspecialidad}',
                    style: kSubTitleCardStyle,
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
                    'Teléfono : ${entityItem.perTelefono}',
                    style: kSubTitleCardStyle,
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
                    'Organización: ${entityItem.desInstitucion}',
                    style: kSubTitleCardStyle,
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
                    'Correo Electrónico: ${entityItem.perCorreo}',
                    style: kSubTitleCardStyle,
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
                    'Página Web: ${entityItem.perPaginaWeb}',
                    style: kSubTitleCardStyle,
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
                    'Facebook: ${entityItem.perFacebbok}',
                    style: kSubTitleCardStyle,
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
                    'Twitter: ${entityItem.perTwitter}',
                    style: kSubTitleCardStyle,
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
                  Text(
                    '${entityItem.perInformacionComplementaria}',
                    style: kSubTitleCardStyle,
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget listEntityAtencion(BuildContext context, Voluntary entityItem) {
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
                    Icons.gamepad,
                    color: AppTheme.themeVino,
                    size: 15,
                  ),
                  Text(
                    'Lunes : ${entityItem.lunes} ',
                    style: kTitleWelcomeStyle,
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
                  Text(
                    'Martes: ${entityItem.martes}',
                    style: kTitleWelcomeStyle,
                  )
                ],
              ),
              Container(
                  child: Row(
                children: <Widget>[
                  Icon(
                    Icons.phone_android,
                    color: AppTheme.themeVino,
                    size: 15,
                  ),
                  Text(
                    'Miercoles: ${entityItem.miercoles == 0 ? 'SI' : 'NO' }',
                    style: kTitleWelcomeStyle,
                  ),
                ],
              )),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.store_mall_directory,
                    color: AppTheme.themeVino,
                    size: 15,
                  ),
                  Text(
                    'Jueves: ${entityItem.jueves== 0 ? 'SI' : 'NO' }',
                    style: kTitleWelcomeStyle,
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.store_mall_directory,
                    color: AppTheme.themeVino,
                    size: 15,
                  ),
                  Text(
                    'Viernes: ${atiende(entityItem.viernes)}',
                    style: kTitleWelcomeStyle,
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.store_mall_directory,
                    color: AppTheme.themeVino,
                    size: 15,
                  ),
                  Text(
                    'Sábado: ${atiende(entityItem.sabado)}',
                    style: kTitleWelcomeStyle,
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.store_mall_directory,
                    color: AppTheme.themeVino,
                    size: 15,
                  ),
                  Text(
                    'Domingo: ${atiende(entityItem.domingo)}',
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

  String atiende(int value)
  {
     if (value == 0)
      return 'No atiende';
    else
    return 'Atiende';
  }

  Widget _crearBotonOrganizacion(String text, BuildContext context) {
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
        onPressed: () =>
            Navigator.pushNamed(context, 'voluntary', arguments: entityItem),
      ),
    );
  }

  Widget _crearBotonAtencion(String text, BuildContext context) {
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
        onPressed: () => Navigator.pushNamed(context, 'atentionVoluntary',
            arguments: entityItem),
      ),
    );
  }
}
