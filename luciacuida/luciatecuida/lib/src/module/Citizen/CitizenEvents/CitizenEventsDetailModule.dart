import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:luciatecuida/src/Model/Entity.dart';
import 'package:luciatecuida/src/Model/PreferenceUser.dart';
import 'package:luciatecuida/src/Theme/ThemeModule.dart';
import 'package:luciatecuida/src/Util/Util.dart';
import 'package:luciatecuida/src/Widget/GeneralWidget.dart';
import 'package:luciatecuida/src/module/HomePage/HomePageModule.dart';

class CitizenEventsDetailModule extends StatefulWidget {
  final EventosItem eventosItem;

  static final String routeName = 'CiudadanoEventosDetalle';
  const CitizenEventsDetailModule({Key key, @required this.eventosItem})
      : super(key: key);

  @override
  _CitizenEventsDetailModuleState createState() =>
      _CitizenEventsDetailModuleState();
}

class _CitizenEventsDetailModuleState extends State<CitizenEventsDetailModule> {
  final prefs = new PreferensUser();

  @override
  void initState() {
    prefs.ultimaPagina = CitizenEventsDetailModule.routeName;
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
        title:
            Text(widget.eventosItem.titulo.toUpperCase(), style: kTitleAppBar),

        //backgroundColor: Colors.black,
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.network(
                widget.eventosItem.url,
                width: MediaQuery.of(context).size.width,
                height: 200,
                fit: BoxFit.cover,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "FECHA Y HORA:",
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                    color: AppTheme.themeVino),
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Text(
                      widget.eventosItem.fecha + ' ' + widget.eventosItem.hora,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Colors.black),
                      softWrap: true,
                      overflow: TextOverflow.clip,
                    ),
                  ),
                ],
              ),
              Text(
                "EVENTO:",
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                    color: AppTheme.themeVino),
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Text(
                      widget.eventosItem.titulo,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Colors.black),
                      softWrap: true,
                      overflow: TextOverflow.clip,
                    ),
                  ),
                ],
              ),
              Text(
                "EXPOSITOR:",
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                    color: AppTheme.themeVino),
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Text(
                      widget.eventosItem.expositor,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Colors.black),
                      softWrap: true,
                      overflow: TextOverflow.clip,
                    ),
                  ),
                ],
              ),
              Text(
                "OBJETIVO:",
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                    color: AppTheme.themeVino),
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Text(
                      widget.eventosItem.objetivo,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Colors.black),
                      softWrap: true,
                      overflow: TextOverflow.clip,
                    ),
                  ),
                ],
              ),
              Text(
                "DIRIGIDO A:",
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                    color: AppTheme.themeVino),
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Text(
                      widget.eventosItem.dirigidoA,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Colors.black),
                      softWrap: true,
                      overflow: TextOverflow.clip,
                    ),
                  ),
                ],
              ),
              Text(
                "UBICACION:",
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                    color: AppTheme.themeVino),
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 15,
                  ),
                  generaHTTP_ICON(
                      widget.eventosItem.ubicacion,
                      FaIcon(
                        FontAwesomeIcons.internetExplorer,
                        size: 25,
                        color: AppTheme.themeVino,
                      )),
                ],
              ),
              copyRigth(),
            ],
          ),
        ),
      ),
      drawer: DrawerCitizen(),
      floatingActionButton: generaFloatbuttonHome(context),
    );
  }
}
