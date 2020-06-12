import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:luciatecuida/src/Model/Entity.dart';
import 'package:luciatecuida/src/Model/Generic.dart';
import 'package:luciatecuida/src/Model/PreferenceUser.dart';
import 'package:luciatecuida/src/Theme/ThemeModule.dart';
import 'package:luciatecuida/src/Util/SearchDelegate/DataSearch.dart';
import 'package:luciatecuida/src/Util/Util.dart';
import 'package:luciatecuida/src/module/HomePage/HomePageModule.dart';
import 'package:luciatecuida/src/module/UtilModule/PageViewModule.dart';
import 'package:luciatecuida/src/module/UtilModule/PdfViewer.dart';
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
              icon: Icon(Icons.videocam),
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

class PagePicture extends StatelessWidget {
  const PagePicture({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              Center(
                  child: Text(
                "Presione sobre la imagen para ver el detalle",
                style: kSubSubTitleCardStyle,
              )),
              futureImagenes(context),
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
            padding: EdgeInsets.all(15),
            child: FadeInImage.assetNetwork(
              placeholder: "assets/loading/loadingImage.gif",
              placeholderScale: 0.2,
              image: multimediaImagen.mulEnlace,
              width: 150,
              height: 150,
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
                  width: 165,
                  color: Colors.white70,
                  padding: EdgeInsets.only(left: 18),
                  child: Text(
                    multimediaImagen.mulTitulo,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  )),
              Container(
                  width: 165,
                  color: Colors.white70,
                  padding: EdgeInsets.only(left: 18),
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
}

class PageVideo extends StatefulWidget {
  const PageVideo({Key key}) : super(key: key);

  @override
  _PageVideoState createState() => _PageVideoState();
}

class _PageVideoState extends State<PageVideo> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                FaIcon(FontAwesomeIcons.video, color: AppTheme.themeVino),
              ),
            ),
            Center(
                child: Text(
              "Presione sobre el video para ver el detalle",
              style: kSubSubTitleCardStyle,
            )),
            futureVideo(context),
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
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => PageViewModule(
                    title: multimediaVideo.mulTitulo,
                    selectedUrl: multimediaVideo.mulEnlace,
                  )));
        });
  }
}

class PageDocuments extends StatelessWidget {
  const PageDocuments({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              Center(
                  child: Text(
                "Presione sobre el video para ver el detalle",
                style: kSubSubTitleCardStyle,
              )),
              futureDocumentos(context),
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
PdfPagePreview pdf = new PdfPagePreview(imgPath: multimediaDocumento.mulEnlace,);



//          loadPDF(multimediaDocumento.mulEnlace);
          print(multimediaDocumento.mulEnlace);
/*
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => PageViewModule(
                    title: multimediaDocumento.mulTitulo,
                    selectedUrl: multimediaDocumento.mulEnlace,
                  )));
                  */
        });
  }
}
