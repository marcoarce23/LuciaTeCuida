import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:luciatecuida/src/Model/Entity.dart';
import 'package:luciatecuida/src/Model/Generic.dart';
import 'package:luciatecuida/src/Model/PreferenceUser.dart';
import 'package:luciatecuida/src/Theme/ThemeModule.dart';
import 'package:luciatecuida/src/Util/Util.dart';
import 'package:luciatecuida/src/Widget/GeneralWidget.dart';
import 'package:luciatecuida/src/module/Settings/RoutesModule.dart';

class ListMultimediaModule extends StatefulWidget {
  static final String routeName = 'listMultimedia';
  const ListMultimediaModule({
    Key key,
  }) : super(key: key);

  @override
  _ListMultimediaModuleState createState() => _ListMultimediaModuleState();
}

class _ListMultimediaModuleState extends State<ListMultimediaModule> {
  final generic = new Generic();
  final prefs = new PreferensUser();
  var result;
  int _group = 0;
  int _selectedRadio = 74;

  @override
  void initState() {
    prefs.ultimaPagina = ListMultimediaModule.routeName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

print('valor selecteradio es: $_selectedRadio');
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
                'LISTADO MATERIAL MULTIMEDIA',
                FaIcon(FontAwesomeIcons.photoVideo, color: AppTheme.themeVino),
              ),
            ),
            Row(
              children: <Widget>[
                SizedBox(width: 10.0),
                //  FaIcon(FontAwesomeIcons.male, color: AppTheme.themeVino),
                SizedBox(width: 5.0),
                Text('Imágenes'),
                Radio(
                  value: 0,
                  groupValue: _group,
                  onChanged: (T) {
              
                    _selectedRadio = 74;
                    setState(() {
                      _group = T;
                    });
                  },
                ),
                Text('Videos'),
                Radio(
                  value: 1,
                  groupValue: _group,
                  onChanged: (T) {
               
                    _selectedRadio = 75;
                    setState(() {
                      _group = T;
                    });
                  },
                ),
                Text('Documentos'),
                Radio(
                  value: 2,
                  groupValue: _group,
                  onChanged: (T) {
                   
                    _selectedRadio = 76;
                    setState(() {
                      _group = T;
                    });
                  },
                ),
              ],
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
            new Multimedia(),
            urlGetMultimedia + _selectedRadio.toString(),
            primaryKeyGetMultimedia),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
           if (snapshot.hasData) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
              break;
            default:
              //mostramos los datos
              return listItemsEntity(context, snapshot);
          }
           } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget listItemsEntity(BuildContext context, AsyncSnapshot snapshot) {
    final size = MediaQuery.of(context).size;

    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: ClampingScrollPhysics(),
      itemCount: snapshot.data.length,
      itemBuilder: (context, index) {
        Multimedia entityItem = snapshot.data[index];

        return Column(
          children: <Widget>[
            Container(
              width: size.width * 0.98,
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
            //   divider(),
          ],
        );
      },
    );
  }

  Widget listEntity(BuildContext context, Multimedia entityItem) {
    final item = entityItem.idcovMultimedia;

    return Dismissible(
      key: Key(item.toString()), //UniqueKey(),
      background: Container(
        color: Colors.red,
        padding: EdgeInsets.only(left: 5.0),
        child: Text(
          'Eliminar registro',
          style: TextStyle(color: Colors.white),
        ),
      ),
      onDismissed: (value) {
        setState(() {
          final dataMap = generic
              .delete('$urlDeleteMultimedia${item.toString()}/${prefs.userId}');

          dataMap.then((respuesta) => result = respuesta["TIPO_RESPUESTA"]);
          print('resultado:$result');
        });

        if (result != null || result != '-1')
          Scaffold.of(context).showSnackBar(
              new SnackBar(content: new Text('Registro eliminado')));
        else
          Scaffold.of(context).showSnackBar(new SnackBar(
              content: new Text('Problemas al eliminar el registro!!!')));
      },

      child: Row(
        children: <Widget>[
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.gamepad,
                      color: AppTheme.themeVino,
                      size: 15,
                    ),
                    Expanded(
                      child: Text(
                        'Material: ${entityItem.mulTitulo} ',
                        style: kSubTitleCardStyle,
                        softWrap: true,
                        overflow: TextOverflow.clip,
                      ),
                    ),
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
                        'Resumen: ${entityItem.mulResumen}',
                        style: kSubTitleCardStyle,
                        softWrap: true,
                        overflow: TextOverflow.clip,
                      ),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    // Icon(
                    //   Icons.place,
                    //   color: AppTheme.themeVino,
                    //   size: 15,
                    // ),

                    Expanded(
                      child: Text(
                        'inicio: ${entityItem.detFechaInicio} - Conclusión: ${entityItem.detFechaFin}',
                        style: kSubTitleCardStyle,
                        softWrap: true,
                        overflow: TextOverflow.clip,
                      ),
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

  Container iconEntity(Multimedia entityItem) {
    return Container(
        child: Column(
      children: <Widget>[
        ImageOvalNetwork(
            imageNetworkUrl: entityItem.mulEnlace,
            sizeImage: Size.fromWidth(40)),
        SizedBox(height: 3.0),
        Text(
          '${entityItem.tipoMaterial}',
          style: TextStyle(
              fontSize: 11, color: Colors.black87, fontWeight: FontWeight.w400),
        ),
      ],
    ));
  }
}
