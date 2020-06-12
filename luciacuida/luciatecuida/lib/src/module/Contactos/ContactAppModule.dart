import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:luciatecuida/src/Model/Entity.dart';
import 'package:luciatecuida/src/Model/Generic.dart';
import 'package:luciatecuida/src/Model/PreferenceUser.dart';
import 'package:luciatecuida/src/Theme/ThemeModule.dart';
import 'package:luciatecuida/src/Util/Util.dart';
import 'package:luciatecuida/src/Widget/GeneralWidget.dart';
import 'package:luciatecuida/src/module/Settings/RoutesModule.dart';

class ContactAppModule extends StatefulWidget {
  static final String routeName = 'ListaContactApp';
  ContactAppModule({Key key}) : super(key: key);

  @override
  _ContactAppModuleState createState() => _ContactAppModuleState();
}

class _ContactAppModuleState extends State<ContactAppModule> {
  final generic = new Generic();
  final prefs = new PreferensUser();
  var result;

  @override
  void initState() {
    prefs.ultimaPagina = ContactAppModule.routeName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
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
                  'ENCUENTRANOS AQUÍ',
                  FaIcon(FontAwesomeIcons.handHoldingHeart,
                      color: AppTheme.themeVino),
                ),
              ),
              divider(),
              futureItemsEntity(context),
              copyRigth(),
            ],
          ),
        ),
      ),
    );
  }

  Widget futureItemsEntity(BuildContext context) {
    return FutureBuilder(
        future: generic.getAll(
            new Contactos(), getContactos, primaryKeyGetContacto),
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
          Contactos entityItem = snapshot.data[index];

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

  Widget listEntity(BuildContext context, Contactos entityItem) {
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
              width: MediaQuery.of(context).size.width - 80,
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.mail_outline,
                    color: AppTheme.themeVino,
                    size: 15,
                  ),
                  RichText(
                    overflow: TextOverflow.clip,
                    text: TextSpan(
                      text: 'Correo: ${entityItem.correo}',
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          //  Text('Puedes contactactarte por aca',
          //             style: TextStyle(fontSize: 15, color: Colors.black87),
          //           ),
            SizedBox(height:7.0),
           
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
                      FontAwesomeIcons.mailBulk,
                      color: AppTheme.themeVino,
                      size: 25,
                    ),
                    onTap: () {
                      sendEmailAdvanced(
                          entityItem.correo,
                          "Colaboración ${entityItem.telefono}",
                          "Estimad@:  ${entityItem.telefono}, favor su colaboración en: ");
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
                      callWhatsAppText(entityItem.telefono, 'Estimado soy ${prefs.correoElectronico}, deseo consultarle o ponerme en contacto con ud. \nEnviado desde la aplicación *EstamosContigo*.' );
                    },
                  )
                ],
              ),
          ],
        ),
      ],
    );
  }

  Container iconEntity(Contactos entityItem) {
    return Container(
        child: Column(
      children: <Widget>[
        ImageOvalNetwork(
            imageNetworkUrl:
                'https://res.cloudinary.com/propia/image/upload/v1590675803/xxxykvu7m2d4nwk4gaf6.jpg',
            sizeImage: Size.fromWidth(50)),
        // SizedBox(
        //   height: 1.5,
        // ),
        // Text(
        //   '${entityItem.regPrioridad}',
        //   style: TextStyle(
        //       fontSize: 12, color: Colors.black87, fontWeight: FontWeight.w400),
        // ),
      ],
    ));
  }
}
