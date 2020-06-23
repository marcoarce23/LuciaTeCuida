import 'package:flutter/material.dart';
import 'package:luciatecuida/src/Model/Entity.dart';
import 'package:luciatecuida/src/Model/PreferenceUser.dart';
import 'package:luciatecuida/src/Theme/ThemeModule.dart';
import 'package:luciatecuida/src/Util/Util.dart';
import 'package:luciatecuida/src/module/HomePage/HomePageModule.dart';

class CitizenImageDetailModule extends StatefulWidget {
  final ListaMultimedia multimediaImagen;
  static final String routeName = 'ImagenDetalle';

  const CitizenImageDetailModule({Key key, @required this.multimediaImagen})
      : super(key: key);

  @override
  _CitizenImageDetailModuleState createState() =>
      _CitizenImageDetailModuleState();
}

class _CitizenImageDetailModuleState extends State<CitizenImageDetailModule> {
  final prefs = new PreferensUser();

  @override
  void initState() {
    prefs.ultimaPagina = CitizenImageDetailModule.routeName;
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
        title: Text("DETALLE MULTIMEDIA", style: kTitleAppBar),
      ),
      body: SingleChildScrollView(
              child: Column(
          children: <Widget>[
            Center(
              child: Container(
                  child: FadeInImage.assetNetwork(
                placeholder: "assets/loading/loadingImage.gif",
                placeholderScale: 0.5,
                image: widget.multimediaImagen.mulEnlace,
                fit: BoxFit.cover,
                height:350,
              )),
            ),
            SizedBox(height: 20,),
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Row(
                children: <Widget>[
                  Text(
                    "Titulo:".toUpperCase(),
                    style: TextStyle(fontWeight: FontWeight.w700,color:  AppTheme.themeVino),
                  ),
                  Text(widget.multimediaImagen.mulTitulo),
                ],
              ),
            ),
              Container(
              margin: EdgeInsets.only(left: 10),
              child: Row(
                children: <Widget>[
                  Text(
                    "Tipo material:".toUpperCase(),
                    style: TextStyle(fontWeight: FontWeight.w700,color:  AppTheme.themeVino),
                  ),
                  Text(widget.multimediaImagen.mulTipoMaterial),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Row(
                children: <Widget>[
                  Text(
                    "Descripción:".toUpperCase(),
                    style: TextStyle(fontWeight: FontWeight.w700,color:  AppTheme.themeVino),
                  ),
                  Text(widget.multimediaImagen.mulResumen),
                ],
              ),
            ),
          
          ],
        ),
      ),
      drawer: DrawerCitizen(),
floatingActionButton: generaFloatbuttonHome(context),        


    );
  }
}
