import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:luciatecuida/src/Model/Entity.dart';
import 'package:luciatecuida/src/Model/Generic.dart';
import 'package:luciatecuida/src/Model/PreferenceUser.dart';
import 'package:luciatecuida/src/Theme/ThemeModule.dart';
import 'package:luciatecuida/src/Util/SearchDelegate/DataSearch.dart';
import 'package:luciatecuida/src/Util/Util.dart';
import 'package:luciatecuida/src/Widget/GeneralWidget.dart';
import 'package:luciatecuida/src/Widget/Message/Message.dart';
import 'package:luciatecuida/src/module/HomePage/HomePageModule.dart';
import 'CitizenInstitutionModule.dart';
import 'package:luciatecuida/src/module/Settings/RoutesModule.dart';

class CitizenListInstitucionModule extends StatefulWidget {
  static final String routeName = 'ListaInstituciones';
  @override
  _CitizenListInstitucionModuleState createState() =>
      _CitizenListInstitucionModuleState();
}

class _CitizenListInstitucionModuleState
    extends State<CitizenListInstitucionModule> {
  final generic = new Generic();
  final prefs = new PreferensUser();
   int departamento = 60;

  @override
  void initState() {
    prefs.ultimaPagina = CitizenListInstitucionModule.routeName;
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
        title: Text("INSTITUCIONES", style: kTitleAppBar),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: DataSearchInstituciones( departamento ));
            },
          )
        ],
      ),
      body:SingleChildScrollView (
              child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: contenedorTitulo(
                  context,
                  40.0,
                  "Lista de instituciones".toUpperCase(),
                  FaIcon(FontAwesomeIcons.calendarAlt, color: AppTheme.themeVino),
                ),
              ),
              _crearDepartamento(),
              Center(
                  child: Text(
                "NOTA: Presione sobre la institución para ver el detalle",
                style: kSubSubTitleCardStyle,
              )), // colcoamos las cajas de instituciones
              divider(),
              futureItemsInstitution(context),
              copyRigth(),
            ],
          ),
        ),
      ),
      drawer: DrawerCitizen(),
      floatingActionButton: generaFloatbuttonHome(context),
    );
  }

  Widget futureItemsInstitution(BuildContext context) {
    return FutureBuilder(
        future: generic.getAll(new InstitucionesItems(),
            urlGetListaInstituciones+'/'+ departamento.toString()  , primaryKeyGetListaInstituciones),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
              break;
            default:
              //mostramos los datos
              //print(snapshot.data);
              return listItemsInstitution(context, snapshot);
          }
        });
  }

  Widget listItemsInstitution(BuildContext context, AsyncSnapshot snapshot) {
   // final size = MediaQuery.of(context).size;
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: ClampingScrollPhysics(),
      itemCount: snapshot.data.length,
      itemBuilder: (context, index) {
        InstitucionesItems institutionItem = snapshot.data[index];
        return Container(
          margin: EdgeInsets.only(top: 5, left: 10, right: 10),
          decoration: boxDecorationList(),
          child: InkWell(
            onTap: () {
              if (institutionItem.miembros > 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CitizenInstitutionModule(
                            institutionItem: institutionItem,
                          )),
                );
              } else {
                Scaffold.of(context).showSnackBar(messageHelp(
                    "Aun no cuenta con miembros en ${institutionItem.nombreInstitucion}"));
              }
            },
            child: ListTile(
              leading: iconInstitution(institutionItem),
              title: listInstitution(context, institutionItem),
            ),
          ),
        );
      },
    );
  }

  Widget listInstitution(
      BuildContext context, InstitucionesItems institutionItem) {
    return Row(
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
                  Text("Nombre: ", style: kTitleCardStyle),
                  Expanded(
                    child: Text(
                      institutionItem.nombreInstitucion,
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
                    Icons.store_mall_directory,
                    color: AppTheme.themeVino,
                    size: 15,
                  ),
                  Text("Ubicación: ", style: kTitleCardStyle),
                  Expanded(
                    child: Text(
                      institutionItem.ubicacion,
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
                    Icons.people,
                    color: AppTheme.themeVino,
                    size: 15,
                  ),
                  Text("Miembros: ", style: kTitleCardStyle),
                  Expanded(
                    child: Text(
                      " ${institutionItem.miembros} miembros",
                      style: kSubTitleCardStyle,
                      softWrap: true,
                      overflow: TextOverflow.clip,
                    ),
                  ),
                ],
              ),
              tieneCovid(institutionItem),
              Wrap(
                children: <Widget>[
                  InkWell(
                    child: FaIcon(
                      FontAwesomeIcons.phoneVolume,
                      color: AppTheme.themeVino,
                      size: 25,
                    ),
                    onTap: () {
                      callNumber(int.parse(institutionItem.telefono));
                    },
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  InkWell(
                    child: FaIcon(
                      FontAwesomeIcons.comment,
                      color: AppTheme.themeVino,
                      size: 25,
                    ),
                    onTap: () {
                      sendSMS(int.parse(institutionItem.telefono));
                    },
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  InkWell(
                    child: FaIcon(
                      FontAwesomeIcons.mailBulk,
                      color: AppTheme.themeVino,
                      size: 25,
                    ),
                    onTap: () {
                      sendEmailAdvanced(institutionItem.correo, "",
                          "Estimad@:  ${institutionItem.nombreInstitucion}, favor su colaboración en: ");
                    },
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  InkWell(
                    child: FaIcon(
                      FontAwesomeIcons.whatsapp,
                      color: AppTheme.themeVino,
                      size: 25,
                    ),
                    onTap: () {
                      callWhatsAppText(int.parse(institutionItem.telefono),
                      'Estimado soy ${prefs.correoElectronico}, deseo consultarle o ponerme en contacto con ud. \nEnviado desde la aplicación *SomosUnoBolivia*.');
                    },
                  )
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 25,
        ),
      ],
    );
  }

  Text tieneCovid(InstitucionesItems institutionItem) {
    String respuesta;

    if (institutionItem.idaAyudaCovid == 0) {
      respuesta = "";
    } else {
      respuesta =
          "Consultas sobre Covid19 desde ${institutionItem.fechaConCovid}";
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
        ImageOvalNetwork(
            imageNetworkUrl: institutionItem.url,
            sizeImage: Size.fromWidth(40)),
        Text(
          institutionItem.tipoInstitucion,
          style: TextStyle(
              fontSize: 11,
              color: AppTheme.themeVino,
              fontWeight: FontWeight.w400),
        ),
      ],
    ));
  }

  Container dividerLine() {
    return Container(
        height: 20, child: VerticalDivider(color: AppTheme.themeColorNaranja));
  }

  _crearDepartamento() {
    return Center(
        child: FutureBuilder(
            future: generic.getAll(new GetClasificador(), urlGetDepartamento,
                primaryKeyGetDepartamento),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Row(
                  children: <Widget>[
                    SizedBox(width: 35.0),
                    Text('Departamento:'),
                    SizedBox(width: 15.0),
                    DropdownButton(
                      icon: FaIcon(FontAwesomeIcons.sort,
                          color: AppTheme.themeVino),
                      value: departamento.toString(),
                      items: getDropDown(snapshot),
                      onChanged: (value)  {
                        setState(() {
                          departamento = int.parse(value);
                        });
                      },
                    ),
                  ],
                );
              } else {
                return CircularProgressIndicator();
              }
            }));
  }

    List<DropdownMenuItem<String>> getDropDown(AsyncSnapshot snapshot) {
    List<DropdownMenuItem<String>> listaE = new List();

    for (var i = 0; i < snapshot.data.length; i++) {
      GetClasificador item = snapshot.data[i];
      listaE.add(DropdownMenuItem(
        child: Text(item.detalle),
        value: item.id.toString(),
      ));
    }
    return listaE;
  }

}
