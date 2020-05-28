
//////          MARCO           //////
// METODOS GET
final String getLogin                 = 'http://covid19.ruta88.net/COVID/Login/srvLogin.svc/DevuelveLogin/';
final String primaryKeyGetLogin       = '_DevuelveLoginResult';
final String primaryKeyGetClasifidor  = '_DevuelveClasificadorResult';
String urlGetClasificador             =  'http://covid19.ruta88.net/COVID/Clasificador/srvClasificador.svc/Clasificador/';

final String primaryKeyGetAyudaAmigo  = '_DevuelveAyudasResult';
String urlGetDevuelveAyuda            =    'http://covid19.ruta88.net/COVID/AyudaAmigo/srvAyudaAmigo.svc/DevuelveAyudas';

final String primaryKeyGetInsitucion = '_DevuelveInstitucionesResult';
String urlGetInstitucion             =    'http://covid19.ruta88.net/COVID/Institucion/srvInstitucion.svc/DevuelveInstitucion';

final String primaryKeyGetVoluntario = '_DevuelvePersonalResult';
String urlGetVoluntario              =    'http://covid19.ruta88.net/COVID/Personal/srvPersonal.svc/DevuelvePersonal';

String urlGetAtencion                =    'http://covid19.ruta88.net/COVID/Atencion/srvAtencion.svc/DevuelveAtencion/{pIdInstitucion}/{pIdPersonal} ';

String urlGetMultimedia              =    'http://covid19.ruta88.net/COVID/Multimedia/srvMultimedia.svc/ListaMultimedias/';
String primaryKeyGetMultimedia       =    '_DevuelveListaMultimediaResult';

String urlGetEvento                  =    'http://covid19.ruta88.net/COVID/Evento/srvEvento.svc/Eventos/';
String primaryKeyGetEvento           = '_DevuelveEventosResult';

// METODO POST
final String urlAddVoluntary   =    'http://covid19.ruta88.net/COVID/AyudaAmigo/srvAyudaAmigo.svc/AyudaAmigo';
final String urlAddSignIn      =    'http://covid19.ruta88.net/COVID/Login/srvLogin.svc/login_signin1';
final String urlAddInstitucion =    'http://covid19.ruta88.net/COVID/Institucion/srvInstitucion.svc/Institucion';
final String urlAddPersonal    =    'http://covid19.ruta88.net/COVID/Personal/srvPersonal.svc/Personal';
final String urlAddMultimedia  =    'http://covid19.ruta88.net/COVID/Multimedia/srvMultimedia.svc/Multimedia';
final String urlAddEvento      =    'http://covid19.ruta88.net/COVID/Evento/srvEvento.svc/Evento';
final String urlAddAtencion    =    'http://covid19.ruta88.net/COVID/Atencion/srvAtencion.svc/Atencion';
final String urlAddAtencionInstitucion    =    'http://covid19.ruta88.net/COVID/Atencion/srvAtencion.svc/AtencionInstitucion';

// METODO DELETE
final String urlDeleteAyudaAmigo  =  'http://covid19.ruta88.net/COVID/AyudaAmigo/srvAyudaAmigo.svc/EliminarAyudaAmigo/';
final String urlDeleteVoluntario  =  'http://covid19.ruta88.net/COVID/Personal/srvPersonal.svc/EliminarPersonal/';
final String urlDeleteInstitucion =  'http://covid19.ruta88.net/COVID/Institucion/srvInstitucion.svc/DevuelveInstitucion/EliminarInstitucion';
final String urlDeleteEvento ='';
final String urlDeleteMultimedia = '';
//////          CHRISS           //////

// METODOS GET
final String primaryKeyGetListaInstituciones =
    '_DevuelveListaInstitucionesResult';
String urlGetListaInstituciones =
    'http://covid19.ruta88.net/COVID/Institucion/srvInstitucion.svc/DevuelveListaInstitucion';
final String primaryKeyGrupoProfesionales =
    '_DevuelveGrupoProfesionalesResult';
String urlGetGrupoProfesionales =
    'http://covid19.ruta88.net/COVID/Institucion/srvInstitucion.svc/DevuelveGrupoProfesionales';
final String primaryKeyListaProfesionalesInstitucion =
    '_DevuelveListaProfesionalesInstitucionResult';
String urlGetListaProfesionalesInstitucion =
    'http://covid19.ruta88.net/COVID/Personal/srvPersonal.svc/DevuelveListaProfesionalesInstitucion';    
final String primaryKeyListaMultimedia =
    '_DevuelveListaMultimediaResult';
String urlGetListaMultimedia =
    'http://covid19.ruta88.net/COVID/Multimedia/srvMultimedia.svc/ListaMultimedias';
final String primaryKeyListaMultimediaPorInstitucion =
    '_DevuelveListaMultimediaPorInstitucionResult';
String urlGetListaMultimediaPorInstitucion =
    'http://covid19.ruta88.net/COVID/Multimedia/srvMultimedia.svc/ListaMultimediasPorInstitucion';
final String primaryKeyTodosGruposProfesionales =
    '_DevuelveTodosGrupoProfesionalesResult';
String urlGetTodosGruposProfesionales =
    'http://covid19.ruta88.net/COVID/Institucion/srvInstitucion.svc/DevuelveTodosGrupoProfesionales';
final String primaryKeyListaEventos =
    '_DevuelveListaEventosResult';
String urlGetListaEventos =
    'http://covid19.ruta88.net/COVID/Evento/srvEvento.svc/ListaEventos';





final String primaryKeyListaSolicitudesAyudas =
    '_DevuelveListaSolicitudesResult';
String urlGetListaSolicitudesAyudas =
    'http://covid19.ruta88.net/COVID/BotonPanico/srvBotonPanico.svc/ListaSolicitudes';


    final String primaryKeyHistorialListaSolicitudesAyudas =
    '_DevuelveHistorialListaSolicitudesResult';
String urlGetHistorialListaSolicitudesAyudas =
    'http://covid19.ruta88.net/COVID/BotonPanico/srvBotonPanico.svc/HistorialListaSolicitudes';


// METODO POST
final String urlAddBotonPanico =
    'http://covid19.ruta88.net/COVID/BotonPanico/srvBotonPanico.svc/BotonAyuda';
    final String urlAddSolicitudAyud =
    'http://covid19.ruta88.net/COVID/Atencion/srvAtencion.svc/SolicitudAyuda';


    final String urlAddSolicitudAyudaAmigo =
    'http://covid19.ruta88.net/COVID/Atencion/srvAtencion.svc/SolicitudAyudaAmigo';


    

// METODO DELETE
