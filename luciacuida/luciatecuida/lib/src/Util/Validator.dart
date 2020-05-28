import 'dart:async';
import 'package:luciatecuida/src/Util/Resource.dart' as resource;


  validateTextfieldEmpty(String value, bool valida) {
    if(valida == true)
    {
      if (value.isEmpty) 
      {
        return resource.empty;
      }
      else 
        return null;
    }
  }

  validateTextfieldEmpty2(String value, String text, bool valida) {
    if(valida == true)
    {
      if (value.isEmpty) {
        return resource.empty + ' ' + '<' + text + '>';
      }
      else 
      return null;
    }
  }

  validateTextfieldLength(String value, int limit, bool valida) {
    if(valida == true)
    {
      if (value.length >= limit)
        return resource.errorLengthText + limit.toString() + ' caracteres.';
      else 
      return null;
    }
  }

  validateEmail(String value, int limit, bool valida) {
    Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    
    if(valida == true)
      {
      if (regExp.hasMatch(value)) {
        return;
      } else {
        return resource.errorEmail;
      }
    }
  }

  final validarEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);

    if (regExp.hasMatch(email)) {
      sink.add(email);
    } else {
      sink.addError('Email no es correcto');
    }
  });

  final validarPassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length >= 6) {
      sink.add(password);
    } else {
      sink.addError('Más de 6 caracteres por favor');
    }
  });

