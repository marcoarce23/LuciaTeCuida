import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:luciatecuida/src/Model/Entity.dart';
import 'package:luciatecuida/src/Model/Generic.dart';
import 'package:luciatecuida/src/Model/PreferenceUser.dart';
import 'package:luciatecuida/src/Theme/ThemeModule.dart';
import 'package:luciatecuida/src/Util/SearchDelegate/DataSearch.dart';
import 'package:luciatecuida/src/Util/Util.dart';
import 'package:luciatecuida/src/Widget/GeneralWidget.dart';
import 'package:luciatecuida/src/module/HomePage/HomePageModule.dart';
import 'CitizenImageDetailModule.dart';
import 'package:luciatecuida/src/module/Settings/RoutesModule.dart';

class CitizenMultimediaModule extends StatefulWidget {
  static final String routeName = 'CiudadanoMultimedia';
  const CitizenMultimediaModule({Key key}) : super(key: key);

  @override
  _CitizenMultimediaModuleState createState() =>
      _CitizenMultimediaModuleState();
}

class _CitizenMultimediaModuleState extends State<CitizenMultimediaModule> {
  final prefs = new PreferensUser();
  final generic = new Generic();
  int page = 0;
  final List<Widget> optionPage = [PagePicture(), PageVideo(), PageDocuments()];

  void _onItemTapped(int index) {
    setState(() {
      page = index;
    });
  }

  @override
  void initState() {
    prefs.ultimaPagina = CitizenMultimediaModule.routeName;
    page = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          toolbarOpacity: 0.7,
          iconTheme: IconThemeData(color: AppTheme.themeVino, size: 12),
          elevation: 0,
          title: Text("MATERIAL MULTIMEDIA", style: kTitleAppBar),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: DataSearchMultimedia());
              },
            )
          ],
        ),
        drawer: DrawerCitizen(),
        floatingActionButton: generaFloatbuttonHome(context),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.image),
              title: Text('Imagenes'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.ondemand_video),
              title: Text('Videos'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.picture_as_pdf),
              title: Text('Documentos'),
            ),
          ],
          currentIndex: page,
          unselectedItemColor: Colors.black54,
          selectedItemColor: AppTheme.themeVino,
          onTap: _onItemTapped,
        ),
        body: SafeArea(child: optionPage[page]),
      ),
    );
  }
}

class PagePicture extends StatefulWidget {
  const PagePicture({Key key}) : super(key: key);

  @override
  _PagePictureState createState() => _PagePictureState();
}

class _PagePictureState extends State<PagePicture> {
  int valorTipoMaterial = 74;
  int valorOrganizacion = 1042;
  int valorTipoEspecialidad = 11;

  final generic = new Generic();
  String _notificacion = '';

  @override
  Widget build(BuildContext context) {
    final _valor = ModalRoute.of(context).settings.arguments;
    if (_valor != null) _notificacion = _valor;

    return SingleChildScrollView(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // campoBuscarPorInstitucionCategoria(),
              Center(
                child: contenedorTitulo(
                  context,
                  40.0,
                  "Lista de imagenes".toUpperCase(),
                  FaIcon(FontAwesomeIcons.image, color: AppTheme.themeVino),
                ),
              ),
              Opacity(
                  opacity: _notificacion.length > 1 ? 1.0 : 0.0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: AutoSizeText(
                      'Imagen: Nuevo imagen registrada.',
                      style: kSubTitleCardStyle,
                      maxLines: 1,
                      minFontSize: 13.0,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.justify,
                    ),
                  )),
              //_crearOrganizacion(),
              //_crearEspecialidad(),

              Center(
                  child: Text(
                "Nota: Presione sobre la imagen para ver el detalle",
                style: kSubSubTitleCardStyle,
              )),
              futureImagenes(context),
              copyRigth(),
            ],
          ),
        ),
      ),
    );
  }

  Widget campoBuscarPorInstitucionCategoria() {
    return TextField(
      decoration: InputDecoration(
        border: InputBorder.none,
        prefixIcon: Icon(
          Icons.search,
          color: AppTheme.themeColorNaranja,
        ),
        hintText: "Buscar por institución / categoria",
        hintStyle: TextStyle(fontSize: 12, color: AppTheme.themeColorNaranja),
      ),
    );
  }

  Widget futureImagenes(BuildContext context) {
    return FutureBuilder(
        future: Generic().getAll(new ListaMultimedia(),
            urlGetListaMultimedia + '/74', primaryKeyListaMultimedia),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
              break;
            default:
              //mostramos los datos
              if (snapshot.hasData)
                return buildImage(context, snapshot);
              else
                Container();
          }
        });
  }

  Widget buildImage(BuildContext context, AsyncSnapshot snapshot) {
    List<Widget> lista = new List<Widget>();
    for (var i = 0; i < snapshot.data.length; i++) {
      ListaMultimedia multimediaImagen = snapshot.data[i];
      lista.add(imageGalery(context, multimediaImagen));
    }
    return Wrap(
      children: lista,
    );
  }

  Widget imageGalery(BuildContext context, ListaMultimedia multimediaImagen) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CitizenImageDetailModule(
                    multimediaImagen: multimediaImagen,
                  )),
        );
      },
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            child: FadeInImage.assetNetwork(
              placeholder: "assets/loading/loadingImage.gif",
              placeholderScale: 0.2,
              image: multimediaImagen.mulEnlace,
              width: 130,
              height: 130,
              fit: BoxFit.cover,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 140,
              ),
              Container(
                  width: 130,
                  color: Colors.white70,
                  padding: EdgeInsets.only(left: 15),
                  child: Text(
                    multimediaImagen.mulTitulo,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  )),
              Container(
                  width: 130,
                  color: Colors.white70,
                  padding: EdgeInsets.only(left: 15),
                  child: Text(
                    multimediaImagen.mulResumen,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
                  )),
            ],
          ),
        ],
      ),
    );
  }

  Widget _crearOrganizacion() {
    return Center(
        child: FutureBuilder(
            future: generic.getAll(
                new InstitucionesItems(),
                urlGetListaInstituciones +
                    '/' +
                    prefs.idDepartamento.toString(),
                primaryKeyGetListaInstituciones),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Row(
                  children: <Widget>[
                    SizedBox(width: 35.0),
                    Text('Organización:'),
                    SizedBox(width: 15.0),
                    DropdownButton(
                      icon: FaIcon(FontAwesomeIcons.sort,
                          color: AppTheme.themeVino),
                      value: valorOrganizacion.toString(),
                      items: getDropDown(snapshot),
                      onChanged: (value) {
                        setState(() {
                          valorOrganizacion = int.parse(value);
                          //print('valorTipoMaterial $valorTipoMaterial');
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

  Widget _crearEspecialidad() {
    return Center(
        child: FutureBuilder(
            future: generic.getAll(new GetClasificador(),
                urlGetClasificador + '10', primaryKeyGetClasifidor),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Row(
                  children: <Widget>[
                    SizedBox(width: 35.0),
                    Text('Tipo Material:'),
                    SizedBox(width: 15.0),
                    DropdownButton(
                      icon: FaIcon(FontAwesomeIcons.sort,
                          color: AppTheme.themeVino),
                      value: valorTipoEspecialidad.toString(),
                      items: getDropDownE(snapshot),
                      onChanged: (value) {
                        setState(() {
                          valorTipoEspecialidad = int.parse(value);
                          //print('valorTipoEspecialidad $valorTipoEspecialidad');
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

  List<DropdownMenuItem<String>> getDropDownE(AsyncSnapshot snapshot) {
    List<DropdownMenuItem<String>> listaE = new List();

    for (var i = 0; i < snapshot.data.length; i++) {
      GetClasificador item = snapshot.data[i];
      listaE.add(DropdownMenuItem(
        child: Text(item.nombre),
        value: item.id.toString(),
      ));
    }
    return listaE;
  }


  List<DropdownMenuItem<String>> getDropDown(AsyncSnapshot snapshot) {
    List<DropdownMenuItem<String>> listaE = new List();

    for (var i = 0; i < snapshot.data.length; i++) {
      InstitucionesItems item = snapshot.data[i];
      listaE.add(DropdownMenuItem(
        child: Text(item.nombreInstitucion),
        value: item.idInstitucion.toString(),
      ));
    }
    return listaE;
  }
}

class PageVideo extends StatefulWidget {
  const PageVideo({Key key}) : super(key: key);

  @override
  _PageVideoState createState() => _PageVideoState();
}

class _PageVideoState extends State<PageVideo> {
  int valorTipoMaterial = 74;
  int valorOrganizacion = 1042;
  int valorTipoEspecialidad = 11;
  final generic = new Generic();
  String _notificacion = '';
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _valor = ModalRoute.of(context).settings.arguments;
    if (_valor != null) _notificacion = _valor;

    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 0.0),
        decoration: boxDecorationList(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //campoBuscarPorInstitucionCategoria(),
            Center(
              child: contenedorTitulo(
                context,
                40.0,
                "Lista de videos".toUpperCase(),
                FaIcon(FontAwesomeIcons.youtube, color: AppTheme.themeVino),
              ),
            ),
            Opacity(
                opacity: _notificacion.length > 1 ? 1.0 : 0.0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: AutoSizeText(
                    'Video: Nuevo video registrado.',
                    style: kSubTitleCardStyle,
                    maxLines: 1,
                    minFontSize: 13.0,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.justify,
                  ),
                )),
            //_crearOrganizacion(),
            //_crearEspecialidad(),

            Center(
                child: Text(
              "Nota: Presione sobre el video para ver el detalle",
              style: kSubSubTitleCardStyle,
            )),
            futureVideo(context),
            copyRigth(),
          ],
        ),
      ),
    );
  }

  Widget campoBuscarPorInstitucionCategoria() {
    return TextField(
      decoration: InputDecoration(
        border: InputBorder.none,
        prefixIcon: Icon(
          Icons.search,
          color: AppTheme.themeColorNaranja,
        ),
        hintText: "Buscar por institución / categoria",
        hintStyle: TextStyle(fontSize: 12, color: AppTheme.themeColorNaranja),
      ),
    );
  }

  Widget futureVideo(BuildContext context) {
    return FutureBuilder(
        future: Generic().getAll(new ListaMultimedia(),
            urlGetListaMultimedia + '/75', primaryKeyListaMultimedia),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
              break;
            default:
              //mostramos los datos
              return buildItemVideo(context, snapshot);
          }
        });
  }

  Widget buildItemVideo(BuildContext context, AsyncSnapshot snapshot) {
    return Container(
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: ClampingScrollPhysics(),
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) {
            ListaMultimedia item = snapshot.data[index];
            return itemVideo(context, item);
          }),
    );
  }

  Widget itemVideo(BuildContext context, ListaMultimedia multimediaVideo) {
    return InkWell(
        child: ListTile(
          leading: Icon(
            Icons.movie_filter,
            size: 35,
          ),
          title: Text(
            multimediaVideo.mulTitulo,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
          ),
          subtitle: Text(
            multimediaVideo.mulResumen,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
          ),
          trailing: Icon(Icons.navigate_next),
        ),
        onTap: () {
          openWeb(multimediaVideo.mulEnlace);

/*
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => PageViewModule(
                    title: multimediaVideo.mulTitulo,
                    selectedUrl: multimediaVideo.mulEnlace,
                  )));
                  */
        });
  }

  Widget _crearOrganizacion() {
    return Center(
        child: FutureBuilder(
            future: generic.getAll(
                new InstitucionesItems(),
                urlGetListaInstituciones +
                    '/' +
                    prefs.idDepartamento.toString(),
                primaryKeyGetListaInstituciones),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Row(
                  children: <Widget>[
                    SizedBox(width: 35.0),
                    Text('Organización:'),
                    SizedBox(width: 15.0),
                    DropdownButton(
                      icon: FaIcon(FontAwesomeIcons.sort,
                          color: AppTheme.themeVino),
                      value: valorOrganizacion.toString(),
                      items: getDropDown(snapshot),
                      onChanged: (value) {
                        setState(() {
                          valorOrganizacion = int.parse(value);
                          //print('valorTipoMaterial $valorTipoMaterial');
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

  Widget _crearEspecialidad() {
    return Center(
        child: FutureBuilder(
            future: generic.getAll(new GetClasificador(),
                urlGetClasificador + '10', primaryKeyGetClasifidor),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Row(
                  children: <Widget>[
                    SizedBox(width: 35.0),
                    Text('Tipo Material:'),
                    SizedBox(width: 15.0),
                    DropdownButton(
                      icon: FaIcon(FontAwesomeIcons.sort,
                          color: AppTheme.themeVino),
                      value: valorTipoEspecialidad.toString(),
                      items: getDropDownE(snapshot),
                      onChanged: (value) {
                        setState(() {
                          valorTipoEspecialidad = int.parse(value);
                          //print('valorTipoEspecialidad $valorTipoEspecialidad');
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

    List<DropdownMenuItem<String>> getDropDownE(AsyncSnapshot snapshot) {
    List<DropdownMenuItem<String>> listaE = new List();

    for (var i = 0; i < snapshot.data.length; i++) {
      GetClasificador item = snapshot.data[i];
      listaE.add(DropdownMenuItem(
        child: Text(item.nombre),
        value: item.id.toString(),
      ));
    }
    return listaE;
  }


  List<DropdownMenuItem<String>> getDropDown(AsyncSnapshot snapshot) {
    List<DropdownMenuItem<String>> listaE = new List();

    for (var i = 0; i < snapshot.data.length; i++) {
      InstitucionesItems item = snapshot.data[i];
      listaE.add(DropdownMenuItem(
        child: Text(item.nombreInstitucion),
        value: item.idInstitucion.toString(),
      ));
    }
    return listaE;
  }
}

class PageDocuments extends StatefulWidget {
  const PageDocuments({Key key}) : super(key: key);

  @override
  _PageDocumentsState createState() => _PageDocumentsState();
}

class _PageDocumentsState extends State<PageDocuments> {
  int valorTipoMaterial = 74;
  int valorTipoEspecialidad = 11;
  int valorOrganizacion = 1042;
  final generic = new Generic();
  String _notificacion = '';

  @override
  Widget build(BuildContext context) {
    final _valor = ModalRoute.of(context).settings.arguments;
    if (_valor != null) _notificacion = _valor;

    return SingleChildScrollView(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //campoBuscarPorInstitucionCategoria(),
              Center(
                child: contenedorTitulo(
                  context,
                  40.0,
                  "Lista de documentos".toUpperCase(),
                  FaIcon(FontAwesomeIcons.filePdf, color: AppTheme.themeVino),
                ),
              ),
              Opacity(
                  opacity: _notificacion.length > 1 ? 1.0 : 0.0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: AutoSizeText(
                      'Documento: Nuevo documento registrado.',
                      style: kSubTitleCardStyle,
                      maxLines: 1,
                      minFontSize: 13.0,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.justify,
                    ),
                  )),
              //_crearOrganizacion(),
              //_crearEspecialidad(),
              Center(
                  child: Text(
                "Nota: Presione sobre el video para ver el detalle",
                style: kSubSubTitleCardStyle,
              )),
              futureDocumentos(context),
              copyRigth(),
            ],
          ),
        ),
      ),
    );
  }

  Widget campoBuscarPorInstitucionCategoria() {
    return TextField(
      decoration: InputDecoration(
        border: InputBorder.none,
        prefixIcon: Icon(
          Icons.search,
          color: AppTheme.themeColorNaranja,
        ),
        hintText: "Buscar por institución / categoria",
        hintStyle: TextStyle(fontSize: 12, color: AppTheme.themeColorNaranja),
      ),
    );
  }

  Widget futureDocumentos(BuildContext context) {
    return FutureBuilder(
        future: Generic().getAll(new ListaMultimedia(),
            urlGetListaMultimedia + '/76', primaryKeyListaMultimedia),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
              break;
            default:
              //mostramos los datos
              return buildDocumentos(context, snapshot);
          }
        });
  }

  Widget buildDocumentos(BuildContext context, AsyncSnapshot snapshot) {
    return Container(
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: ClampingScrollPhysics(),
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) {
            ListaMultimedia item = snapshot.data[index];
            return itemDocumento(context, item);
          }),
    );
  }

  Widget itemDocumento(
      BuildContext context, ListaMultimedia multimediaDocumento) {
    return InkWell(
        child: ListTile(
          leading: Icon(
            Icons.description,
            size: 35,
          ),
          title: Text(
            multimediaDocumento.mulTitulo,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
          ),
          subtitle: Text(
            multimediaDocumento.mulResumen,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
          ),
          trailing: Icon(Icons.navigate_next),
        ),
        onTap: () {
          openWeb(multimediaDocumento.mulEnlace);
//PdfPagePreview pdf = new PdfPagePreview(imgPath: multimediaDocumento.mulEnlace,);

//          loadPDF(multimediaDocumento.mulEnlace);
          //print(multimediaDocumento.mulEnlace);
/*
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => PageViewModule(
                    title: multimediaDocumento.mulTitulo,
                    selectedUrl: multimediaDocumento.mulEnlace,
                  )));
                  */
        });
  }

  Widget _crearOrganizacion() {
    return Center(
        child: FutureBuilder(
            future: generic.getAll(
                new InstitucionesItems(),
                urlGetListaInstituciones +
                    '/' +
                    prefs.idDepartamento.toString(),
                primaryKeyGetListaInstituciones),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Row(
                  children: <Widget>[
                    SizedBox(width: 35.0),
                    Text('Organización:'),
                    SizedBox(width: 15.0),
                    DropdownButton(
                      icon: FaIcon(FontAwesomeIcons.sort,
                          color: AppTheme.themeVino),
                      value: valorOrganizacion.toString(),
                      items: getDropDown(snapshot),
                      onChanged: (value) {
                        setState(() {
                          valorOrganizacion = int.parse(value);
                          //print('valorTipoMaterial $valorTipoMaterial');
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

  Widget _crearEspecialidad() {
    return Center(
        child: FutureBuilder(
            future: generic.getAll(new GetClasificador(),
                urlGetClasificador + '10', primaryKeyGetClasifidor),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Row(
                  children: <Widget>[
                    SizedBox(width: 35.0),
                    Text('Tipo Material:'),
                    SizedBox(width: 15.0),
                    DropdownButton(
                      icon: FaIcon(FontAwesomeIcons.sort,
                          color: AppTheme.themeVino),
                      value: valorTipoEspecialidad.toString(),
                      items: getDropDownE(snapshot),
                      onChanged: (value) {
                        setState(() {
                          valorTipoEspecialidad = int.parse(value);
                          //print('valorTipoEspecialidad $valorTipoEspecialidad');
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

  List<DropdownMenuItem<String>> getDropDownE(AsyncSnapshot snapshot) {
    List<DropdownMenuItem<String>> listaE = new List();

    for (var i = 0; i < snapshot.data.length; i++) {
      GetClasificador item = snapshot.data[i];
      listaE.add(DropdownMenuItem(
        child: Text(item.nombre),
        value: item.id.toString(),
      ));
    }
    return listaE;
  }


  List<DropdownMenuItem<String>> getDropDown(AsyncSnapshot snapshot) {
    List<DropdownMenuItem<String>> listaE = new List();

    for (var i = 0; i < snapshot.data.length; i++) {
      InstitucionesItems item = snapshot.data[i];
      listaE.add(DropdownMenuItem(
        child: Text(item.nombreInstitucion),
        value: item.idInstitucion.toString(),
      ));
    }
    return listaE;
  }
}
