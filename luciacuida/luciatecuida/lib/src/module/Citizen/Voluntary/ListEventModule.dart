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

class ListEventModule extends StatefulWidget {
  static final String routeName = 'ListEventVoluntary';
  ListEventModule({Key key}) : super(key: key);

  @override
  _ListEventModuleState createState() => _ListEventModuleState();
}

class _ListEventModuleState extends State<ListEventModule> {
  final generic = new Generic();
  final prefs = new PreferensUser();
  var result;

  @override
  void initState() {
    super.initState();
    prefs.ultimaPagina = ListEventModule.routeName;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 10.0),
          Container(
            width: size.width * 0.96,
            margin: EdgeInsets.symmetric(vertical: 0.0),
            child: contenedorTitulo(
              context,
              40.0,
              'LISTADO DE EVENTOS',
              FaIcon(FontAwesomeIcons.city, color: AppTheme.themeVino),
            ),
          ),
          divider(),
          futureItemsEntity(context),
          copyRigth(),
        ],
      ),
    );
  }

  Widget futureItemsEntity(BuildContext context) {
    return FutureBuilder(
        future: generic.getAll(
            new Evento(),
            urlGetEvento + prefs.idInsitucion + '/${prefs.idPersonal}',
            primaryKeyGetEvento),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
              break;
            default:
              //mostramos los datos
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
          Evento entityItem = snapshot.data[index];

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
              divider(),
            ],
          );
        },
      ),
    );
  }

  Widget listEntity(BuildContext context, Evento entityItem) {
    final item = entityItem.idcovPersonal;

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
          final dataMap = generic.add(entityItem,
              '$urlDeleteVoluntario${item.toString()}/${prefs.idPersonal}');

          dataMap.then((respuesta) => result = respuesta["TIPO_RESPUESTA"]);
          print('resultado:$result');
        });

        if (result != null || result != '-1')
          Scaffold.of(context)
              .showSnackBar(messageOk("Se elimino el registro."));
        else
          Scaffold.of(context).showSnackBar(
              messageNOk("Se  produjo un error. Vuelva a intentarlo."));
      },

      child: Row(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                  width: MediaQuery.of(context).size.width - 160,
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.gamepad,
                        color: AppTheme.themeVino,
                        size: 15,
                      ),
                      Text('Evento: ${entityItem.eveTitulo} ',
                          style: kTitleCardStyle),
                    ],
                  )),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.place,
                    color: AppTheme.themeVino,
                    size: 15,
                  ),
                  Text('Objetivo: ${entityItem.eveObjetivo}',
                      style: kSubTitleCardStyle)
                ],
              ),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.map,
                    color: AppTheme.themeVino,
                    size: 15,
                  ),
                  Text(
                    'Lugar: ${entityItem.eveUbicacion}',
                    style: kSubTitleCardStyle,
                  ),
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
                    'Fecha: ${entityItem.eveFecha} - Hora: ${entityItem.eveHora}',
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

  Container iconEntity(Evento entityItem) {
    return Container(
        child: Column(
      children: <Widget>[
        ImageOvalNetwork(
            imageNetworkUrl: entityItem.eveFoto, sizeImage: Size.fromWidth(40)),
        Text(
          '${entityItem.eveFecha}',
          style: TextStyle(
              fontSize: 11,
              color: AppTheme.themeVino,
              fontWeight: FontWeight.w400),
        ),
      ],
    ));
  }
}
