import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:luciatecuida/src/Model/Entity.dart';
import 'package:luciatecuida/src/Model/Generic.dart';
import 'package:luciatecuida/src/Model/PreferenceUser.dart';

import 'package:luciatecuida/src/Theme/ThemeModule.dart';
import 'package:luciatecuida/src/Util/Util.dart';
import 'package:luciatecuida/src/Widget/GeneralWidget.dart';
import 'package:luciatecuida/src/module/HomePage/HomePageModule.dart';
import 'package:luciatecuida/src/module/Settings/RoutesModule.dart';

import 'CitizenEventsDetailModule.dart';

String selectedCategorie = "Recomendaciones";

class CitizenEventsModule extends StatefulWidget {
  static final String routeName = 'CiudadanoEventos';
  @override
  _CitizenEventsModuleState createState() => _CitizenEventsModuleState();
}

class _CitizenEventsModuleState extends State<CitizenEventsModule> {
  final prefs = new PreferensUser();
  @override
  void initState() {
    prefs.ultimaPagina = CitizenEventsModule.routeName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            toolbarOpacity: 0.7,
            iconTheme:
                IconThemeData(color: AppTheme.themeVino, size: 12),
            elevation: 0,
            title: Text("EVENTOS", style: kTitleAppBar),

            //backgroundColor: AppTheme.themeColorNaranja,
          ),
          drawer: DrawerCitizen(),
          body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  listadoDeNoticias(),
                  copyRigth(),
                ],
              )) //CollapsingList(),

          //ejemploNoticias(),
          ),
    );
  }

  Widget listadoDeNoticias() {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 15,
              ),
              futureEvento(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget futureEvento(BuildContext context) {
    return FutureBuilder(
        future: Generic().getAll(
            new EventosItem(), urlGetListaEventos, primaryKeyListaEventos),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
              break;
            default:
              //mostramos los datos
              return buildEvento(context, snapshot);
          }
        });
  }

  Widget buildEvento(BuildContext context, AsyncSnapshot snapshot) {
    return Container(
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: ClampingScrollPhysics(),
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) {
            EventosItem item = snapshot.data[index];
            return noticia(item);
          }),
    );
  }

  Widget noticia(EventosItem eventoItem) {
    DateTime tempDate = new DateFormat("dd/MM/yyyy").parse(eventoItem.fecha);

    String mes;
    switch (tempDate.month) {
      case 1:
        mes = "Ene";
        break;
      case 2:
        mes = "Feb";
        break;
      case 3:
        mes = "Mar";
        break;
      case 4:
        mes = "Abr";
        break;
      case 5:
        mes = "May";
        break;
      case 6:
        mes = "Jun";
        break;
      case 7:
        mes = "Jul";
        break;
      case 8:
        mes = "Ago";
        break;
      case 9:
        mes = "Sep";
        break;
      case 10:
        mes = "Oct";
        break;
      case 11:
        mes = "Nov";
        break;
      case 12:
        mes = "Dic";
        break;
    }

    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CitizenEventsDetailModule(
                      eventosItem: eventoItem,
                    )));
      },
      child: Container(
        height: 100,
        margin: EdgeInsets.only(top: 5, bottom: 16, right: 8),
        decoration: BoxDecoration(
            color: Colors.cyan, borderRadius: BorderRadius.circular(8)),
        child: Stack(
          children: <Widget>[
            ImageOpaqueNetworkCustomize(
                eventoItem.url,
                AppTheme.themeColorNaranja,
                Size(MediaQuery.of(context).size.width, 100),
                0.5,
                BoxFit.cover),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 7,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      new DateFormat("dd").format(tempDate),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w900),
                    ),
                    Text(
                      mes,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w900),
                    ),
                    Text(
                      eventoItem.hora.substring(1, 5),
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 16),
                    width: MediaQuery.of(context).size.width - 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: RichText(
                            overflow: TextOverflow.clip,
                            text: TextSpan(
                              text: eventoItem.titulo.toUpperCase(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800),
                            ),
                          ),
                        ),
                        Expanded(
                          child: RichText(
                            overflow: TextOverflow.clip,
                            text: TextSpan(
                              text: eventoItem.objetivo,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Expanded(
                          child: RichText(
                            overflow: TextOverflow.clip,
                            text: TextSpan(
                              text: "Institucion: " + eventoItem.institucion,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                        ),
                        Expanded(
                          child: RichText(
                            overflow: TextOverflow.clip,
                            text: TextSpan(
                              text: "Expositor: " + eventoItem.expositor,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
