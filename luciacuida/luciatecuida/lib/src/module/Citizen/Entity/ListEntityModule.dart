import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:luciatecuida/src/Model/Entity.dart';
import 'package:luciatecuida/src/Model/Generic.dart';
import 'package:luciatecuida/src/Model/PreferenceUser.dart';
import 'package:luciatecuida/src/Theme/ThemeModule.dart';
import 'package:luciatecuida/src/Util/Util.dart';
import 'package:luciatecuida/src/Widget/GeneralWidget.dart';
import 'package:luciatecuida/src/Widget/Message/Message.dart';
import 'package:luciatecuida/src/module/Settings/RoutesModule.dart';

class ListEntityModule extends StatefulWidget {
  static final String routeName = 'listaEntidad';
  ListEntityModule({Key key}) : super(key: key);

  @override
  _ListEntityModuleState createState() => _ListEntityModuleState();
}

class _ListEntityModuleState extends State<ListEntityModule> {
  final generic = new Generic();
  final prefs = new PreferensUser();
  var result;

  @override
  void initState() {
    prefs.ultimaPagina = ListEntityModule.routeName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 10.0),
            Container(
              width: size.width * 0.96,
              margin: EdgeInsets.symmetric(vertical: 0.0),
              child: contenedorTitulo(
                context,
                40.0,
                'LISTADO DE LAS ORGANIZACIONES',
                FaIcon(FontAwesomeIcons.city, color: AppTheme.themeVino),
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

  Widget futureItemsEntity(BuildContext context) {
    return FutureBuilder(
        future: generic.getAll(
            new Institucion(),
            urlGetInstitucionCreacion + prefs.correoElectronico,
            primaryKeyGetInstitucionCreacion),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
                break;
              default:
                return listItemsEntity(context, snapshot);
            }
          } else {
            return Center(child: CircularProgressIndicator());
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
          Institucion entityItem = snapshot.data[index];

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
              SizedBox(height: 7.0),
              //divider(),
            ],
          );
        },
      ),
    );
  }

  Widget listEntity(BuildContext context, Institucion entityItem) {
    final item = entityItem.idInstitucion;

    return Dismissible(
      key: Key(item.toString()), //UniqueKey(),
      background: Container(
        color: Colors.red,
        padding: EdgeInsets.only(left: 20.0),
        child: Row(
          children: <Widget>[
            Icon(
              Icons.delete_forever,
              color: Colors.white,
              size: 15,
            ),
            Text(
              'Desea eliminar la Organiz.?',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
      onDismissed: (value) {
        setState(() {
          _submit(value, item, entityItem);
        });
      },

      child: Row(
        children: <Widget>[
          Flexible(
                      child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    width: MediaQuery.of(context).size.width - 160,
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
                      'Departamento: ${entityItem.desUbicacion}',
                      style: kSubTitleCardStyle,
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
                      'Telefono: ${entityItem.telefono}',
                      style: kSubTitleCardStyle,
                    ),
                  ],
                )),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.adjust,
                      color: AppTheme.themeVino,
                      size: 15,
                    ),
                    AutoSizeText(
                      'Ubicacion:',
                      style: kSubTitleCardStyle,
                      maxLines: 2,
                      minFontSize: 14.0,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
               
                    AutoSizeText(
                      entityItem.direccion,
                      style: kSubTitleCardStyle,
                      maxLines: 3,
                      minFontSize: 14.0,
                      overflow: TextOverflow.ellipsis,
                    ),
                Wrap(
                  children: <Widget>[
                    InkWell(
                      child: FaIcon(
                        FontAwesomeIcons.phoneVolume,
                        color: AppTheme.themeVino,
                        size: 25,
                      ),
                      onTap: () {
                        callNumber(int.parse(entityItem.telefono));
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
                        sendSMS(int.parse(entityItem.telefono));
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
                            entityItem.perCorreoElectronico,
                            "Colaboración ${entityItem.desInsitucion}",
                            "Estimad@:  ${entityItem.nombreInstitucion}, favor su colaboración en: ");
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
                        callWhatsAppText(int.parse(entityItem.telefono),
                            'Estimado soy ${prefs.correoElectronico}, deseo consultarle o ponerme en contacto con ud. \nEnviado desde la aplicación *SomosUnoBolivia*.');
                      },
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

  _submit(dynamic value, int item, Institucion entityItem) async {
    await generic
        .delete('$urlDeleteInstitucion${item.toString()}/${prefs.userId}')
        .then((respuesta) {
      result = respuesta["TIPO_RESPUESTA"];
      //print('resultado:$result');

      if (result != null || result != '-1')
        Scaffold.of(context).showSnackBar(messageOk(
            "Se elimino la Organización. ${entityItem.nombreInstitucion}"));
      else
        Scaffold.of(context).showSnackBar(
            messageNOk("Se  produjo un error. Vuelva a intentarlo."));
    });
  }

  Container iconEntity(Institucion entityItem) {
    return Container(
        child: Column(
      children: <Widget>[
        ImageOvalNetwork(
            imageNetworkUrl: entityItem.foto, sizeImage: Size.fromWidth(40)),
        SizedBox(
          height: 1.5,
        ),
        Text(
          '${entityItem.desInsitucion}',
          style: TextStyle(
              fontSize: 12, color: Colors.black87, fontWeight: FontWeight.w400),
        ),
      ],
    ));
  }
}
