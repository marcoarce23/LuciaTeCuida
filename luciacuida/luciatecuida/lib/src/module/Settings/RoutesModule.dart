
//////          MARCO           //////
// METODOS GET
final String getLogin                 =   'http://covid19.ruta88.net/COVID/Login/srvLogin.svc/DevuelveLogin/';
final String primaryKeyGetLogin       =   '_DevuelveLoginResult';
final String primaryKeyGetClasifidor  =   '_DevuelveClasificadorResult';
String urlGetClasificador             =   'http://covid19.ruta88.net/COVID/Clasificador/srvClasificador.svc/Clasificador/';

String urlGetDepartamento             =   'http://covid19.ruta88.net/COVID/Clasificador/srvClasificador.svc/DevuelveUbicacionesHabilitadas';
String primaryKeyGetDepartamento      =   '_DevuelveUbicacionesHabilitadasResult';

final String primaryKeyGetAyudaAmigo  =   '_DevuelveAyudasResult';
String urlGetDevuelveAyuda            =   'http://covid19.ruta88.net/COVID/AyudaAmigo/srvAyudaAmigo.svc/DevuelveAyudas';

final String primaryKeyGetInsitucion =    '_DevuelveInstitucionesResult';
String urlGetInstitucion             =    'http://covid19.ruta88.net/COVID/Institucion/srvInstitucion.svc/DevuelveInstitucion/';


final String primaryKeyGetVoluntario =    '_DevuelvePersonalResult';
String urlGetVoluntario              =    'http://covid19.ruta88.net/COVID/Personal/srvPersonal.svc/DevuelvePersonal/';
final String primaryKeyGetVoluntario1=    'DevuelveVoluntariosPorInstitucionResult';
String urlGetVoluntario1             =    'http://covid19.ruta88.net/COVID/Personal/srvPersonal.svc/DevuelveVoluntariosPorInstitucion/';




final String primaryKeyGetInstitucionCreacion=    '_DevuelveInstitucionesCreadaResult';
String urlGetInstitucionCreacion             =    'http://covid19.ruta88.net/COVID/Institucion/srvInstitucion.svc/DevuelveInstitucionCreada/';





String urlGetAtencion                =    'http://covid19.ruta88.net/COVID/Atencion/srvAtencion.svc/DevuelveAtencion/{pIdInstitucion}/{pIdPersonal} ';

String urlGetMultimedia              =    'http://covid19.ruta88.net/COVID/Multimedia/srvMultimedia.svc/ListaMultimedias/';
String primaryKeyGetMultimedia       =    '_DevuelveListaMultimediaResult';

String urlGetEvento                  =    'http://covid19.ruta88.net/COVID/Evento/srvEvento.svc/Eventos/';
String primaryKeyGetEvento           =    '_DevuelveEventosResult';

final String getContactos            =    'http://covid19.ruta88.net/COVID/Login/srvLogin.svc/DevuelveContacto';
final String primaryKeyGetContacto   =    '_DevuelveContactoResult';

final String getEmergency            =    'http://covid19.ruta88.net/COVID/Login/srvLogin.svc/DevuelveEmergencia';
final String primaryKeyGetEmergency  =    '_DevuelveEmergencyResult';

final String urlGetToken             =    'http://covid19.ruta88.net/COVID/Login/srvLogin.svc/DevuelveTokens/';
final String primaryKeyGetToken      =    '_DevuelveTokenResult';

final String primaryKeyGetPlasma =    '_DevuelvePlasmaResult';
String urlGetPlasma            =    'http://covid19.ruta88.net/COVID/BotonPanico/srvBotonPanico.svc/DevuelvePlasma/';

// METODO POST  MAV
final String urlAddVoluntary         =    'http://covid19.ruta88.net/COVID/AyudaAmigo/srvAyudaAmigo.svc/AyudaAmigo';
final String urlAddSignIn            =    'http://covid19.ruta88.net/COVID/Login/srvLogin.svc/login_signin1';
final String urlAddInstitucion       =    'http://covid19.ruta88.net/COVID/Institucion/srvInstitucion.svc/Institucion';
final String urlAddPersonal          =    'http://covid19.ruta88.net/COVID/Personal/srvPersonal.svc/Personal';
final String urlAddMultimedia        =    'http://covid19.ruta88.net/COVID/Multimedia/srvMultimedia.svc/Multimedia';
final String urlAddEvento            =    'http://covid19.ruta88.net/COVID/Evento/srvEvento.svc/Evento';
final String urlAddAtencion          =    'http://covid19.ruta88.net/COVID/Atencion/srvAtencion.svc/Atencion';
final String urlAddAtencionInstitucion=   'http://covid19.ruta88.net/COVID/Atencion/srvAtencion.svc/AtencionInstitucion';
final String urlAddTokenImei         =    'http://covid19.ruta88.net/COVID/Login/srvLogin.svc/RegistrarDispositivo';
final String urlAprobar              =    'http://covid19.ruta88.net/COVID/Personal/srvPersonal.svc/EstadoPersonal/';
final String urlAddPlasma        =    'http://covid19.ruta88.net/COVID/BotonPanico/srvBotonPanico.svc/BancoSangre';

// METODO POST COAV
final String urlAddBotonPanico              =   'http://covid19.ruta88.net/COVID/BotonPanico/srvBotonPanico.svc/BotonAyuda';
final String urlAddSolicitudAyud            =   'http://covid19.ruta88.net/COVID/Atencion/srvAtencion.svc/SolicitudAyuda';
final String urlAddSolicitudAyudaAmigo      =   'http://covid19.ruta88.net/COVID/Atencion/srvAtencion.svc/SolicitudAyudaAmigo';

// METODO DELETE
final String urlDeleteAyudaAmigo     =    'http://covid19.ruta88.net/COVID/AyudaAmigo/srvAyudaAmigo.svc/EliminarAyudaAmigo/';
final String urlDeleteVoluntario     =    'http://covid19.ruta88.net/COVID/Personal/srvPersonal.svc/EliminarPersonal/';
final String urlDeleteInstitucion    =    'http://covid19.ruta88.net/COVID/Institucion/srvInstitucion.svc/EliminarInstitucion/';
final String urlDeleteEvento         =    'http://covid19.ruta88.net/COVID/Evento/srvEvento.svc/EliminarEvento/';
final String urlDeleteMultimedia     =    'http://covid19.ruta88.net/COVID/Multimedia/srvMultimedia.svc/EliminarMultimedia/';
final String urlDeletePlasma     =    'http://covid19.ruta88.net/COVID/BotonPanico/srvBotonPanico.svc/EliminarBancoSangre/';
//////          CHRISS           //////

// METODOS GET    COAV
final String primaryKeyGetListaInstituciones =  '_DevuelveListaInstitucionesResult';
String urlGetListaInstituciones              =  'http://covid19.ruta88.net/COVID/Institucion/srvInstitucion.svc/DevuelveListaInstitucion';

final String primaryKeyGrupoProfesionales    =  '_DevuelveGrupoProfesionalesResult';
String urlGetGrupoProfesionales              =  'http://covid19.ruta88.net/COVID/Institucion/srvInstitucion.svc/DevuelveGrupoProfesionales';

final String primaryKeyListaProfesionalesInstitucion =  '_DevuelveListaProfesionalesInstitucionResult';
String urlGetListaProfesionalesInstitucion   =    'http://covid19.ruta88.net/COVID/Personal/srvPersonal.svc/DevuelveListaProfesionalesInstitucion';    

final String primaryKeyListaMultimedia       =    '_DevuelveListaMultimediaResult';
String urlGetListaMultimedia                 =    'http://covid19.ruta88.net/COVID/Multimedia/srvMultimedia.svc/ListaMultimedias';

final String primaryKeyListaMultimediaPorInstitucion =   '_DevuelveListaMultimediaPorInstitucionResult';
String urlGetListaMultimediaPorInstitucion   =   'http://covid19.ruta88.net/COVID/Multimedia/srvMultimedia.svc/ListaMultimediasPorInstitucion';

final String primaryKeyTodosGruposProfesionales =   '_DevuelveTodosGrupoProfesionalesResult';
String urlGetTodosGruposProfesionales        =   'http://covid19.ruta88.net/COVID/Institucion/srvInstitucion.svc/DevuelveTodosGrupoProfesionales';

final String primaryKeyListaEventos          =   '_DevuelveListaEventosResult';
String urlGetListaEventos                    =    'http://covid19.ruta88.net/COVID/Evento/srvEvento.svc/ListaEventos';

final String primaryKeyListaSolicitudesAyudas=    '_DevuelveListaSolicitudesResult';
String urlGetListaSolicitudesAyudas          =    'http://covid19.ruta88.net/COVID/BotonPanico/srvBotonPanico.svc/ListaSolicitudes';


final String primaryKeyHistorialListaSolicitudesAyudas = '_DevuelveHistorialListaSolicitudesResult';
String urlGetHistorialListaSolicitudesAyudas =    'http://covid19.ruta88.net/COVID/BotonPanico/srvBotonPanico.svc/HistorialListaSolicitudes';

 final String primaryKeyGetDevuelveHorariosAtencionInstitucion =    '_DevuelveHorarioAtencionResult';
String urlGetDevuelveHorariosAtencionInstitucion ='http://covid19.ruta88.net/COVID/Institucion/srvInstitucion.svc/DevuelveHorarioAtencion';

