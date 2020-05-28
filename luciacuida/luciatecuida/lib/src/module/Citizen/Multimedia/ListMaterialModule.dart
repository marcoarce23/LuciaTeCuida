import 'package:flutter/material.dart';
import 'package:luciatecuida/src/Model/Entity.dart';
import 'package:luciatecuida/src/Model/Generic.dart';
import 'package:luciatecuida/src/Theme/ThemeModule.dart';
import 'package:luciatecuida/src/module/Citizen/Multimedia/MultimediaModule.dart';
import 'package:luciatecuida/src/module/Settings/RoutesModule.dart';


class ListMaterialModule extends StatefulWidget {
  ListMaterialModule({Key key}) : super(key: key);

  @override
  _ListMaterialModuleState createState() => _ListMaterialModuleState();
}

class _ListMaterialModuleState extends State<ListMaterialModule> {
final generic = new Generic();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
          body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Padding(
                padding: EdgeInsets.all(10),
                child: Text("Lista de materiales publicados")),
          ),
          Card(
            elevation: 4,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search),
                  hintText: "Buscar",
                ),
              ),
            ),
          ),
          // colcoamos las cajas de instituciones
          Container(
            child: Padding(
                padding: EdgeInsets.all(10),
                child: Text("Resultados",
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.w400))),
          ),
          futureItemsInstitution(context)
        ],
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text('Documentos Multimedia'),
      backgroundColor: Colors.orange,
    );
  }

  Widget futureItemsInstitution(BuildContext context) {
    return FutureBuilder(
        future:   Generic().getAll(
            new ListaMultimedia(),
            urlGetListaMultimediaPorInstitucion + '/'+ '20'+
                '/74',
            primaryKeyListaMultimediaPorInstitucion),    
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
              break;
            default:
              //mostramos los datos
              return listItemsInstitution(context, snapshot);
          }
        });
  }

  Widget listItemsInstitution(BuildContext context, AsyncSnapshot snapshot) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: ClampingScrollPhysics(),
        itemCount: snapshot.data.length,
        itemBuilder: (context, index) {
          InstitucionesItems institutionItem = snapshot.data[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MultimediaModule(
                         // institutionItem: institutionItem,
                        )),
              );
            },
            child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0)),
                //margin:                      const EdgeInsets.only(left: 10, right: 10),
                child: Center(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width - 30,
                    height: 85,
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.start,
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        iconInstitution(institutionItem),
                        dividerLine(),
                        listInstitution(context, institutionItem),
                      ],
                    ),
                  ),
                )),
          );
        },
      ),
    );
  }

  Widget listInstitution(
      BuildContext context, InstitucionesItems institutionItem) {
    return Row(
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                width: MediaQuery.of(context).size.width - 260,
                child: Text(institutionItem.nombreInstitucion)),
            Row(
              children: <Widget>[
                Icon(
                  Icons.place,
                  color: Colors.black54,
                  size: 15,
                ),
                Text(institutionItem.ubicacion),
              ],
            ),
            Container(
                child: Text(
              " 53 Publicaciones ",
              style: TextStyle(color: Colors.black45, fontSize: 12),
            )),
            tieneCovid(institutionItem),
          ],
        ),
      ],
    );
  }

  Text tieneCovid(InstitucionesItems institutionItem) {
    String respuesta;

    if (institutionItem.ayudaConCovid == "0") {
      respuesta = "";
    } else {
      respuesta =
          "Fecha de Publicacion ${institutionItem.fechaConCovid}";
    }

    return Text(
      respuesta,
      style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
    );
  }

  Container iconInstitution(InstitucionesItems institutionItem) {
    return Container(
        child: Column(
      children: <Widget>[
        Icon(
          Icons.business,
          size: 30,
          color: AppTheme.themeColorNaranja,
        ),
        Text(
          institutionItem.tipoInstitucion,
          style: TextStyle(
              fontSize: 11,
              color: AppTheme.themeColorNaranja,
              fontWeight: FontWeight.w400),
        ),
      ],
    ));
  }

  Container dividerLine() {
    return Container(
        height: 20, child: VerticalDivider(color: AppTheme.themeColorNaranja));
  }
}
