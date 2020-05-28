abstract class Entity {
  fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson();
}

class Institucion extends Entity {
  int idInstitucion;
  String foto;
  double insLat;
  double insLng;
  int tipoInstitucion;
  String token;
  String nombreInstitucion;
  int ubicacion;
  String direccion;
  String telefono;
  String perInformacionComp;
  String perFacebbok;
  String perTwitter;
  String perPaginaWeb;
  String perYouTube;
  String perCorreoElectronico;
  String usuario;
  String desInsitucion;
  String desUbicacion;

  Institucion(
      {this.idInstitucion,
      this.foto,
      this.insLat,
      this.insLng,
      this.tipoInstitucion,
      this.token,
      this.nombreInstitucion,
      this.ubicacion,
      this.direccion,
      this.telefono,
      this.perInformacionComp,
      this.perFacebbok,
      this.perTwitter,
      this.perPaginaWeb,
      this.perYouTube,
      this.perCorreoElectronico,
      this.usuario,
      this.desInsitucion,
      this.desUbicacion});

  fromJson(Map<String, dynamic> json) => new Institucion(
        idInstitucion: json["IDCOV_INSTITUCION"],
        foto: json["INS_FOTO"],
        insLat: json["INS_LAT"],
        insLng: json["INS_LNG"],
        tipoInstitucion: json["IDA_TIPOINSTITUCION"],
        token: json["INS_TOKEN"],
        nombreInstitucion: json["INS_NOMBREINSTITUCION"],
        ubicacion: json["IDA_UBICACION"],
        direccion: json["INS_DIRECCION"],
        telefono: json["INS_TELEFONO"],
        perInformacionComp: json["INS_INFORMACIONCOMPLEMENTARIA"],
        perFacebbok: json["INS_CUENTACEBOOK"],
        perTwitter: json["INS_CUENTATWITTER"],
        perPaginaWeb: json["INS_PAGINAWEB"],
        perYouTube: json["INS_CUENTAYOUTUBE"],
        perCorreoElectronico: json["INS_CORREOINSTITUCIONAL"],
        usuario: json["USUARIO"],
        desInsitucion: json["DES_INSTITUCION"],
        desUbicacion: json["DES_UBICACION"],
      );

  Map<String, dynamic> toJson() => {
        "IDCOV_INSTITUCION": idInstitucion,
        "INS_FOTO": foto,
        "INS_LAT": insLat,
        "INS_LNG": insLng,
        "IDA_TIPOINSTITUCION": tipoInstitucion,
        "INS_TOKEN": token,
        "INS_NOMBREINSTITUCION": nombreInstitucion,
        "IDA_UBICACION": ubicacion,
        "INS_DIRECCION": direccion,
        "INS_TELEFONO": telefono,
        "INS_INFORMACIONCOMPLEMENTARIA": perInformacionComp,
        "INS_CUENTACEBOOK": perFacebbok,
        "INS_CUENTATWITTER": perTwitter,
        "INS_PAGINAWEB": perPaginaWeb,
        "INS_CUENTAYOUTUBE": perYouTube,
        "INS_CORREOINSTITUCIONAL": perCorreoElectronico,
        "USUARIO": usuario,
        "DES_INSTITUCION": desInsitucion,
        "DES_UBICACION": desUbicacion
      };
}

class Atencion extends Entity {
  int idInstitucion;
  int idInstitucionPersonal;
  int perLunes;
  int perMartes;
  int perMiercoles;
  int perJueves;
  int perViernes;
  int perSabado;
  int perDomingo;
  String perLunesH;
  String perMartesH;
  String perMiercolesH;
  String perJuevesH;
  String perViernesH;
  String perSabadoH;
  String perDomingoH;
  String usuario;

  Atencion({
    this.idInstitucion,
    this.idInstitucionPersonal,
    this.perLunes,
    this.perMartes,
    this.perMiercoles,
    this.perJueves,
    this.perViernes,
    this.perSabado,
    this.perDomingo,
    this.perLunesH,
    this.perMartesH,
    this.perMiercolesH,
    this.perJuevesH,
    this.perViernesH,
    this.perSabadoH,
    this.perDomingoH,
    this.usuario,
  });

  fromJson(Map<String, dynamic> json) => new Atencion(
      idInstitucion: json["IDCOV_INSTITUCION"],
      idInstitucionPersonal: json["IDCOV_ENTITY_PERSONAL"],
      perLunes: json["INS_LUNES"],
      perMartes: json["INS_MARTES"],
      perMiercoles: json["INS_MIERCOLES"],
      perJueves: json["INS_JUEVES"],
      perViernes: json["INS_VIERNES"],
      perSabado: json["INS_SABADO"],
      perDomingo: json["INS_DOMINGO"],
      perLunesH: json["INS_LUNES_HORARIO"],
      perMartesH: json["INS_MARTES_HORARIO"],
      perMiercolesH: json["INS_MIERCOLES_HORARIO"],
      perJuevesH: json["INS_JUEVES_HORARIO"],
      perViernesH: json["INS_VIERNES_HORARIO"],
      perSabadoH: json["INS_SABADO_HORARIO"],
      perDomingoH: json["INS_DOMINGO_HORARIO"],
      usuario: json["USUARIO"]);

  Map<String, dynamic> toJson() => {
        "IDCOV_INSTITUCION": idInstitucion,
        "IDCOV_ENTITY_PERSONAL": idInstitucionPersonal,
        "INS_LUNES": perLunes,
        "INS_MARTES": perMartes,
        "INS_MIERCOLES": perMiercoles,
        "INS_JUEVES": perJueves,
        "INS_VIERNES": perViernes,
        "INS_SABADO": perSabado,
        "INS_DOMINGO": perDomingo,
        "INS_LUNES_HORARIO": perLunesH,
        "INS_MARTES_HORARIO": perMartesH,
        "INS_MIERCOLES_HORARIO": perMiercolesH,
        "INS_JUEVES_HORARIO": perJuevesH,
        "INS_VIERNES_HORARIO": perViernesH,
        "INS_SABADO_HORARIO": perSabadoH,
        "INS_DOMINGO_HORARIO": perDomingoH,
        "USUARIO": usuario
      };
}

class Evento extends Entity {
  int idcovEvento;
  int idcovInstitucion;
  int idcovPersonal;
  String eveTitulo;
  String eveObjetivo;
  String eveDirigidoA;
  String eveExpositor;
  String eveUbicacion;
  String eveFecha;
  String eveHora;
  String eveFoto;
  String usuario;

  Evento(
      {this.idcovEvento = 0,
      this.idcovInstitucion,
      this.idcovPersonal,
      this.eveTitulo,
      this.eveObjetivo,
      this.eveDirigidoA,
      this.eveExpositor,
      this.eveUbicacion,
      this.eveFecha,
      this.eveHora,
      this.eveFoto,
      this.usuario});

  fromJson(Map<String, dynamic> json) => new Evento(
        idcovEvento: json["IDCOV_EVENTO"],
        idcovInstitucion: json["IDCOV_INSTITUCION"],
        idcovPersonal: json["IDCOV_PERSONAL"],
        eveTitulo: json["EVE_TITULO"],
        eveObjetivo: json["EVE_OBJETIVO"],
        eveDirigidoA: json["EVE_DIRIGIDOA"],
        eveExpositor: json["EVE_EXPOSITOR"],
        eveUbicacion: json["EVE_UBICACION"],
        eveFecha: json["EVE_FECHA"],
        eveHora: json["EVE_HORA"],
        eveFoto: json["EVE_FOTO"],
        usuario: json["USUARIO"],
      );



  Map<String, dynamic> toJson() => {
        "IDCOV_EVENTO": idcovEvento,
        "IDCOV_INSTITUCION": idcovInstitucion,
        "IDCOV_PERSONAL": idcovPersonal,
        "EVE_TITULO": eveTitulo,
        "EVE_OBJETIVO": eveObjetivo,
        "EVE_DIRIGIDOA": eveDirigidoA,
        "EVE_EXPOSITOR": eveExpositor,
        "EVE_UBICACION": eveUbicacion,
        "EVE_FECHA": eveFecha,
        "EVE_HORA": eveHora,
        "EVE_FOTO": eveFoto,
        "USUARIO": usuario,
      };
}

class Multimedia extends Entity {
  int idcovMultimedia;
  int idaCategoria;
  int idaCovInstitucion;
  int idaTIpoMaterial;
  String mulTitulo;
  String mulResumen;
  String detFechaInicio;
  String detFechaFin;
  String mulEnlace;
  String usuario;
String tipoMaterial;

  Multimedia(
      {this.idcovMultimedia,
      this.idaCategoria = 0,
      this.idaCovInstitucion,
      this.idaTIpoMaterial,
      this.mulTitulo,
      this.mulResumen,
      this.detFechaInicio,
      this.detFechaFin,
      this.mulEnlace,
      this.tipoMaterial,
      this.usuario});


  fromJson(Map<String, dynamic> json) => new Multimedia(
        idcovMultimedia: json["IDCOV_MULTIMEDIA"],
        idaCategoria: json["IDA_CATEGORIA"],
        idaTIpoMaterial: json["IDA_TIPOMATERIAL"],
        idaCovInstitucion: json["IDCOV_INSTITUCION"],
        mulTitulo: json["MUL_TITULO"],
        mulResumen: json["MUL_RESUMEN"],
        detFechaInicio: json["MUL_FECHAINICIO"],
        detFechaFin: json["MUL_FECHAFIN"],
        mulEnlace: json["MUL_ENLACE"],
       tipoMaterial: json["TIPO_MATERIAL"],
        usuario: json["USUARIO"],
      );

  Map<String, dynamic> toJson() => {
        "IDCOV_MULTIMEDIA": idcovMultimedia,
        "IDA_CATEGORIA": idaCategoria,
        "IDA_TIPOMATERIAL": idaTIpoMaterial,
        "IDCOV_INSTITUCION": idaCovInstitucion,
        "MUL_TITULO": mulTitulo,
        "MUL_RESUMEN": mulResumen,
        "MUL_FECHAINICIO": detFechaInicio,
        "MUL_FECHAFIN": detFechaFin,
        "MUL_ENLACE": mulEnlace,
        "TIPO_MATERIAL": tipoMaterial,
        "USUARIO": usuario
      };
}

class Voluntary extends Entity {
  int idcovPersonal;
  String foto;
  int idcovInstitucion;
  int idcovLogin;
  int idaTipopersonal;
  String perNombrepersonal;
  String perApellido;
  String perCorreo;
  String perTelefono;
  int perAyudacovid;
  String perCI;
  int idaExtension;
  int idaSexo;
  String perInformacionComplementaria;
  String perFacebbok;
  String perTwitter;
  String perPaginaWeb;
  String desInstitucion;
  String desEspecialidad;
  String desExpedido;
  String usuario;

  Voluntary(
      {this.idcovPersonal = 0,
      this.foto,
      this.idcovInstitucion,
      this.idcovLogin,
      this.idaTipopersonal,
      this.perNombrepersonal,
      this.perApellido,
      this.perCorreo,
      this.perTelefono,
      this.perAyudacovid,
      this.perCI,
      this.idaExtension,
      this.idaSexo,
      this.perInformacionComplementaria,
      this.perFacebbok,
      this.perTwitter,
      //  this.perYouTube,

      this.perPaginaWeb,
      this.desInstitucion,
      this.desEspecialidad,
      this.desExpedido,
      this.usuario});

  fromJson(Map<String, dynamic> json) => new Voluntary(
      idcovPersonal: json["IDCOV_PERSONAL"],
      foto: json["PER_FOTO"],
      idcovInstitucion: json["IDCOV_INSTITUCION"],
      idcovLogin: json["IDCOV_LOGIN"],
      idaTipopersonal: json["IDA_TIPOPERSONAL"],
      perNombrepersonal: json["PER_NOMBREPERSONAL"],
      perApellido: json["PER_APELLIDO"],
      perCorreo: json["PER_CORREO"],
      perTelefono: json["PER_TELEFONO"],
      perAyudacovid: json["PER_AYUDACOVID"],
      perCI: json["PER_CI"],
      idaExtension: json["IDA_EXTENCIONCI"],
      idaSexo: json["IDA_SEXO"],
      perInformacionComplementaria: json["PER_INFORMACIONCOMPLEMENTARIA"],
      perFacebbok: json["PER_CUENTAFACEBOOK"],
      perTwitter: json["PER_CUENTATWITTER"],
      perPaginaWeb: json["PER_PAGINAWEB"],
      desInstitucion: json["DES_INSTITUCION"],
      desEspecialidad: json["DES_ESPECIALIDAD"],
      desExpedido: json["DES_EXPEDIDO"],
      usuario: json["USUARIO"]);

  Map<String, dynamic> toJson() => {
        "IDCOV_PERSONAL": idcovPersonal,
        "PER_FOTO": foto,
        "IDCOV_INSTITUCION": idcovInstitucion,
        "IDCOV_LOGIN": idcovLogin,
        "IDA_TIPOPERSONAL": idaTipopersonal,
        "PER_NOMBREPERSONAL": perNombrepersonal,
        "PER_APELLIDO": perApellido,
        "PER_CORREO": perCorreo,
        "PER_TELEFONO": perTelefono,
        "PER_AYUDACOVID": perAyudacovid,
        "PER_CI": perCI,
        "IDA_EXTENCIONCI": idaExtension,
        "IDA_SEXO": idaSexo,
        "PER_INFORMACIONCOMPLEMENTARIA": perInformacionComplementaria,
        "PER_CUENTAFACEBOOK": perFacebbok,
        "PER_CUENTATWITTER": perTwitter,
        //   "PER_CUENTATWITTER": perYouTube,
        "PER_PAGINAWEB": perPaginaWeb,
        "DES_INSTITUCION": desInstitucion,
        "DES_ESPECIALIDAD": desEspecialidad,
        "DES_EXPEDIDO": desExpedido,
        "USUARIO": usuario
      };
}

class VoluntarioAtencion extends Entity {
  int idCovAtencion;
  int idCovEntityPersonal;
  int perLunes;
  int perMartes;
  int perMiercoles;
  int perJueves;
  int perViernes;
  int perSabado;
  int perDomingo;
  String usuario;

  VoluntarioAtencion(
      {this.idCovAtencion = 0,
      this.idCovEntityPersonal,
      this.perLunes,
      this.perMartes,
      this.perMiercoles,
      this.perJueves,
      this.perViernes,
      this.perSabado,
      this.perDomingo,
      this.usuario});

  fromJson(Map<String, dynamic> json) => new VoluntarioAtencion(
      idCovAtencion: json["IDCOV_ATENCION"],
      idCovEntityPersonal: json["IDCOV_ENTITY_PERSONAL"],
      perLunes: json["PER_LUNES"],
      perMartes: json["PER_MARTES"],
      perMiercoles: json["PER_MIERCOLES"],
      perJueves: json["PER_JUEVES"],
      perViernes: json["PER_VIERNES"],
      perSabado: json["PER_SABADO"],
      perDomingo: json["PER_DOMINGO"],
      usuario: json["USUARIO"]);

  Map<String, dynamic> toJson() => {
        "IDCOV_ATENCION": idCovAtencion,
        "IDCOV_ENTITY_PERSONAL": idCovEntityPersonal,
        "PER_LUNES": perLunes,
        "PER_MARTES": perMartes,
        "PER_MIERCOLES": perMiercoles,
        "PER_JUEVES": perJueves,
        "PER_VIERNES": perViernes,
        "PER_SABADO": perSabado,
        "PER_DOMINGO": perDomingo,
        "USUARIO": usuario
      };
}

class RegistroAmigo extends Entity {
  int idcovRegistroAmigo;
  String regPersona;
  String regTelefono;
  String regUbicacion;
  int regTipoAPoyo;
  String regPrioridad;
  String usuario;
  double latitud;
  double longitud;

  RegistroAmigo(
      {this.idcovRegistroAmigo = 0,
      this.regPersona,
      this.regTelefono,
      this.regUbicacion,
      this.regTipoAPoyo,
      this.regPrioridad,
      this.latitud,
      this.longitud,
      this.usuario});

  fromJson(Map<String, dynamic> json) => new RegistroAmigo(
        idcovRegistroAmigo: json["IDCOV_REGISTRAAMIGO"],
        regPersona: json["REG_PERSONA"],
        regTelefono: json["REG_TELEFONO"],
        regUbicacion: json["REG_UBICACION"],
        regTipoAPoyo: json["IDA_TIPOAPOYO"],
        regPrioridad: json["REG_PRIORIDAD"],
        latitud: json["LATITUD"],
        longitud: json["LONGITUD"],
        usuario: json["USUARIO"],
      );

  Map<String, dynamic> toJson() => {
        "IDCOV_REGISTRAAMIGO": idcovRegistroAmigo,
        "REG_PERSONA": regPersona,
        "REG_TELEFONO": regTelefono,
        "REG_UBICACION": regUbicacion,
        "IDA_TIPOAPOYO": regTipoAPoyo,
        "REG_PRIORIDAD": regPrioridad,
        "LATITUD": latitud,
        "LONGITUD": longitud,
        "USUARIO": usuario,
      };
}

class BotonPanico extends Entity {
  int idcovBotonpanico;
  int idaCatalogo;
  String botDetalle;
  int idaPrioridad;
  double botCordenadalat;
  double botCordenadalon;
  //DateTime botFecha;
  String botFecha;
  int idaEstadoSolicitud;
  String botTelefono;
  String usuario;
  int idLogin;

  BotonPanico(
      {this.idcovBotonpanico = 0,
      this.idaCatalogo,
      this.idLogin,
      this.botDetalle,
      this.idaPrioridad = 70,
      this.botCordenadalat,
      this.botCordenadalon,
      this.botFecha,
      this.idaEstadoSolicitud,
      this.botTelefono,
      this.usuario});

  fromJson(Map<String, dynamic> json) => new BotonPanico(
      idcovBotonpanico: json["IDCOV_BOTONPANICO"],
      idaCatalogo: json["IDA_CATALOGO"],
      idLogin: json["IDCOV_LOGIN"],
      botDetalle: json["BOT_DETALLE"],
      idaPrioridad: json["IDA_PRIORIDAD"],
      botCordenadalat: json["BOT_CORDENADALAT"],
      botCordenadalon: json["BOT_CORDENADALON"],
      botFecha: json["BOT_FECHA"],
      idaEstadoSolicitud: json["IDA_ESTADOSOLICITUD"],
      botTelefono: json["BOT_TELEFONO"],
      usuario: json["USUARIO"]);

  Map<String, dynamic> toJson() => {
        "IDCOV_BOTONPANICO": idcovBotonpanico,
        "IDA_CATALOGO": idaCatalogo,
        "BOT_DETALLE": botDetalle,
        "IDA_PRIORIDAD": idaPrioridad,
        "IDCOV_LOGIN": idLogin,
        "BOT_CORDENADALAT": botCordenadalat,
        "BOT_CORDENADALON": botCordenadalon,
        "BOT_FECHA": botFecha,
        "IDA_ESTADOSOLICITUD": idaEstadoSolicitud,
        "BOT_TELEFONO": botTelefono,
        "USUARIO": usuario
      };
}

class GetClasificador extends Entity {
  int id;
  String nombre;
  String detalle;

  GetClasificador({this.id, this.nombre, this.detalle});

  fromJson(Map<String, dynamic> json) => new GetClasificador(
        id: json["ID"],
        nombre: json["NOMBRE"],
        detalle: json["DETALLE"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "NOMBRE": nombre,
        "DETALLE": detalle,
      };
}

class LoginSigIn extends Entity {
  String idUsuario;
  String idInstitucion;
  String nombrePersona;
  String correo;
  String nombreInstitucion;
  String usuario;
  String avatar;
  String password;
  String imei;
  String tokenDispositivo;
  String primeraVez;
  String idPersonal;

  LoginSigIn(
      {this.idUsuario,
      this.idInstitucion,
      this.nombrePersona,
      this.idPersonal,
      this.nombreInstitucion,
      this.correo,
      this.usuario,
      this.password,
      this.avatar,
      this.imei,
      this.tokenDispositivo,
      this.primeraVez});

  fromJson(Map<String, dynamic> json) => new LoginSigIn(
        idUsuario: json["ID_USUARIO"],
        idInstitucion: json["ID_INSTITUCION"],
        nombrePersona: json["NOMBRE_PERSONA"],
        nombreInstitucion: json["NOMBRE_INSTITUCION"],
        correo: json["CORREO"],
        usuario: json["USUARIO"],
        password: json["PASSWORD"],
        avatar: json["AVATAR"],
        imei: json["IMEI"],
        tokenDispositivo: json["TOKEN"],
        primeraVez: json["PRIMERA_VEZ"],
        idPersonal: json["IDCOV_PERSONAL"],
      );

  Map<String, dynamic> toJson() => {
        "ID_USUARIO": idUsuario,
        "ID_INSTITUCION": idInstitucion,
        "NOMBRE_PERSONA": nombrePersona,
        "NOMBRE_INSTITUCION": nombreInstitucion,
        "CORREO": correo,
        "USUARIO": usuario,
        "PASSWORD": password,
        "AVATAR": avatar,
        "IMEI": imei,
        "TOKEN": tokenDispositivo,
        "PRIMERA_VEZ": primeraVez,
        "IDCOV_PERSONAL": idPersonal,
      };
}

// ---------------------------------------------------------

class Catalogo extends Entity {
  int idcovCatalogo;
  int idaTipocatalogo;
  String catFuente;
  String catFecha;
  int idaDifusion;
  int idaUbicacion;
  String usuario;

  Catalogo(
      {this.idcovCatalogo = 0,
      this.idaTipocatalogo,
      this.catFuente,
      this.catFecha,
      this.idaDifusion,
      this.idaUbicacion,
      this.usuario});

  fromJson(Map<String, dynamic> json) => new Catalogo(
        idcovCatalogo: json["IDCOV_CATALOGO"],
        idaTipocatalogo: json["IDA_TIPOCATALOGO"],
        catFuente: json["CAT_FUENTE"],
        catFecha: json["CAT_FECHA"],
        idaDifusion: json["IDA_DIFUSION"],
        idaUbicacion: json["IDA_UBICACION"],
        usuario: json["USUARIO"],
      );

  Map<String, dynamic> toJson() => {
        "IDCOV_CATALOGO": idcovCatalogo,
        "IDA_TIPOCATALOGO": idaTipocatalogo,
        "CAT_FUENTE": catFuente,
        "CAT_FECHA": catFecha,
        "IDA_DIFUSION": idaDifusion,
        "IDA_UBICACION": idaUbicacion,
        "USUARIO": usuario,
      };
}

class DetalleCatalogo extends Entity {
  int idcovDetallecatalogo;
  int idcovCatalogo;
  DateTime detFecha;
  DateTime detFechaInicio;
  DateTime detFechaFin;
  String detTitulo;
  String detSubtitulo;
  String detContenido;
  String detImagen;
  String detDocumento;
  int detEstado;
  String usuario;

  DetalleCatalogo(
      {this.idcovDetallecatalogo,
      this.idcovCatalogo = 0,
      this.detFecha,
      this.detFechaInicio,
      this.detFechaFin,
      this.detTitulo,
      this.detSubtitulo,
      this.detContenido,
      this.detImagen,
      this.detDocumento,
      this.detEstado,
      this.usuario});

  fromJson(Map<String, dynamic> json) => new DetalleCatalogo(
        idcovDetallecatalogo: json["IDCOV_DETALLECATALOGO"],
        idcovCatalogo: json["IDCOV_CATALOGO"],
        detFecha: json["DET_FECHA"],
        detFechaInicio: json["DET_FECHAINICIO"],
        detFechaFin: json["DET_FECHAFIN"],
        detTitulo: json["DET_TITULO"],
        detSubtitulo: json["DET_SUBTITULO"],
        detContenido: json["DET_CONTENIDO"],
        detImagen: json["DET_IMAGEN"],
        detDocumento: json["DET_DOCUMENTO"],
        detEstado: json["DET_ESTADO"],
        usuario: json["USUARIO"],
      );

  Map<String, dynamic> toJson() => {
        "IDCOV_DETALLECATALOGO": idcovDetallecatalogo,
        "IDCOV_CATALOGO": idcovCatalogo,
        "DET_FECHA": detFecha,
        "DET_FECHAINICIO": detFechaInicio,
        "DET_FECHAFIN": detFechaFin,
        "DET_TITULO": detTitulo,
        "DET_SUBTITULO": detSubtitulo,
        "DET_CONTENIDO": detContenido,
        "DET_IMAGEN": detImagen,
        "DET_DOCUMENTO": detDocumento,
        "DET_ESTADO": detEstado,
        "USUARIO": usuario
      };
}

class Hospital extends Entity {
  int id;
  String nombre;
  String ubicacion;

  Hospital({this.id = 0, this.nombre, this.ubicacion});

  fromJson(Map<String, dynamic> json) => new Hospital(
      id: json["ID"],
      nombre: json["HOS_NOMBRE"],
      ubicacion: json["HOS_UBICACION"]);

  Map<String, dynamic> toJson() =>
      {"ID": id, "HOS_NOMBRE": nombre, "HOS_UBICACION": ubicacion};
}

class Test extends Entity {
  int idcovTest;
  int idcovCiudadano;
  int idaVersion;
  String tesPregunta;

  Test(
      {this.idcovTest = 0,
      this.idcovCiudadano,
      this.idaVersion,
      this.tesPregunta});

  fromJson(Map<String, dynamic> json) => new Test(
      idcovTest: json["IDCOV_TEST"],
      idcovCiudadano: json["IDCOV_CIUDADANO"],
      idaVersion: json["IDA_VERSION"],
      tesPregunta: json["TES_PREGUNTA"]);

  Map<String, dynamic> toJson() => {
        "IDCOV_TEST": idcovTest,
        "IDCOV_CIUDADANO": idcovCiudadano,
        "IDA_VERSION": idaVersion,
        "TES_PREGUNTA": tesPregunta
      };
}

class TestHistorial extends Entity {
  int idcovTesthistorial;
  int idcovTest;
  String hisRespuesta;
  DateTime hisFecha;
  String usuario;

  TestHistorial(
      {this.idcovTesthistorial = 0,
      this.idcovTest,
      this.hisRespuesta,
      this.hisFecha,
      this.usuario});

  fromJson(Map<String, dynamic> json) => new TestHistorial(
      idcovTesthistorial: json["IDCOV_TESTHISTORIAL"],
      idcovTest: json["IDCOV_TEST"],
      hisRespuesta: json["HIS_RESPUESTA"],
      hisFecha: json["HIS_FECHA"],
      usuario: json["USUARIO"]);

  Map<String, dynamic> toJson() => {
        "IDCOV_TESTHISTORIAL": idcovTesthistorial,
        "IDCOV_TEST": idcovTest,
        "HIS_RESPUESTA": hisRespuesta,
        "HIS_FECHA": hisFecha,
        "USUARIO": usuario
      };
}

class Login extends Entity {
  int idcovLogin;
  String logUsuario;
  String logContrasenia;
  int logEstado;
  DateTime logFecharegistro;
  int logTipoingreso;
  String usuario;

  Login(
      {this.idcovLogin = 0,
      this.logUsuario,
      this.logContrasenia,
      this.logEstado,
      this.logFecharegistro,
      this.logTipoingreso,
      this.usuario});

  fromJson(Map<String, dynamic> json) => new Login(
        idcovLogin: json["IDCOV_LOGIN"],
        logUsuario: json["LOG_USUARIO"],
        logContrasenia: json["LOG_CONTRASENIA"],
        logEstado: json["LOG_ESTADO"],
        logFecharegistro: json["LOG_FECHAREGISTRO"],
        logTipoingreso: json["LOG_TIPOINGRESO"],
        usuario: json["USUARIO"],
      );

  Map<String, dynamic> toJson() => {
        "IDCOV_LOGIN": idcovLogin,
        "LOG_USUARIO": logUsuario,
        "LOG_CONTRASENIA": logContrasenia,
        "LOG_ESTADO": logEstado,
        "LOG_FECHAREGISTRO": logFecharegistro,
        "LOG_TIPOINGRESO": logTipoingreso,
        "USUARIO": usuario
      };
}

class LoginSignIn extends Entity {
  String email;
  String persona;
  String avatar;
  String id;
  String imei;

  LoginSignIn({this.id, this.email, this.persona, this.avatar, this.imei});

  fromJson(Map<String, dynamic> json) => new LoginSignIn(
        email: json["EMAIL"],
        persona: json["PERSONA"],
        avatar: json["AVATAR"],
        id: json["ID"],
        imei: json["IMEI"],
      );

  Map<String, dynamic> toJson() => {
        "EMAIL": email,
        "PERSONA": persona,
        "AVATAR": avatar,
        "ID": id,
        "IMEI": imei,
      };
}

class Clasificador extends Entity {
  String tipo;

  Clasificador({this.tipo});

  fromJson(Map<String, dynamic> json) => new Clasificador(tipo: json["TIPO"]);

  Map<String, dynamic> toJson() => {"EMAIL": tipo};
}

class ProfesionalesAgrupados extends Entity {
  int idInstitucion;
  int idProfesion;
  String profesion;
  int cantidadProfesionales;
  String imagenFondo;
  String descripcion;

  ProfesionalesAgrupados(
      {this.idInstitucion,
      this.profesion,
      this.cantidadProfesionales,
      this.idProfesion,
      this.descripcion,
      this.imagenFondo});

  fromJson(Map<String, dynamic> json) => new ProfesionalesAgrupados(
      idInstitucion: json["ID_INSTITUCION"],
      profesion: json["TIPO_PERSONAL"],
      cantidadProfesionales: json["CANTIDAD_PROFESIONALES"],
      idProfesion: json["IDA_TIPOPERSONAL"],
      descripcion: json["DESCRIPCION"],
      imagenFondo: json["URLIMAGEN"]);

  Map<String, dynamic> toJson() => {
        "ID_INSTITUCION": idInstitucion,
        "TIPO_PERSONAL": profesion,
        "CANTIDAD_PROFESIONALES": cantidadProfesionales,
        "IDA_TIPOPERSONAL": idProfesion,
        "DESCRIPCION": descripcion,
        "URLIMAGEN": imagenFondo
      };
}

class ProfesionalesDeInstitucion extends Entity {
  int idPersonal;
  int idInstitucion;
  String nombreInstitucion;
  String tipoProfesion;
  String nombreProfesional;
  String correo;
  String telefono;
  String ayudaConCovid;
  String ci;
  String sexo;
  String foto;

  ProfesionalesDeInstitucion(
      {this.idPersonal,
      this.idInstitucion,
      this.nombreInstitucion,
      this.tipoProfesion,
      this.nombreProfesional,
      this.correo,
      this.telefono,
      this.ayudaConCovid,
      this.ci,
      this.foto,
      this.sexo});

  fromJson(Map<String, dynamic> json) => new ProfesionalesDeInstitucion(
      idPersonal: json["IDCOV_PERSONAL"],
      nombreInstitucion: json["INS_NOMBREINSTITUCION"],
      tipoProfesion: json["TIPO_PERSONAL"],
      nombreProfesional: json["PER_NOMBREPERSONAL"],
      ayudaConCovid: json["PER_AYUDACOVID"],
      ci: json["PER_CI"],
      foto: json["PER_FOTO"],
      idInstitucion: json["IDCOV_INSTITUCION"],
      correo: json["PER_CORREO"],
      telefono: json["PER_TELEFONO"],
      sexo: json["sexo"]);

  Map<String, dynamic> toJson() => {
        "IDCOV_PERSONAL": idPersonal,
        "INS_NOMBREINSTITUCION": nombreInstitucion,
        "TIPO_PERSONAL": tipoProfesion,
        "PER_NOMBREPERSONAL": nombreProfesional,
        "PER_AYUDACOVID": ayudaConCovid,
        "PER_CORREO": correo,
        "PER_TELEFONO": telefono,
        "PER_FOTO": foto,
        "PER_CI": ci,
        "IDCOV_INSTITUCION": idInstitucion,
        "IDA_SEXO": sexo
      };
}

class InstitucionesItems extends Entity {
  int idInstitucion;
  String nombreInstitucion;
  String tipoInstitucion;
  String ubicacion;
  int idaAyudaCovid; /////
  String ayudaConCovid;
  String fechaConCovid;
  String url;
  int miembros;
  String urlPaginaWeb;
  String urlPaginaFacebook;
  String urlPaginaYoutube;
  String urlPaginaTwitter;
  String correo;
  String informacionComplementaria;
  String telefono;

  InstitucionesItems(
      {this.idInstitucion,
      this.nombreInstitucion,
      this.tipoInstitucion,
      this.ubicacion,
      this.idaAyudaCovid,
      this.ayudaConCovid,
      this.fechaConCovid,
      this.correo = "",
      this.informacionComplementaria,
      this.telefono,
      this.urlPaginaWeb,
      this.urlPaginaFacebook,
      this.urlPaginaYoutube,
      this.urlPaginaTwitter,
      this.url,
      this.miembros});

  fromJson(Map<String, dynamic> json) => new InstitucionesItems(
      idInstitucion: json["ID_INSTITUCION"],
      nombreInstitucion: json["NOMBRE_INSTITUCION"],
      idaAyudaCovid: json["IDA_ESTADOCOVD"],
      tipoInstitucion: json["TIPO_INSTITUCION"],
      ubicacion: json["UBICACION"],
      ayudaConCovid: json["ESTADO_COVID"],
      fechaConCovid: json["FECHA_COVID"],
      correo: json["INS_CORREOINSTITUCIONAL"],
      informacionComplementaria: json["INS_INFORMACIONCOMPLEMENTARIA"],
      telefono: json["INS_TELEFONO"],
      urlPaginaWeb: json["INS_PAGINAWEB"],
      urlPaginaFacebook: json["INS_CUENTACEBOOK"],
      urlPaginaYoutube: json["INS_CUENTAYOUTUBE"],
      urlPaginaTwitter: json["INS_CUENTATWITTER"],
      url: json["INS_FOTO"],
      miembros: json["CANTIDAD_PROFESIONALES"]);

  Map<String, dynamic> toJson() => {
        "ID_INSTITUCION": idInstitucion,
        "NOMBRE_INSTITUCION": nombreInstitucion,
        "IDA_ESTADOCOVD": idaAyudaCovid,
        "TIPO_INSTITUCION": tipoInstitucion,
        "UBICACION": ubicacion,
        "ESTADO_COVID": ayudaConCovid,
        "FECHA_COVID": fechaConCovid,
        "INS_FOTO": url,
        "INS_CORREOINSTITUCIONAL": correo,
        "INS_INFORMACIONCOMPLEMENTARIA": informacionComplementaria,
        "INS_TELEFONO": telefono,
        "INS_PAGINAWEB": urlPaginaWeb,
        "INS_CUENTACEBOOK": urlPaginaFacebook,
        "INS_CUENTAYOUTUBE": urlPaginaYoutube,
        "INS_CUENTATWITTER": urlPaginaTwitter,
        "CANTIDAD_PROFESIONALES": miembros
      };
}

class ListaMultimedia extends Entity {
  String categoria;
  int idaCategoria;
  int idcovInstitucion;
  int idcovMultimedia;
  String insNombreinstitucion;
  String mulEnlace;
  String mulFechafin;
  String mulFechainicio;
  String mulResumen;
  String mulTitulo;

  ListaMultimedia(
      {this.categoria,
      this.idaCategoria,
      this.idcovInstitucion,
      this.idcovMultimedia,
      this.insNombreinstitucion,
      this.mulEnlace,
      this.mulFechafin,
      this.mulFechainicio,
      this.mulResumen,
      this.mulTitulo});

  fromJson(Map<String, dynamic> json) => new ListaMultimedia(
      categoria: json["CATEGORIA"],
      idaCategoria: json["IDA_CATEGORIA"],
      idcovInstitucion: json["IDCOV_INSTITUCION"],
      idcovMultimedia: json["IDCOV_MULTIMEDIA"],
      insNombreinstitucion: json["INS_NOMBREINSTITUCION"],
      mulEnlace: json["MUL_ENLACE"],
      mulFechafin: json["MUL_FECHAFIN"],
      mulFechainicio: json["MUL_FECHAINICIO"],
      mulResumen: json["MUL_RESUMEN"],
      mulTitulo: json["MUL_TITULO"]);

  Map<String, dynamic> toJson() => {
        "CATEGORIA": categoria,
        "IDA_CATEGORIA": idaCategoria,
        "IDCOV_INSTITUCION": idcovInstitucion,
        "IDCOV_MULTIMEDIA": idcovMultimedia,
        "INS_NOMBREINSTITUCION": insNombreinstitucion,
        "MUL_ENLACE": mulEnlace,
        "MUL_FECHAFIN": mulFechafin,
        "MUL_FECHAINICIO": mulFechainicio,
        "MUL_RESUMEN": mulResumen,
        "MUL_TITULO": mulTitulo
      };
}

class MultimediaImagen extends Entity {
  int idInstitucion;
  String titulo;
  String subtitulo;
  String url;

  MultimediaImagen({this.idInstitucion, this.titulo, this.subtitulo, this.url});

  fromJson(Map<String, dynamic> json) => new MultimediaImagen(
      idInstitucion: json["idInstitucion"],
      titulo: json["titulo"],
      subtitulo: json["subtitulo"],
      url: json["url"]);

  Map<String, dynamic> toJson() => {
        "idInstitucion": idInstitucion,
        "titulo": titulo,
        "subtitulo": subtitulo,
        "url": url
      };
}

class MultimediaVideo extends Entity {
  int idInstitucion;
  String titulo;
  String subtitulo;
  String url;

  MultimediaVideo({this.idInstitucion, this.titulo, this.subtitulo, this.url});

  fromJson(Map<String, dynamic> json) => new MultimediaVideo(
      idInstitucion: json["idInstitucion"],
      titulo: json["titulo"],
      subtitulo: json["subtitulo"],
      url: json["url"]);

  Map<String, dynamic> toJson() => {
        "idInstitucion": idInstitucion,
        "titulo": titulo,
        "subtitulo": subtitulo,
        "url": url
      };
}

class MultimediaDocumentos extends Entity {
  int idInstitucion;
  String titulo;
  String subtitulo;
  String url;

  MultimediaDocumentos(
      {this.idInstitucion, this.titulo, this.subtitulo, this.url});

  fromJson(Map<String, dynamic> json) => new MultimediaDocumentos(
      idInstitucion: json["idInstitucion"],
      titulo: json["titulo"],
      subtitulo: json["subtitulo"],
      url: json["url"]);

  Map<String, dynamic> toJson() => {
        "idInstitucion": idInstitucion,
        "titulo": titulo,
        "subtitulo": subtitulo,
        "url": url
      };
}

class EventosItem extends Entity {
  String institucion;

  String voluntario;
  String titulo;
  String objetivo;
  String url;
  int idInstitucion;
  int idPersonal;
  String dirigidoA;
  String expositor;
  String ubicacion;
  String fecha;
  String hora;

  EventosItem(
      {this.institucion,
      this.voluntario,
      this.titulo,
      this.objetivo,
      this.url,
      this.idInstitucion,
      this.idPersonal,
      this.dirigidoA,
      this.expositor,
      this.ubicacion,
      this.fecha,
      this.hora});

  fromJson(Map<String, dynamic> json) => new EventosItem(
      institucion: json["INS_NOMBREINSTITUCION"],
      voluntario: json["EVE_EXPOSITOR"],
      titulo: json["EVE_TITULO"],
      url: json["EVE_FOTO"],
      idInstitucion: json["IDCOV_INSTITUCION"],
      idPersonal: json["IDCOV_PERSONAL"],
      dirigidoA: json["EVE_DIRIGIDOA"],
      expositor: json["EVE_EXPOSITOR"],
      ubicacion: json["EVE_UBICACION"],
      fecha: json["EVE_FECHA"],
      hora: json["EVE_HORA"],
      objetivo: json["EVE_OBJETIVO"]);

  Map<String, dynamic> toJson() => {
        "INS_NOMBREINSTITUCION": institucion,
        "EVE_EXPOSITOR": voluntario,
        "EVE_FOTO": url,
        "IDCOV_INSTITUCION": idInstitucion,
        "IDCOV_PERSONAL": idPersonal,
        "EVE_DIRIGIDOA": dirigidoA,
        "EVE_EXPOSITOR": expositor,
        "EVE_UBICACION": ubicacion,
        "EVE_FECHA": fecha,
        "EVE_HORA": hora,
        "EVE_TITULO": titulo,
        "EVE_OBJETIVO": objetivo
      };
}

class SolicitudAyuda extends Entity {
  int idaBotonPanico;

  int idaCatalogo;
  int idaPrioridad;
  int idaEstadoSolicitud;
  double latitud;
  double longitud;
  String nombreCatalogo;
  String detalle;
  String nombrePrioridad;
  String fecha;
  String nombreSolicitud;
  int telefono;

  String fechaAtencion;
  String nombrePersonalAtendio;
  String nombreInstitucionAtencion;

  SolicitudAyuda(
      {this.idaCatalogo,
      this.idaBotonPanico,
      this.idaPrioridad,
      this.idaEstadoSolicitud,
      this.latitud,
      this.longitud,
      this.nombreCatalogo,
      this.detalle,
      this.nombrePrioridad,
      this.fechaAtencion,
      this.nombrePersonalAtendio,
      this.nombreInstitucionAtencion,
      this.fecha,
      this.telefono,
      this.nombreSolicitud});

  fromJson(Map<String, dynamic> json) => new SolicitudAyuda(
      idaCatalogo: json["IDA_CATALOGO"],
      idaPrioridad: json["IDA_PRIORIDAD"],
      idaEstadoSolicitud: json["IDA_ESTADOSOLICITUD"],
      latitud: json["BOT_CORDENADALAT"],
      longitud: json["BOT_CORDENADALON"],
      idaBotonPanico: json["IDCOV_BOTONPANICO"],
      nombreCatalogo: json["NOMBRE_CATALOGO"],
      detalle: json["BOT_DETALLE"],
      fechaAtencion: json["FECHA_ATENCION"],
      nombrePersonalAtendio: json["PER_NOMBREPERSONAL"],
      nombreInstitucionAtencion: json["INS_NOMBREINSTITUCION"],
      nombrePrioridad: json["NOMBRE_PRIORIDAD"],
      telefono: json["BOT_TELEFONO"],
      fecha: json["FECHA"],
      nombreSolicitud: json["NOMBRE_SOLICITUD"]);

  Map<String, dynamic> toJson() => {
        "IDA_CATALOGO": idaCatalogo,
        "IDA_PRIORIDAD": idaPrioridad,
        "BOT_CORDENADALAT": latitud,
        "IDA_ESTADOSOLICITUD": idaEstadoSolicitud,
        "IDCOV_BOTONPANICO": idaBotonPanico,
        "BOT_CORDENADALON": longitud,
        "FECHA_ATENCION": fechaAtencion,
        "PER_NOMBREPERSONAL": nombrePersonalAtendio,
        "INS_NOMBREINSTITUCION": nombreInstitucionAtencion,
        "NOMBRE_CATALOGO": nombreCatalogo,
        "BOT_TELEFONO": telefono,
        "BOT_DETALLE": detalle,
        "NOMBRE_PRIORIDAD": nombrePrioridad,
        "FECHA": fecha,
        "NOMBRE_SOLICITUD": nombreSolicitud
      };
}

class RegistrarAyuda extends Entity {
  int idaBotonPanico;
  int idaPersonal;
  String fecha;
  int idaEstado;
  String usuario;

  RegistrarAyuda(
      {this.idaBotonPanico,
      this.idaPersonal,
      this.fecha,
      this.idaEstado,
      this.usuario});

  fromJson(Map<String, dynamic> json) => new RegistrarAyuda(
      idaBotonPanico: json["IDCOV_BOTONPANICO"],
      idaPersonal: json["IDCOV_PERSONAL"],
      fecha: json["REG_FECHA"],
      idaEstado: json["IDA_ESTADO"],
      usuario: json["USUARIO"]);

  Map<String, dynamic> toJson() => {
        "IDCOV_BOTONPANICO": idaBotonPanico,
        "IDCOV_PERSONAL": idaPersonal,
        "REG_FECHA": fecha,
        "IDA_ESTADO": idaEstado,
        "USUARIO": usuario
      };
}
