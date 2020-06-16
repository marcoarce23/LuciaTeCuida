import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:luciatecuida/src/Model/Entity.dart';
import 'package:luciatecuida/src/Model/Generic.dart';
import 'package:luciatecuida/src/Model/PreferenceUser.dart';
import 'package:luciatecuida/src/Theme/ThemeModule.dart';
import 'package:luciatecuida/src/Util/Util.dart';
import 'package:luciatecuida/src/Widget/GeneralWidget.dart';
import 'package:luciatecuida/src/module/HomePage/HomePageModule.dart';
import 'package:luciatecuida/src/module/Settings/RoutesModule.dart';
import 'package:luciatecuida/src/module/UtilModule/PageViewModule.dart';

class ContactGeneralModule extends StatefulWidget {
  static final String routeName = 'ListaContactGeneral';
  ContactGeneralModule({Key key}) : super(key: key);

  @override
  _ContactGeneralModuleState createState() => _ContactGeneralModuleState();
}

class _ContactGeneralModuleState extends State<ContactGeneralModule> {
  final generic = new Generic();
  final prefs = new PreferensUser();
  var result;

  @override
  void initState() {
    prefs.ultimaPagina = ContactGeneralModule.routeName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarOpacity: 0.7,
        iconTheme: IconThemeData(color: AppTheme.themeVino, size: 12),
        elevation: 0,
        title: Text("CONTACTOS DE EMERGENCIA", style: kTitleAppBar),
      ),
      drawer: DrawerCitizen(),
      body: SafeArea(
        child: Container(
          decoration: boxDecorationFondo(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 10.0),
              Container(
                width: size.width * 0.96,
                margin: EdgeInsets.symmetric(vertical: 0.0),
                child: contenedorTitulo(
                  context,
                  40.0,
                  'NÚMEROS PILOTOS DE URGENCIA',
                  FaIcon(FontAwesomeIcons.headset, color: AppTheme.themeVino),
                ),
              ),
              divider(),
              futureItemsEntity(context),
              copyRigth(),
            ],
          ),
        ),
      ),
      floatingActionButton: generaFloatbuttonHome(context),
    );
  }

  Widget futureItemsEntity(BuildContext context) {
    return FutureBuilder(
        future: generic.getAll(
            new Emergencia(), getEmergency, primaryKeyGetEmergency),
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
    //print('tamanio: ${snapshot.hasData}');
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: ClampingScrollPhysics(),
        itemCount: snapshot.data.length,
        itemBuilder: (context, index) {
          Emergencia entityItem = snapshot.data[index];

          return Column(
            children: <Widget>[
              Container(
                width: size.width * 0.97,
                margin: EdgeInsets.symmetric(vertical: 0.0),
                decoration: boxDecorationList(),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: iconEntity(entityItem),
                      title: listEntity(context, entityItem),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8.0),
              //  divider(),
            ],
          );
        },
      ),
    );
  }

  Widget listEntity(BuildContext context, Emergencia entityItem) {
    //print('tamanio: ${entityItem.correo}');
    return Row(
      children: <Widget>[
       
        Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                  width: MediaQuery.of(context).size.width - 110,
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.person,
                        color: AppTheme.themeVino,
                        size: 15,
                      ),
                      Text('${entityItem.nombre} ', style: kTitleCardStyle),
                    ],
                  )),
              Container(
                  child: Row(
                children: <Widget>[
                  Icon(
                    Icons.assignment,
                    color: AppTheme.themeVino,
                    size: 15,
                  ),
                  Text(
                    'Sigla: ${entityItem.abreviacion}',
                    style: kSubTitleCardStyle,
                  ),
                ],
              )),
              Container(
                  child: Row(
                children: <Widget>[
                  Icon(
                    Icons.phone_android,
                    color: AppTheme.themeVino,
                    size: 15,
                  ),
                  Text(
                    'Telefono: ${entityItem.telefono}',
                    style: kSubTitleCardStyle,
                  ),
                ],
              )),
              Container(
                  child: Row(
                children: <Widget>[
                  Icon(
                    Icons.phone_in_talk,
                    color: AppTheme.themeVino,
                    size: 15,
                  ),
                  Text(
                    'Call- Center: ${entityItem.callCenter}',
                    style: kSubTitleCardStyle,
                  ),
                ],
              )),
              Container(
                  child: Row(
                children: <Widget>[
                  Icon(
                    Icons.add_comment,
                    color: AppTheme.themeVino,
                    size: 15,
                  ),
                  Text(
                    'Descripción:',
                    style: kSubTitleCardStyle,
                  ),
                ],
              )),
              AutoSizeText(
                entityItem.descripcion,
                style: kSubTitleCardStyle,
                maxLines: 2,
                minFontSize: 15.0,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 6.0),
              Wrap(
                children: <Widget>[
                  InkWell(
                    child: FaIcon(
                      FontAwesomeIcons.phoneVolume,
                      color: AppTheme.themeVino,
                      size: 25,
                    ),
                    onTap: () {
                      callNumber(entityItem.telefono);
                    },
                  ),
                  SizedBox(width: 20.0),
                  InkWell(
                    child: FaIcon(
                      FontAwesomeIcons.comment,
                      color: AppTheme.themeVino,
                      size: 25,
                    ),
                    onTap: () {
                      sendSMS(entityItem.telefono);
                    },
                  ),
                  SizedBox(width: 20.0),
                  InkWell(
                    child: FaIcon(
                      FontAwesomeIcons.whatsapp,
                      color: AppTheme.themeVino,
                      size: 25,
                    ),
                    onTap: () {
                      callWhatsAppText(entityItem.telefono,
                          'Estimado soy ${prefs.correoElectronico}, deseo consultarle o ponerme en contacto con ud. \nEnviado desde la aplicación *EstamosContigo*.');
                    },
                  ),
                  SizedBox(width: 20.0),
                  InkWell(
                    child: FaIcon(
                      FontAwesomeIcons.internetExplorer,
                      color: AppTheme.themeVino,
                      size: 25,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PageViewModule(
                                  title: 'Pagina emergencia',
                                  selectedUrl: entityItem.correo,
                                )),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
    
      ],
    );
  }

  Container iconEntity(Emergencia entityItem) {
    return Container(
        child: Column(
      children: <Widget>[
        ImageOvalNetwork(
            imageNetworkUrl:
                'https://res.cloudinary.com/propia/image/upload/v1590675803/xxxykvu7m2d4nwk4gaf6.jpg',
            sizeImage: Size.fromWidth(50)),

      ],
    ));
  }
}
