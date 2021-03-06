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
import 'package:auto_size_text/auto_size_text.dart';

class ListVoluntaryModule extends StatefulWidget {
  static final String routeName = 'lisVoluntary';
  const ListVoluntaryModule({
    Key key,
  }) : super(key: key);

  @override
  _ListVoluntaryModuleState createState() => _ListVoluntaryModuleState();
}

class _ListVoluntaryModuleState extends State<ListVoluntaryModule> {
  final generic = new Generic();
  final prefs = new PreferensUser();
  var result;
  //String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    //initPlatformState();
    prefs.ultimaPagina = ListVoluntaryModule.routeName;
  }

  // Future<void> initPlatformState() async {
  //   String platformVersion;
  //   // Platform messages may fail, so we use a try/catch PlatformException.
  //   try {
  //     platformVersion = await FlutterOpenWhatsapp.platformVersion;
  //   } on PlatformException {
  //     platformVersion = 'Failed to get platform version.';
  //   }

  //   // If the widget was removed from the tree while the asynchronous platform
  //   // message was in flight, we want to discard the reply rather than calling
  //   // setState to update our non-existent appearance.
  //   if (!mounted) return;

  //   setState(() {
  //     _platformVersion = platformVersion;
  //     //print('Running on: $_platformVersion');
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
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
              'LISTADO DE VOLUNTARIOS',
              FaIcon(FontAwesomeIcons.peopleArrows, color: AppTheme.themeVino),
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

  Widget futureItemsEntity(BuildContext context) {
    print('$urlGetVoluntario1${prefs.idInsitucion} /-1');
    return FutureBuilder(
        future: generic.getAll(
            new Voluntary(),
            urlGetVoluntario1 + prefs.idInsitucion + '/-1',
            primaryKeyGetVoluntario1),
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
          Voluntary entityItem = snapshot.data[index];

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
              //  divider(),
              SizedBox(height: 7.0),
            ],
          );
        },
      ),
    );
  }

  Widget listEntity(BuildContext context, Voluntary entityItem) {
    final item = entityItem.idcovPersonal;

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
              'Desea eliminar al voluntario?',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
      onDismissed: (value) {
        setState(() {
          final dataMap = generic.add(entityItem,
              '$urlDeleteVoluntario${item.toString()}/${prefs.userId}');

          dataMap.then((respuesta) => result = respuesta["TIPO_RESPUESTA"]);
          //print('resultado:$result');
        });

        if (result != null || result != '-1')
          Scaffold.of(context).showSnackBar(messageOk(
              "Se elimino al voluntario: ${entityItem.perNombrepersonal}"));
        else
          Scaffold.of(context).showSnackBar(
              messageNOk("Se  produjo un error. Vuelva a intentarlo."));
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
                      Icons.account_circle,
                      color: AppTheme.themeVino,
                      size: 15,
                    ),
                    Expanded(
                      child: Text(
                        '${entityItem.perNombrepersonal} ',
                        style: kTitleCardStyle,
                        softWrap: true,
                        overflow: TextOverflow.clip,
                      ),
                    ),
                  ],
                ),
                Row(children: <Widget>[
                  Icon(
                    Icons.business,
                    color: AppTheme.themeVino,
                    size: 15,
                  ),
                  Expanded(
                    child: Text(
                      'Inst.: ${entityItem.desInstitucion}',
                      style: kSubTitleCardStyle,
                      softWrap: true,
                      overflow: TextOverflow.clip,
                    ),
                  ),
                ]),
                Row(children: <Widget>[
                  Icon(
                    Icons.ac_unit,
                    color: AppTheme.themeVino,
                    size: 15,
                  ),
                  Expanded(
                    child: Text(
                      'Asistencia Covid: ${entityItem.idCovAtencion == 1 ? 'SI' : 'NO'}',
                      style: kSubTitleCardStyle,
                      softWrap: true,
                    ),
                  ),
                ]),
                Row(children: <Widget>[
                  Icon(
                    Icons.add_to_home_screen,
                    color: AppTheme.themeVino,
                    size: 15,
                  ),
                  Expanded(
                    child: Text(
                      'Telef.: ${entityItem.perTelefono}',
                      style: kSubTitleCardStyle,
                      softWrap: true,
                    ),
                  ),
                ]),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.email,
                      color: AppTheme.themeVino,
                      size: 15,
                    ),
                    Row(
                      children: <Widget>[
                        Text('Correo: ', style: kTitleCardStyle),
                      ],
                    ),
                  ],
                ),
                AutoSizeText(
                  entityItem.perCorreo,
                  style: kTitleCardStyle,
                  maxLines: 2,
                  minFontSize: 15.0,
                  overflow: TextOverflow.ellipsis,
                ),
   
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.account_box,
                      color: AppTheme.themeVino,
                      size: 15,
                    ),

                    Row(
                      children: <Widget>[
                        Text(
                                'Estado:',
                                style: kSubTitleCardStyle,
                                softWrap: true,
                              ),
                      ],
                    ),

                    Expanded(
                      child: Wrap(
                        children: <Widget>[
                          Text(
                            '${entityItem.estadoUsuario == 81 ? '(Por Confirmar)' : entityItem.estadoUsuario == 82 ? '(Activo)' : '(Baja)'}',
                            style: kSubTitleCardStyle,
                            softWrap: true,
                          ),
                          SizedBox(width: 5.0),
                          Opacity(
                            opacity: (entityItem.estadoUsuario == 81)
                                ? 1
                                : (entityItem.estadoUsuario == 82) ? 0 : 1,
                            child: ClipOval(
                              child: Material(
                                color: Colors.white, // button color
                                child: InkWell(
                                    splashColor: AppTheme
                                        .backGroundInstitutionPrimary, // inkwell color
                                    child: SizedBox(
                                      width: 30,
                                      height: 30,
                                      child: FaIcon(
                                        FontAwesomeIcons.thumbsUp,
                                        color: Colors.green,
                                        size: 25,
                                      ),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        _submitAlta(entityItem);
                                      });
                                    }),
                              ),
                            ),
                          ),

                          Opacity(
                            opacity: (entityItem.estadoUsuario == 81)
                                ? 1
                                : (entityItem.estadoUsuario == 82)
                                    ? 1
                                    : (entityItem.estadoUsuario == 83) ? 0 : 0,
                            child: ClipOval(
                              child: Material(
                                color: Colors.white, // button color
                                child: InkWell(
                                    splashColor: AppTheme
                                        .backGroundInstitutionPrimary, // inkwell color
                                    child: SizedBox(
                                      width: 30,
                                      height: 30,
                                      child: FaIcon(
                                        FontAwesomeIcons.thumbsDown,
                                        color: Colors.red,
                                        size: 25,
                                      ),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        _submitBaja(entityItem);
                                      });
                                    }),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: 11.0),
                Wrap(
                  children: <Widget>[
                    InkWell(
                      child: FaIcon(
                        FontAwesomeIcons.phoneVolume,
                        color: AppTheme.themeVino,
                        size: 25,
                      ),
                      onTap: () {
                        callNumber(int.parse(entityItem.perTelefono));
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
                        sendSMS(int.parse(entityItem.perTelefono));
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
                            entityItem.perCorreo,
                            "Colaboración ${entityItem.desEspecialidad}",
                            "Estimad@:  ${entityItem.perNombrepersonal}, favor su colaboración en: ");
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
                        callWhatsAppText(int.parse(entityItem.perTelefono),
                            'Colega *${entityItem.perNombrepersonal.trim()}*: \nSoy un _voluntario_ , me gustaría ponerme en contacto con ud. \nEnviado desde la aplicación *SomosUnoBolivia*.');
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

  _submitAlta(Voluntary entityItem) async {
    final dataMap = generic.add(
        new Voluntary(),
        urlAprobar +
            entityItem.idcovPersonal.toString() +
            '/82' +
            '/${prefs.correoElectronico}');

    dataMap.then((respuesta) {
      result = respuesta["TIPO_RESPUESTA"];
      //print('resultado de entro a la alta icono verde:$result');

      if (result == "0") {
        Scaffold.of(context)
            .showSnackBar(messageOk("Se dio de alta al voluntario"));

        enviarNotificaciones(
            urlGetToken + '2/${prefs.idInsitucion}',
            'Voluntario',
            'Nuevo voluntario',
            entityItem.perNombrepersonal,
            'Bienvenido al Grupo',
            prefs.nombreInstitucion);
      } else if (result == "1") {
        Scaffold.of(context)
            .showSnackBar(messageWarning(respuesta["MENSAJE"].toString()));
      } else
        Scaffold.of(context).showSnackBar(
            messageNOk("Se produjo un error. Vuelva a intentarlo"));
    });
  }

  _submitBaja(Voluntary entityItem) async {
    final dataMap = generic.add(
        new Voluntary(),
        urlAprobar +
            entityItem.idcovPersonal.toString() +
            '/83' +
            '/${prefs.correoElectronico}');

    await dataMap.then((respuesta) {
      result = respuesta["TIPO_RESPUESTA"];
      //print('resultado de la baja entro icono rojo:$result');

      if (result == "0")
        Scaffold.of(context)
            .showSnackBar(messageOk("Se dio de baja al voluntario"));
      else if (result == "1") {
        Scaffold.of(context)
            .showSnackBar(messageWarning(respuesta["MENSAJE"].toString()));
      } else
        Scaffold.of(context).showSnackBar(
            messageNOk("Se produjo un error. Vuelva a intentarlo"));
    });
  }

  Container iconEntity(Voluntary entityItem) {
    return Container(
        child: Column(
      children: <Widget>[
        ImageOvalNetwork(
            imageNetworkUrl: prefs.avatarImagen, sizeImage: Size.fromWidth(35)),
        SizedBox(height: 5.0),
        Text(
          '${entityItem.desEspecialidad}',
          style: TextStyle(
              fontSize: 12,
              color: AppTheme.themeVino,
              fontWeight: FontWeight.w400),
        ),
      ],
    ));
  }
}
