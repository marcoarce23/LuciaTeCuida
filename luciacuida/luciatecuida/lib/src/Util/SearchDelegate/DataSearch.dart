import 'package:flutter/material.dart';
import 'package:luciatecuida/src/Model/Entity.dart';
import 'package:luciatecuida/src/Model/Generic.dart';
import 'package:luciatecuida/src/module/Citizen/CitizenInstitution/CitizenInstitutionModule.dart';
import 'package:luciatecuida/src/module/Citizen/CitizenMultimedia/CitizenImageDetailModule.dart';
import 'package:luciatecuida/src/module/Citizen/Voluntary/FoundAllVoluntaryModule.dart';
import 'package:luciatecuida/src/module/Citizen/Voluntary/ListVoluntary.dart';
import 'package:luciatecuida/src/module/Settings/RoutesModule.dart';
import 'package:luciatecuida/src/module/UtilModule/PageViewModule.dart';

class DataSearchInstituciones extends SearchDelegate {
  int departamento = 60;

  DataSearchInstituciones(int departamento) {
    this.departamento = departamento;
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    //acctiones para limpiar el texto o cancelar la busqueda
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //icono a la izquierda de busqueda
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    //Builder que crea los resultados que vamos a mostrar
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //Son las sugerencias cuando la person escribe
    if (query.isEmpty) {
      return Container();
    } else {
      return FutureBuilder(
          future: Generic().getAll(
              new InstitucionesItems(),
              urlGetListaInstituciones + '/' + departamento.toString(),
              primaryKeyGetListaInstituciones),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
                break;
              default:
                if (snapshot.hasData) {
                  return ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: ClampingScrollPhysics(),
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        InstitucionesItems institutionItem =
                            snapshot.data[index];
                        if (institutionItem.nombreInstitucion
                            .toLowerCase()
                            .contains(query.toLowerCase())) {
                          return InkWell(
                            child: ListTile(
                              title: Text(institutionItem.nombreInstitucion),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        CitizenInstitutionModule(
                                          institutionItem: institutionItem,
                                        )),
                              );
                            },
                          );
                        }
                      });
                } else {
                  return Center(
                    child: Container(),
                  );
                }
            }
          });
    }
  }
}

class DataSearchMultimedia extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    //acctiones para limpiar el texto o cancelar la busqueda
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //icono a la izquierda de busqueda
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    //Builder que crea los resultados que vamos a mostrar
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //Son las sugerencias cuando la person escribe
    if (query.isEmpty) {
      return Container();
    } else {
      return FutureBuilder(
          future: Generic().getAll(new Multimedia(), urlGetMultimedia + '74',
              primaryKeyGetMultimedia),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
                break;
              default:
                if (snapshot.hasData) {
                  return ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: ClampingScrollPhysics(),
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        ListaMultimedia listaMultimedia = snapshot.data[index];
                        if (listaMultimedia.mulTitulo
                            .toLowerCase()
                            .contains(query.toLowerCase())) {
                          return InkWell(
                            child: ListTile(
                              title: Text(listaMultimedia.mulTitulo),
                              subtitle: Text(listaMultimedia.categoria),
                            ),
                            onTap: () {
                              if (listaMultimedia.idaCategoria == 74) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CitizenImageDetailModule(
                                            multimediaImagen: listaMultimedia,
                                          )),
                                );
                                //imagenes
                              }
                              if (listaMultimedia.idaCategoria == 75) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        PageViewModule(
                                          title: listaMultimedia.mulTitulo,
                                          selectedUrl:
                                              listaMultimedia.mulEnlace,
                                        )));
                                //videos
                              }
                              if (listaMultimedia.idaCategoria == 76) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        PageViewModule(
                                          title: listaMultimedia.mulTitulo,
                                          selectedUrl:
                                              listaMultimedia.mulEnlace,
                                        )));
                                //pdf
                              }
                            },
                          );
                        }
                      });
                } else {
                  return Center(
                    child: Container(),
                  );
                }
            }
          });
    }
  }
}

class DataSearchEncuentraUnAmigo extends SearchDelegate {
  int departamento = 60;

  DataSearchEncuentraUnAmigo(int departamento) {
    departamento = departamento;
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    //acctiones para limpiar el texto o cancelar la busqueda
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //icono a la izquierda de busqueda
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    //Builder que crea los resultados que vamos a mostrar
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //Son las sugerencias cuando la person escribe
    if (query.isEmpty) {
      return Container();
    } else {
      return FutureBuilder(
          future: Generic().getAll(
              new ProfesionalesAgrupados(),
              urlGetTodosGruposProfesionales+'/'+departamento.toString(),
              primaryKeyTodosGruposProfesionales),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
                break;
              default:
                if (snapshot.hasData) {
                  return ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: ClampingScrollPhysics(),
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        ProfesionalesAgrupados profesionalesAgrupados =
                            snapshot.data[index];
                        if (profesionalesAgrupados.profesion
                            .toLowerCase()
                            .contains(query.toLowerCase())) {
                           InkWell(
                            child: ListTile(
                              title: Text(profesionalesAgrupados.profesion),
                              subtitle: Text("Contamos con " +
                                  profesionalesAgrupados.cantidadProfesionales
                                      .toString() +
                                  " profesionales"),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        FoundAllVoluntaryModule(
                                          profesional: profesionalesAgrupados, departamento: departamento,
                                        )),
                              );
                            },
                          );
                        }
                      });
                } else {
                  return Center(
                    child: Container(),
                  );
                }
            }
          });
    }
  }
}

class DataSearchEvento extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    //acctiones para limpiar el texto o cancelar la busqueda
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //icono a la izquierda de busqueda
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    //Builder que crea los resultados que vamos a mostrar
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //Son las sugerencias cuando la person escribe
    if (query.isEmpty) {
      return Container();
    } else {
      return FutureBuilder(
          future: Generic().getAll(new ListaMultimedia(),
              urlGetListaMultimedia + '/74', primaryKeyListaMultimedia),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
                break;
              default:
                if (snapshot.hasData) {
                  return ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: ClampingScrollPhysics(),
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        ListaMultimedia listaMultimedia = snapshot.data[index];
                        if (listaMultimedia.mulTitulo
                            .toLowerCase()
                            .contains(query.toLowerCase())) {
                          return InkWell(
                            child: ListTile(
                              title: Text(listaMultimedia.mulTitulo),
                              subtitle: Text(listaMultimedia.categoria),
                            ),
                            onTap: () {
                              if (listaMultimedia.idaCategoria == 74) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CitizenImageDetailModule(
                                            multimediaImagen: listaMultimedia,
                                          )),
                                );
                                //imagenes
                              }
                              if (listaMultimedia.idaCategoria == 75) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        PageViewModule(
                                          title: listaMultimedia.mulTitulo,
                                          selectedUrl:
                                              listaMultimedia.mulEnlace,
                                        )));
                                //videos
                              }
                              if (listaMultimedia.idaCategoria == 76) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        PageViewModule(
                                          title: listaMultimedia.mulTitulo,
                                          selectedUrl:
                                              listaMultimedia.mulEnlace,
                                        )));
                                //pdf
                              }
                            },
                          );
                        }
                      });
                } else {
                  return Center(
                    child: Container(),
                  );
                }
            }
          });
    }
  }
}

class DataSearchVoluntary extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    //acctiones para limpiar el texto o cancelar la busqueda
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //icono a la izquierda de busqueda
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    //Builder que crea los resultados que vamos a mostrar
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //Son las sugerencias cuando la person escribe
    if (query.isEmpty) {
      return Container();
    } else {
      return FutureBuilder(
          future: Generic().getAll(new ListaMultimedia(),
              urlGetListaMultimedia + '/74', primaryKeyListaMultimedia),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
                break;
              default:
                if (snapshot.hasData) {
                  return ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: ClampingScrollPhysics(),
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        ListaMultimedia listaMultimedia = snapshot.data[index];
                        if (listaMultimedia.mulTitulo
                            .toLowerCase()
                            .contains(query.toLowerCase())) {
                          return InkWell(
                            child: ListTile(
                              title: Text(listaMultimedia.mulTitulo),
                              subtitle: Text(listaMultimedia.categoria),
                            ),
                            onTap: () {
                              if (listaMultimedia.idaCategoria == 74) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CitizenImageDetailModule(
                                            multimediaImagen: listaMultimedia,
                                          )),
                                );
                                //imagenes
                              }
                              if (listaMultimedia.idaCategoria == 75) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        PageViewModule(
                                          title: listaMultimedia.mulTitulo,
                                          selectedUrl:
                                              listaMultimedia.mulEnlace,
                                        )));
                                //videos
                              }
                              if (listaMultimedia.idaCategoria == 76) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        PageViewModule(
                                          title: listaMultimedia.mulTitulo,
                                          selectedUrl:
                                              listaMultimedia.mulEnlace,
                                        )));
                                //pdf
                              }
                            },
                          );
                        }
                      });
                } else {
                  return Center(
                    child: Container(),
                  );
                }
            }
          });
    }
  }
}

class DataSearchHelp extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    //acctiones para limpiar el texto o cancelar la busqueda
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //icono a la izquierda de busqueda
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    //Builder que crea los resultados que vamos a mostrar
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //Son las sugerencias cuando la person escribe
    if (query.isEmpty) {
      return Container();
    } else {
      return FutureBuilder(
          future: Generic().getAll(
              new Voluntary(), urlGetVoluntario, primaryKeyGetVoluntario),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
                break;
              default:
                if (snapshot.hasData) {
                  return ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: ClampingScrollPhysics(),
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        Voluntary list = snapshot.data[index];
                        if (list.perNombrepersonal
                            .toLowerCase()
                            .contains(query.toLowerCase())) {
                          return InkWell(
                            child: ListTile(
                              title: Text(list.perNombrepersonal),
                              subtitle: Text(list.perNombrepersonal),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ListVoluntaryModule()),
                              );
                            },
                          );
                        }
                      });
                } else {
                  return Center(
                    child: Container(),
                  );
                }
            }
          });
    }
  }
}
