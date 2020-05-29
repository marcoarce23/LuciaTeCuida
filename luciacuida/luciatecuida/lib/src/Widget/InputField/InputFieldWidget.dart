import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:luciatecuida/src/Model/Entity.dart';
import 'package:luciatecuida/src/Model/Generic.dart';
import 'package:luciatecuida/src/Theme/ThemeModule.dart';
import 'package:luciatecuida/src/Util/Validator.dart' as validator;
import 'package:luciatecuida/src/module/Settings/RoutesModule.dart';

inputDecoration(String hint, String text, Icon icon, bool valida){
 InputDecoration(

  fillColor: Colors.white,
  filled : true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 2.0)
  ),

    focusedBorder : OutlineInputBorder(
        borderSide: BorderSide(color: Colors.orange, width:2.0)
    ),
);
}


class InputTextField extends StatefulWidget {
  String objectValue;
  final String text;
  final FaIcon icon;
  final String hint;
  final bool valida;

   InputTextField(this.icon, this.text, this.objectValue, this.hint, this.valida);

  @override
  _InputTextFieldState createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
  var controller;

  @override
  Widget build(BuildContext context) {
    return getWidget();
  }

  Widget getWidget() {
   return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
      child: TextFormField(
       // 
        initialValue: widget.objectValue,
        textCapitalization: TextCapitalization.sentences,
        enableSuggestions: true,
        maxLength: 50,
        autocorrect: true,
        autovalidate: false,
        cursorColor: AppTheme.themeVino,
        toolbarOptions: ToolbarOptions(copy: true, cut:true, paste: true, selectAll: true),
        keyboardType: TextInputType.text,
     //   controller: controller,
          decoration: InputDecoration(
          focusColor: Colors.blue,
           hintText: widget.hint,
           labelText: widget.text,
           icon: widget.icon,
   
   hoverColor:AppTheme.themeVino,
//errorText: 'XXXXX',
           fillColor: AppTheme.themeVino,
 
  // enabledBorder: OutlineInputBorder(
  //   borderSide: BorderSide(color: Colors.orange, width: 1.0)
  // ),

    // focusedBorder : OutlineInputBorder(
    //     borderSide: BorderSide(color: Colors.orange,)
    // ),
        ),
        onChanged: (value) {
          setState(() {
            widget.objectValue = value;
          });
        },
        validator: (value) => validator.validateTextfieldEmpty(value, widget.valida),
        onSaved: (value) => widget.objectValue = value,
      ),
    );
  }
}

class InputTextPassword extends StatefulWidget {
  String objectValue;
  final String text;
  final FaIcon icon;
  final String hint;
  final bool valida;

  InputTextPassword(this.icon, this.text, this.objectValue, this.hint, this.valida);

  @override
  _InputTextPasswordState createState() => _InputTextPasswordState();
}

class _InputTextPasswordState extends State<InputTextPassword> {
  @override
  Widget build(BuildContext context) {
    return getWidget();
  }

  Widget getWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
      child: TextFormField(
        initialValue: widget.objectValue,
        keyboardType: TextInputType.visiblePassword,
        obscureText: true,
        maxLength: 10,
        toolbarOptions: ToolbarOptions(copy: true, cut:true, paste: true, selectAll: true),
        decoration: InputDecoration(
          focusColor: Colors.blue,
          hintText: widget.hint,
          labelText: widget.text,
          icon: widget.icon,
        ),
        validator: (value) => validator.validateTextfieldLength(value, 6, widget.valida),
        onSaved: (value) => widget.objectValue = value,
      ),
    );
  }
}

class InputEmailField extends StatefulWidget {
  String objectValue;
  final String text;
  final FaIcon icon;
  final String hint;
  final String helperText;
  final bool valida;

  InputEmailField(
      this.icon, this.text, this.objectValue, this.hint, this.helperText, this.valida);

  @override
  _InputEmailFielddState createState() => _InputEmailFielddState();
}

class _InputEmailFielddState extends State<InputEmailField> {
  @override
  Widget build(BuildContext context) {
    return getWidget();
  }

  Widget getWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
      child: TextFormField(
        initialValue: widget.objectValue,
        enableInteractiveSelection: true,
        enableSuggestions: true,
        autocorrect: true,
        autovalidate: false,
        maxLength: 40,
        toolbarOptions: ToolbarOptions(copy: true, cut:true, paste: true, selectAll: true),
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          focusColor: Colors.blue,
          hintText: widget.hint,
          labelText: widget.text,
          helperText: widget.helperText,
          errorMaxLines: 6,
          icon: widget.icon,
        ),
        onChanged: (value) {
          setState(() {
            widget.objectValue = value;
          });
        },
        validator: (value) => validator.validateTextfieldEmpty(value, widget.valida),
        onSaved: (value) => widget.objectValue = value,
      ),
    );
  }
}

class InputPhoneField extends StatefulWidget {
  String objectValue;
  final String text;
  final FaIcon icon;
  final String hint;
  final bool valida;

  InputPhoneField(this.icon, this.text, this.objectValue, this.hint, this.valida);

  @override
  _InputPhoneFieldState createState() => _InputPhoneFieldState();
}

class _InputPhoneFieldState extends State<InputPhoneField> {
  @override
  Widget build(BuildContext context) {
    return getWidget();
  }

  Widget getWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
      child: TextFormField(
        initialValue: widget.objectValue,
        enableInteractiveSelection: true,
        enableSuggestions: true,
        autocorrect: true,
        autovalidate: false,
        maxLength: 10,
        toolbarOptions: ToolbarOptions(copy: true, cut:true, paste: true, selectAll: true),
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          focusColor: Colors.blue,
          hintText: widget.hint,
          labelText: widget.text,
          icon: widget.icon,
        ),
        onChanged: (value) {
          setState(() {
            widget.objectValue = value;
          });
        },
        validator: (value) => validator.validateTextfieldEmpty(value, widget.valida),
        onSaved: (value) => widget.objectValue = value,
      ),
    );
  }
}

class InputUrlField extends StatefulWidget {
  String objectValue;
  final String text;
  final FaIcon icon;
  final String hint;
  final bool valida;

  InputUrlField(this.icon, this.text, this.objectValue, this.hint, this.valida);

  @override
  _InputUrlState createState() => _InputUrlState();
}

class _InputUrlState extends State<InputUrlField> {
  @override
  Widget build(BuildContext context) {
    return getWidget();
  }

  Widget getWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
      child: TextFormField(
        initialValue: widget.objectValue,
        enableInteractiveSelection: true,
        enableSuggestions: true,
        autocorrect: true,
        autovalidate: false,
        maxLength: 140,
        toolbarOptions: ToolbarOptions(copy: true, cut:true, paste: true, selectAll: true),
        keyboardType: TextInputType.url,
        decoration: InputDecoration(
          focusColor: Colors.blue,
          hintText: widget.hint,
          labelText: widget.text,
          icon: widget.icon,
        ),
        onChanged: (value) {
          setState(() {
            widget.objectValue = value;
          });
        },
        validator: (value) => validator.validateTextfieldEmpty(value, widget.valida),
        onSaved: (value) => widget.objectValue = value,
      ),
    );
  }
}

class InputNumberField extends StatefulWidget {
  String objectValue;
  final String text;
  final FaIcon icon;
  final String hint;
  final bool valida;

  InputNumberField(this.icon, this.text, this.objectValue, this.hint, this.valida);

  @override
  _InputNumberFieldState createState() => _InputNumberFieldState();
}

class _InputNumberFieldState extends State<InputNumberField> {
  @override
  Widget build(BuildContext context) {
    return getWidget();
  }

  Widget getWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
      child: TextFormField(
        initialValue: widget.objectValue,
        enableInteractiveSelection: true,
       // enableSuggestions: true,
       // autocorrect: true,
     //   autovalidate: false,
        maxLength: 6,
        toolbarOptions: ToolbarOptions(copy: true, cut:true, paste: true, selectAll: true),
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          focusColor: Colors.blue,
          hintText: widget.hint,
          labelText: widget.text,
          icon: widget.icon,
        ),
        onChanged: (value) {
          setState(() {
            widget.objectValue = value;
          });
        },
        validator: (value) => validator.validateTextfieldEmpty(value, widget.valida),
        onSaved: (value) => widget.objectValue = value,
      ),
    );
  }
}

class InputMultilineField extends StatefulWidget {
  String objectValue;
  final String text;
  final FaIcon icon;
  final String hint;
  final bool valida;

  InputMultilineField(this.icon, this.text, this.objectValue, this.hint, this.valida);

  @override
  _InputMultilineFieldState createState() => _InputMultilineFieldState();
}

class _InputMultilineFieldState extends State<InputMultilineField> {
  @override
  Widget build(BuildContext context) {
    return getWidget();
  }

  Widget getWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
      child: TextFormField(
        initialValue: widget.objectValue,
        enableInteractiveSelection: true,
        enableSuggestions: true,
        keyboardType: TextInputType.multiline,
        maxLines: 5,
        minLines: 3,
        autocorrect: true,
        autovalidate: false,
        maxLength: 140,
        toolbarOptions: ToolbarOptions(copy: true, cut:true, paste: true, selectAll: true),
       
        decoration: InputDecoration(
          focusColor: Colors.orange,
          hintText: widget.hint,
          labelText: widget.text,
          icon: widget.icon,
     //     contentPadding: new EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
//
        ),
        onChanged: (value) {
          setState(() {
            widget.objectValue = value;
          });
        },
        validator: (value) => validator.validateTextfieldEmpty(value, widget.valida),
        onSaved: (value) => widget.objectValue = value,
      ),
    );
  }
}

class InputSexo extends StatefulWidget {
  InputSexo();

  @override
  _InputSexoState createState() => _InputSexoState();
}

class _InputSexoState extends State<InputSexo> {
  int _selectedRadio = 0;
  @override
  Widget build(BuildContext context) {
    return getWidget();
  }

  Widget getWidget() {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text('Masculino'),
          leading: Radio(
            value: 0,
            activeColor: AppTheme.themeVino,
            groupValue: _selectedRadio,
            onChanged: (value) {
              setSelectedRadio(value);
            },
          ),
        ),
        ListTile(
          title: Text('Femenino'),
          leading: Radio(
            value: _selectedRadio,
            activeColor: Colors.orangeAccent,
            groupValue: _selectedRadio,
            onChanged: (value) {
              setSelectedRadio(value);
            },
          ),
        ),
      ],
    );
  }

  setSelectedRadio(int value) {
    setState(() {
      _selectedRadio = value;
    });
  }
}

class InputCheckBox extends StatefulWidget {
  bool objectValue;
  final String text;

  InputCheckBox(this.text, this.objectValue);

  @override
  _InputCheckBoxState createState() => _InputCheckBoxState();
}

class _InputCheckBoxState extends State<InputCheckBox> {
  @override
  Widget build(BuildContext context) {
    return getWidget();
  }

  Widget getWidget() {
    return CheckboxListTile(
        title: new Text(widget.text),
        value: widget.objectValue,
        onChanged: (value) {
          setState(() {
            widget.objectValue = value;
          });
        });
  }
}

class InputDropDown extends StatefulWidget {
  String objectValue;
  final String text;
  final FaIcon icon;
  String values;

  InputDropDown(this.icon, this.text, this.objectValue, this.values);

  @override
  _InputDropDownState createState() => _InputDropDownState();
}

class _InputDropDownState extends State<InputDropDown> {
  final generic = new Generic();
  String valor;

@override
  void initState() {
     valor= widget.objectValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return getWidget();
  }

  List<DropdownMenuItem<String>> getDropDown(AsyncSnapshot snapshot) {
    List<DropdownMenuItem<String>> lista = new List();

    for (var i = 0; i < snapshot.data.length; i++) {
      GetClasificador item = snapshot.data[i];
      lista.add(DropdownMenuItem(
        child: Text(item.nombre),
        value: item.id.toString(), 
      ));
    }
    return lista;
  }

  Widget getWidget() {
    return Center(
        child: FutureBuilder(
            future: generic.getAll(new GetClasificador(), widget.values, primaryKeyGetClasifidor),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Row(
                  children: <Widget>[
                    SizedBox(width: 35.0),
                    Text(widget.text),
                    SizedBox(width: 15.0),
                    DropdownButton(
                      icon: widget.icon,
                      value: valor,
                      items: getDropDown(snapshot),
                      onChanged: (value) {
                        setState(() {
                          valor = value;
                          widget.objectValue = value; 
                          print('valor combo ingresado widget.objectValue: ${widget.objectValue} y valueeee: $value');
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
}
