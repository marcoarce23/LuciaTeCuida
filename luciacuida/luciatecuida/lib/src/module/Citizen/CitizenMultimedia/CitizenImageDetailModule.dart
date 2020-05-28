import 'package:flutter/material.dart';
import 'package:luciatecuida/src/Model/Entity.dart';
import 'package:luciatecuida/src/Model/PreferenceUser.dart';
import 'package:luciatecuida/src/Theme/ThemeModule.dart';

class CitizenImageDetailModule extends StatefulWidget {
  final ListaMultimedia multimediaImagen;
  static final String routeName ='ImagenDetalle';

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

 backgroundColor: AppTheme.themeVino,
        toolbarOpacity: 0.7,
        iconTheme: IconThemeData(color: AppTheme.themeColorBlanco, size: 12),
        elevation: 0,
        title:
            Text("Detalle", style: kTitleAppBar),

        
      ),
      
      body: Center(
        child: Column(
          children: <Widget>[
           
            Container(
                child: FadeInImage.assetNetwork(
              placeholder: "assets/loading/loadingImage.gif",
              placeholderScale: 0.5,
              image: widget.multimediaImagen.mulEnlace,
              fit: BoxFit.cover,
            )),
          ],
        ),
      ),
    );
  }
}
