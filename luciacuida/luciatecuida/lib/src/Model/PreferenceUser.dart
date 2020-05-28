import 'package:shared_preferences/shared_preferences.dart';

class PreferensUser 
{
      static final PreferensUser _instancia = new PreferensUser._internal();

      factory PreferensUser() {
        return _instancia;
      }

      PreferensUser._internal();

      SharedPreferences _prefs;

      initPrefs() async {
        this._prefs = await SharedPreferences.getInstance();
      }
      // GET y SET del Genero


    get imei {
        return _prefs.getInt('imei') ?? '-1';
      }

      set imei( String value ) {
        _prefs.setString('imei', value);
      }

      // GET y SET del _colorSecundario
      get ci {
        return _prefs.getString('ci') ?? '-1';
      }

      set ci( String value ) {
        _prefs.setString('ci', value);
      }

      // GET y SET del correo
      get correoElectronico {
        return _prefs.getString('correo') ?? '-1';
      }

      set correoElectronico( String value ) {
        _prefs.setString('correo', value);
      }

      // GET y SET del nombreUsuario
      get nombreUsuario {
        return _prefs.getString('nombreUsuario') ?? '-1';
      }

      set nombreUsuario( String value ) {
        _prefs.setString('nombreUsuario', value);
      }

 get nombreInstitucion {
        return _prefs.getString('nombreInstitucion') ?? '-1';
      }

      set nombreInstitucion( String value ) {
        _prefs.setString('nombreInstitucion', value);
      }

       get token {
      return _prefs.getString('token') ?? '-1';
    }

    set token( String value ) {
      _prefs.setString('token', value);
    }
    
         get idInsitucion {
      return _prefs.getString('idInsitucion') ?? '-1';
    }

    set idInsitucion( String value ) {
      _prefs.setString('idInsitucion', value);
    }

     get userId {
      return _prefs.getString('userId') ?? '-1';
    }

    set userId( String value ) {
      _prefs.setString('userId', value);
    }

 get idPersonal {
      return _prefs.getString('idPersonal') ?? '-1';
    }

    set idPersonal( String value ) {
      _prefs.setString('idPersonal', value);
    }

    // GET y SET de la última página
    get ultimaPagina {
      return _prefs.getString('ultimaPagina') ?? 'login';
    }

    set ultimaPagina( String value ) {
      _prefs.setString('ultimaPagina', value);
    }

    get avatarImagen {
      return _prefs.getString('avatarImagen') ?? 'https://definicionyque.es/wp-content/uploads/2017/11/Medicina_Preventiva.jpg';
    }

    set avatarImagen( String value ) {
      _prefs.setString('avatarImagen', value);
    }
}


