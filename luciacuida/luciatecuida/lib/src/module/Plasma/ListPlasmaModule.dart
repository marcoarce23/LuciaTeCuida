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

class ListPlasmaModule extends StatefulWidget {
  static final String routeName = 'ListaPlasma';
  ListPlasmaModule({Key key}) : super(key: key);

  @override
  _ListPlasmaModuleState createState() => _ListPlasmaModuleState();
}

class _ListPlasmaModuleState extends State<ListPlasmaModule> {
  final generic = new Generic();
  final prefs = new PreferensUser();
  var result;

  @override
  void initState() {
    prefs.ultimaPagina = ListPlasmaModule.routeName;
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
                'LISTADO DE BANCO DE PLASMA.',
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
            new BancoPlasma(),
            urlGetPlasma + prefs.idDepartamento.toString(),
            primaryKeyGetPlasma),
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
          BancoPlasma entityItem = snapshot.data[index];

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

  Widget listEntity(BuildContext context, BancoPlasma entityItem) {
    final item = entityItem.idCovBancoPlasma;

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
          _submit(item); //print('resultado:$result');
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
                          Icons.account_box,
                          color: AppTheme.themeVino,
                          size: 15,
                        ),
                        Expanded(
                          child: Text(
                            '${entityItem.nombrePersona} ',
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
                      Icons.accessibility_new,
                      color: AppTheme.themeVino,
                      size: 15,
                    ),
                    Expanded(
                      child: Text(
                        'Edad: ${entityItem.edad}',
                        style: kSubTitleCardStyle,
                        softWrap: true,
                        overflow: TextOverflow.clip,
                      ),
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
                    Expanded(
                      child: Text(
                        'Telefono: ${entityItem.telefono}',
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
                          'Dirección:',
                          style: kSubTitleCardStyle,
                          softWrap: true,
                          overflow: TextOverflow.clip,
                        ),
                      ),
                    ],
                  ),
                ),

                AutoSizeText(
                  entityItem.direccion,
                  style: kSubTitleCardStyle,
                  maxLines: 2,
                  minFontSize: 15.0,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.justify,
                ),
                // Container(
                //     child: Row(
                //   children: <Widget>[
                //     Icon(
                //       Icons.phone_android,
                //       color: AppTheme.themeVino,
                //       size: 15,
                //     ),
                //     Expanded(
                //       child: Text(
                //         'Tipo Sangre: ${entityItem.tipoSangre}',
                //         style: kSubTitleCardStyle,
                //         softWrap: true,
                //         overflow: TextOverflow.clip,
                //       ),
                //     ),
                //   ],
                // )),

                // Container(
                //     child: Row(
                //   children: <Widget>[
                //     Icon(
                //       Icons.phone_android,
                //       color: AppTheme.themeVino,
                //       size: 15,
                //     ),
                //     Expanded(
                //       child: Text(
                //         'Tipo Factor: ${entityItem.tipoFactor}',
                //         style: kSubTitleCardStyle,
                //         softWrap: true,
                //         overflow: TextOverflow.clip,
                //       ),
                //     ),
                //   ],
                // )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _submit(int item) async {
    await generic
        .add(new BancoPlasma(),
            '$urlDeletePlasma${item.toString()}/${prefs.correoElectronico}')
        .then((respuesta) {
      result = respuesta["TIPO_RESPUESTA"];

      if (result != null || result != '-1')
        Scaffold.of(context).showSnackBar(messageOk("Se eliminó el registro."));
      else
        Scaffold.of(context).showSnackBar(
            messageNOk("Se produjo un error. Vuelva a intentarlo."));
    });
  }

  Container iconEntity(BancoPlasma entityItem) {
    print('fotooo: ${entityItem.foto}');
    return Container(
        child: Column(
      children: <Widget>[
        ImageOvalNetwork(
            imageNetworkUrl: entityItem.foto, sizeImage: Size.fromWidth(40)),
        SizedBox(
          height: 1.5,
        ),
        Text(
          '${entityItem.tipoSangre} - ${entityItem.tipoFactor}',
          style: TextStyle(
              fontSize: 12, color: Colors.black87, fontWeight: FontWeight.w400),
        ),
      ],
    ));
  }
}
