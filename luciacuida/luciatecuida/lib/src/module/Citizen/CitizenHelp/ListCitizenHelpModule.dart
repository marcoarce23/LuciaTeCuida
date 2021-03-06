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

class ListCitizenHelpModule extends StatefulWidget {
  static final String routeName = 'ListaCiudadanoAyuda';
  @override
  _ListCitizenHelpModuleState createState() => _ListCitizenHelpModuleState();
}

class _ListCitizenHelpModuleState extends State<ListCitizenHelpModule> {
  final generic = new Generic();
  final prefs = new PreferensUser();
  var result;

  @override
  void initState() {
    prefs.ultimaPagina = ListCitizenHelpModule.routeName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
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
                'LISTADO DE AYUDA A UN AMIGO.',
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
      floatingActionButton: generaFloatbuttonHome(context),
    );
  }

  Widget futureItemsEntity(BuildContext context) {
    return FutureBuilder(
        future: generic.getAll(
            new RegistroAmigo(),
            urlGetDevuelveAyuda + '/' + prefs.correoElectronico,
            primaryKeyGetAyudaAmigo),
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
          RegistroAmigo entityItem = snapshot.data[index];

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

  Widget listEntity(BuildContext context, RegistroAmigo entityItem) {
    final item = entityItem.idcovRegistroAmigo;

    return Dismissible(
      key: Key(item.toString()), //UniqueKey(),
      background: Container(
        color: Colors.red,
        padding: EdgeInsets.only(left: 20.0),
        child: Text(
          'Eliminar registro',
          style: TextStyle(color: Colors.white),
        ),
      ),
      onDismissed: (value) {
        setState(() {
           _submit(item);          //print('resultado:$result');
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
                    width: MediaQuery.of(context).size.width - 110,
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.gamepad,
                          color: AppTheme.themeVino,
                          size: 15,
                        ),
                        Expanded(
                          child: Text(
                            '${entityItem.regPersona} ',
                            style: kTitleCardStyle,
                            softWrap: true,
                            overflow: TextOverflow.clip,
                          ),
                        ),
                      ],
                    )),
                // Row(
                //   children: <Widget>[
                //     Icon(
                //       Icons.place,
                //       color: AppTheme.themeVino,
                //       size: 15,
                //     ),
                //     Text('Prioridad: ${entityItem.}',
                //         style: kSubTitleCardStyle)
                //   ],
                // ),
                Container(
                    child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.phone_android,
                      color: AppTheme.themeVino,
                      size: 15,
                    ),
                    Expanded(
                      child: Text(
                        'Telefono: ${entityItem.regTelefono}',
                        style: kSubTitleCardStyle,
                        softWrap: true,
                        overflow: TextOverflow.clip,
                      ),
                    ),
                  ],
                )),
                // Container(
                //   width: MediaQuery.of(context).size.width,
                //   child: Row(
                //     children: <Widget>[
                //       Icon(
                //         Icons.store_mall_directory,
                //         color: AppTheme.themeVino,
                //         size: 15,
                //       ),
                //       Text(
                //         'Ubicacion: ${entityItem.regUbicacion}',
                //         style: kSubTitleCardStyle,
                //       )
                //     ],
                //   ),
                // ),

                Container(
                  width: MediaQuery.of(context).size.width - 80,
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.store_mall_directory,
                        color: AppTheme.themeVino,
                        size: 15,
                      ),
                      Expanded(
                        child: Text(
                          'Ubicació:  ${entityItem.regUbicacion}',
                          style: kSubTitleCardStyle,
                          softWrap: true,
                          overflow: TextOverflow.clip,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


 _submit(int item) async
 {
    await generic.add(new RegistroAmigo(),
              '$urlDeleteAyudaAmigo${item.toString()}/${prefs.userId}').then((respuesta) {
            result = respuesta["TIPO_RESPUESTA"];

            if (result != null || result != '-1')
              Scaffold.of(context)
                  .showSnackBar(messageOk("Se eliminó el registro."));
            else
              Scaffold.of(context).showSnackBar(
                  messageNOk("Se produjo un error. Vuelva a intentarlo."));
          });

 }
  Container iconEntity(RegistroAmigo entityItem) {
    return Container(
        child: Column(
      children: <Widget>[
        ImageOvalNetwork(
            imageNetworkUrl:
                'http://res.cloudinary.com/propia/image/upload/v1592167496/djsbl74vjdwtso6zrst7.jpg',
            sizeImage: Size.fromWidth(40)),
        SizedBox(
          height: 1.5,
        ),
        Text(
          '${entityItem.regPrioridad}',
          style: TextStyle(
              fontSize: 12, color: Colors.black87, fontWeight: FontWeight.w400),
        ),
      ],
    ));
  }
}
