import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:luciatecuida/src/Model/Entity.dart';
import 'package:luciatecuida/src/Model/Generic.dart';
import 'package:luciatecuida/src/Model/PreferenceUser.dart';
import 'package:luciatecuida/src/Theme/ThemeModule.dart';
import 'package:luciatecuida/src/Util/Util.dart';
import 'package:luciatecuida/src/Widget/Message/Message.dart';
import 'package:luciatecuida/src/module/HomePage/HomePageModule.dart';
import 'package:luciatecuida/src/module/Settings/RoutesModule.dart';
import 'FoundAllVoluntaryModule.dart';
import 'package:luciatecuida/src/Util/SearchDelegate/DataSearch.dart';

class FoundVoluntaryModule extends StatefulWidget {
  static final String routeName = 'EncuentraVoluntario';
  @override
  _FoundVoluntaryModuleState createState() => _FoundVoluntaryModuleState();
}

class _FoundVoluntaryModuleState extends State<FoundVoluntaryModule> {
  final prefs = new PreferensUser();
  final generic = new Generic();
  int departamento = 60;
  String _notificacion = '';

  @override
  void initState() {
    prefs.ultimaPagina = FoundVoluntaryModule.routeName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _valor = ModalRoute.of(context).settings.arguments;
    if (_valor != null) _notificacion = _valor;

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            toolbarOpacity: 0.7,
            iconTheme: IconThemeData(color: AppTheme.themeVino, size: 12),
            elevation: 0,
            title: Text("BUSCA UN VOLUNTARIO", style: kTitleAppBar),
            /*actions: <Widget>[
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  showSearch(
                      context: context, delegate: DataSearchEncuentraUnAmigo(departamento));
                },
              ),
            
            ],
            */
          ),
          drawer: DrawerCitizen(),
          floatingActionButton: generaFloatbuttonHome(context),
          body: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 15,
                ),
                contenedorTitulo(
                  context,
                  40.0,
                  "Voluntarios".toUpperCase(),
                  FaIcon(FontAwesomeIcons.peopleCarry,
                      color: AppTheme.themeVino),
                ),
                  Opacity(
                  opacity: _notificacion.length > 1 ? 1.0 : 0.0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal:15.0),
                    child: AutoSizeText(
                'Atención: Nuevo voluntario registrado.',
                style: kSubTitleCardStyle,
                maxLines: 1,
                minFontSize: 13.0,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.justify,
              ),
                  )),
                  
                  
         

                _crearDepartamento(),
                SizedBox(
                  height: 15,
                ),
                futureCuerpoProfesionales(context),
              ],
            ),
          )) //CollapsingList(),

          //ejemploNoticias(),
          ),
    );
  }

  Widget futureCuerpoProfesionales(BuildContext context) {
    return FutureBuilder(
        future: Generic().getAll(
            new ProfesionalesAgrupados(),
            urlGetTodosGruposProfesionales + '/' + departamento.toString(),
            primaryKeyTodosGruposProfesionales),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
              break;
            default:
              //mostramos los datos
              return cuerpoProfesionales(context, snapshot);
          }
        });
  }

  Widget cuerpoProfesionales(BuildContext context, AsyncSnapshot snapshot) {
    List<Widget> lista = new List<Widget>();
    for (var i = 0; i < snapshot.data.length; i++) {
      ProfesionalesAgrupados listaProfesionales = snapshot.data[i];
      lista.add(tarjetaProfessional(context, listaProfesionales));
    }
    return Wrap(
      children: lista,
    );
  }

  Widget tarjetaProfessional(
      BuildContext context, ProfesionalesAgrupados profesional) {
    return SingleChildScrollView(
      child: InkWell(
        onTap: () {
          if (profesional.cantidadProfesionales > 0) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => FoundAllVoluntaryModule(
                        profesional: profesional, departamento: departamento,
                      )),
            );
          } else {
            Scaffold.of(context).showSnackBar(messageHelp(
                "Aun no cuenta con miembros en el grupo de ${profesional.profesion}"));
          }
        },
        child: Container(
          height: 150,
          width: 150,
          color: AppTheme.themeVino,
          child: Card(
            elevation: 5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Stack(
                children: <Widget>[
                  ImageOpaqueNetworkCustomize(
                    profesional.imagenFondo,
                    Colors.white,
                    Size(150, 150),
                    0.5,
                    BoxFit.cover,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Center(
                          child: Text(
                            profesional.profesion.toUpperCase(),
                            style: kTitleCardStyle,
                          ),
                        ),
                      ),
                      Text(
                          "Contamos con " +
                              profesional.cantidadProfesionales.toString() +
                              " profesionales",
                          style: kSubTitleCardStyle),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _crearDepartamento() {
    return Center(
        child: FutureBuilder(
            future: generic.getAll(new GetClasificador(), urlGetDepartamento,
                primaryKeyGetDepartamento),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(width: 35.0),
                    Text('Departamento:'),
                    SizedBox(width: 15.0),
                    DropdownButton(
                      icon: FaIcon(FontAwesomeIcons.sort,
                          color: AppTheme.themeVino),
                      value: departamento.toString(),
                      items: getDropDown(snapshot),
                      onChanged: (value) {
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
