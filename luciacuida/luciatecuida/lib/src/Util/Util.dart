import 'dart:io';
import 'dart:typed_data';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:luciatecuida/src/Model/Entity.dart';
import 'package:luciatecuida/src/Model/Generic.dart';
import 'package:luciatecuida/src/Theme/ThemeModule.dart';
import 'package:luciatecuida/src/module/Citizen/CitizenEmergency/CitizenEmergencyModule.dart';
import 'package:luciatecuida/src/module/Citizen/CitizenEvents/CitizenEventsModule.dart';
import 'package:luciatecuida/src/module/Citizen/CitizenMultimedia/CitizenMultimediaModule.dart';
import 'package:luciatecuida/src/module/Citizen/Entity/InformationEntity.dart';
import 'package:luciatecuida/src/module/Citizen/Voluntary/InformationVoluntary.dart';
import 'package:luciatecuida/src/module/HomePage/HomePageModule.dart';
import 'package:luciatecuida/src/module/Settings/RoutesModule.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vector_math/vector_math_64.dart' as math;
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

final String userName = null;

String obtenerDepartamento(int idDepto)
{
   String _departamento = 'Cochabamba';
    
    if(idDepto == 54) _departamento= 'Pando'; 
     if(idDepto == 55) _departamento= 'Beni'; 
     if(idDepto == 56) _departamento= 'Santa Cruz'; 
     if(idDepto == 57) _departamento= 'La Paz'; 
     if(idDepto == 58) _departamento= 'Oruro'; 
     if(idDepto == 59) _departamento= 'Potosi'; 
     if(idDepto == 60) _departamento= 'Cochabamba'; 
     if(idDepto == 61) _departamento= 'Tarija'; 
     if(idDepto == 62) _departamento= 'Chuquisaca'; 
    return _departamento; 
}

enviarNotificaciones(String urlGetToken, String clave, String titulo,
    String valorTitulo, String subTitulo, String subTituloValor) {
  Token entityToken;
  final dataMapToken =
      new Generic().getAll(new Token(), urlGetToken, primaryKeyGetToken);

  dataMapToken.then((value) {
    if (value.length > 0) {
      for (int i = 0; i < value.length; i++) {
        entityToken = value[i];
        //    //print('entrooo las veces de: $entityToken');
        new Generic().sebnFCM(entityToken.llaveToken, clave,
            '$titulo - $valorTitulo - $subTitulo $subTituloValor - Fecha - ${DateTime.now()}');
      }
    }
  });
}

int daysInMonth(int month) {
  var now = DateTime.now();

  var lastDayDateTime = (month < 12)
      ? new DateTime(now.year, month + 1, 0)
      : new DateTime(now.year + 1, 1, 0);

  return lastDayDateTime.day;
}

Future<LatLng> getLocation() async {
  final Location location = Location();
  LocationData location1;
  LocationData locationResult;
  try {
    locationResult = await location.getLocation();
  } on PlatformException catch (e) {
    if (e.code == 'PERMISSION DENIED')
      print('Permission denied');
    else if (e.code == 'PERMISSION DENIED_NEVER_ASK')
      print('Permission denied enable ask');
  }
  location1 = locationResult;
  return LatLng(location1.latitude, location1.longitude);
}

callWhatsApp1(int number) async {
  await FlutterOpenWhatsapp.sendSingleMessage("591" + number.toString(),
      "*SomosUnoBolivia* :Un saludo cordial, le pido su colaboración. Gracias");
}

callWhatsAppText(int number, String text) async {
  await FlutterOpenWhatsapp.sendSingleMessage("591" + number.toString(), text);
}

callWhatsAppAdvanced(String message) async {
  await FlutterOpenWhatsapp.sendSingleMessage('', message);
}

sharedImage(String imagePath, String nameImage, String nameAttachExtension,
    String extensionImage, String detail) async {
  final ByteData bytes = await rootBundle.load(imagePath);
  Share.file(nameImage, nameAttachExtension, bytes.buffer.asUint8List(),
      'image/$extensionImage',
      text: detail);
}

sharedText(String title, String text, String mimeType) async {
  Share.text(title, text, mimeType);
}

openWeb(String url) async {
  String message = 'Error al abrir la página';
  if (await canLaunch(url)) {
    await launch(url);
  }
  return message;
}

callNumber(int number) async {
  String message = 'No s epudo hacer la llamada';
  var url = 'tel:${number.toString()}';
  if (await canLaunch(url)) {
    await launch(url);
  }
  return message;
}

sendEmail(String email, String subject) async {
  String message = 'No s epudo enviar el correo';
  var url = 'mailto:$email?subject= $subject&';
  if (await canLaunch(url)) {
    await launch(url);
  }
  return message;
}

sendEmailAdvanced(String email, String subject, String body) async {
  String message = 'Problemas al enviar el correo, vuelva a intentarlo.';
  var url = 'mailto:$email?subject= $subject&body=$body';
  if (await canLaunch(url)) {
    await launch(url);
  }
  return message;
}

sendSMS(int number) async {
  String message = 'Problemas al enviar el correo, vuelva a intentarlo.';
  var url = 'sms:${number.toString()}';
  if (await canLaunch(url)) {
    await launch(url);
  }
  return message;
}

loadPDF(String path) async {
  var response = await http.get(path);

  var dir = await getApplicationDocumentsDirectory();
  File file = new File("${dir.path}/data.pdf");
  file.writeAsBytesSync(response.bodyBytes, flush: true);
  return file.path;
}

Widget generaFloatbuttonHome(BuildContext context) {
  return FloatingActionButton(
    onPressed: () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePageModule(),
          ));
    },
    child: FaIcon(FontAwesomeIcons.home),
    backgroundColor: AppTheme.themeVino,
  );
}



Widget generaHTTP_TEXT(String cadena, String text) {
  if (cadena.contains("http") ||
      cadena.contains("https") ||
      cadena.contains("www")) {
    return InkWell(
      child: Text(text),
      onTap: () {
        openWeb(cadena);
      },
    );
  } else {
    return Text(cadena,
        style: kSubTitleCardStyle, overflow: TextOverflow.clip, softWrap: true);
  }
}

Widget generaHTTP_ICON(String cadena, FaIcon icon) {
  if (cadena.contains("http") ||
      cadena.contains("https") ||
      cadena.contains("www")) {
    return InkWell(
      child: icon,
      onTap: () {
        openWeb(cadena);
      },
    );
  } else {
    return AutoSizeText(cadena,
        style: kSubTitleCardStyle,
        overflow: TextOverflow.clip,
        softWrap: true,
        maxLines: 2,
        minFontSize: 15.0);
  }
}

Widget generaFloatButtonAtencion(BuildContext context) {
  return FloatingActionButton(
    onPressed: () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CitizenEmergencyModule(),
          ));
    },
    child: FaIcon(
      FontAwesomeIcons.arrowLeft,
    ),
    backgroundColor: AppTheme.themeVino,
  );
}

Widget generaFloatButtonMultimedia(BuildContext context) {
  return FloatingActionButton(
    onPressed: () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CitizenMultimediaModule(),
          ));
    },
    child: FaIcon(
      FontAwesomeIcons.arrowLeft,
    ),
    backgroundColor: AppTheme.themeVino,
  );
}


Widget generaFloatButtonEvent(BuildContext context) {
  return FloatingActionButton(
    onPressed: () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CitizenEventsModule(),
          ));
    },
    child: FaIcon(
      FontAwesomeIcons.arrowLeft,
    ),
    backgroundColor: AppTheme.themeVino,
  );
}


Widget generaFloatButtonInformationEntity(BuildContext context) {
  return FloatingActionButton(
    onPressed: () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EntityAllModule(),
          ));
    },
    child: FaIcon(
      FontAwesomeIcons.arrowLeft,
    ),
    backgroundColor: AppTheme.themeVino,
  );
}

Widget generaFloatButtonInformationVoluntary(BuildContext context) {
  return FloatingActionButton(
    onPressed: () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VoluntaryAllModule(),
          ));
    },
    child: FaIcon(
      FontAwesomeIcons.arrowLeft,
    ),
    backgroundColor: AppTheme.themeVino,
  );
}

class ImageOpaqueAssets extends StatelessWidget {
  final String imageAssetUrl;
  final Color color;
  final Size sizeImage;
  final double opacity;

  const ImageOpaqueAssets(
      this.imageAssetUrl, this.color, this.sizeImage, this.opacity);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.asset(
          imageAssetUrl,
          width: sizeImage.width,
          height: sizeImage.height,
          fit: BoxFit.fill,
        ),
        Container(
          color: color.withOpacity(opacity),
        )
      ],
    );
  }
}

class ImageOpaqueNetworkCustomize extends StatelessWidget {
  final String imageNetwordUrl;
  final Color color;
  final Size sizeImage;
  final BoxFit boxFit;
  final double opacity;

  const ImageOpaqueNetworkCustomize(this.imageNetwordUrl, this.color,
      this.sizeImage, this.opacity, this.boxFit);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Opacity(
          opacity: opacity,
          child: Image.network(
            imageNetwordUrl,
            width: sizeImage.width, //,double.maxFinite,
            height: sizeImage.height, // double.maxFinite,
            fit: boxFit,
          ),
        ),
        Container(
          height: sizeImage.height,
          width: sizeImage.width,
          color: color.withOpacity(opacity),
        )
      ],
    );
  }
}

class ImageOpaqueNetwork extends StatelessWidget {
  final String imageNetwordUrl;
  final Color color;
  final Size sizeImage;

  const ImageOpaqueNetwork(this.imageNetwordUrl, this.color, this.sizeImage);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.network(
          imageNetwordUrl,
          width: sizeImage.width, //,double.maxFinite,
          height: sizeImage.height, // double.maxFinite,
          fit: BoxFit.fill,
        ),
        Container(
          height: sizeImage.height,
          width: sizeImage.width,
          color: color.withOpacity(0.85),
        )
      ],
    );
  }
}

class ImageOvalAsset extends StatelessWidget {
  final String imageAssetUrl;
  final double sizeImage;

  const ImageOvalAsset({Key key, this.imageAssetUrl, this.sizeImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Image.asset(
        imageAssetUrl,
        width: sizeImage,
        height: sizeImage,
        fit: BoxFit.fitWidth,
      ),
    );
  }
}

class ImageOvalNetwork extends StatelessWidget {
  final String imageNetworkUrl;
  final Size sizeImage;

  const ImageOvalNetwork(
      {Key key, @required this.imageNetworkUrl, @required this.sizeImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: sizeImage.width,
        height: sizeImage.width,
        decoration: new BoxDecoration(
            shape: BoxShape.circle,
            image: new DecorationImage(
                fit: BoxFit.fill, image: new NetworkImage(imageNetworkUrl))));
  }
}

class RadialProgress extends StatefulWidget {
  final double goalCompleted;
  final Widget child;
  final Color progressColor;
  final Color progressBackgroundColor;
  final double width;

  const RadialProgress(
      {Key key,
      @required this.child,
      this.goalCompleted = 0.7,
      this.progressColor = Colors.white,
      this.progressBackgroundColor = Colors.white,
      this.width = 8})
      : super(key: key);

  @override
  _RadialProgressState createState() => _RadialProgressState();
}

class _RadialProgressState extends State<RadialProgress>
    with SingleTickerProviderStateMixin {
  AnimationController _radialProgressAnimationController;
  Animation<double> _progressAnimation;
  final Duration fadeInDuration = Duration(milliseconds: 500);
  final Duration fillDuration = Duration(seconds: 2);

  double progressDegrees = 0;
  var count = 0;

  @override
  void initState() {
    super.initState();
    _radialProgressAnimationController =
        AnimationController(vsync: this, duration: fillDuration);
    _progressAnimation = Tween(begin: 0.0, end: 360.0).animate(CurvedAnimation(
        parent: _radialProgressAnimationController, curve: Curves.easeIn))
      ..addListener(() {
        setState(() {
          progressDegrees = widget.goalCompleted * _progressAnimation.value;
        });
      });

    _radialProgressAnimationController.forward();
  }

  @override
  void dispose() {
    _radialProgressAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: widget.child,
      ),
      painter: RadialPainter(
        progressDegrees,
        widget.progressColor,
        widget.progressBackgroundColor,
        widget.width,
      ),
    );
  }
}

class RadialPainter extends CustomPainter {
  double progressInDegrees, width;
  final Color progressColor, progressBackgroundColor;

  RadialPainter(this.progressInDegrees, this.progressColor,
      this.progressBackgroundColor, this.width);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = progressBackgroundColor.withOpacity(0.5)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;

    Offset center = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(center, size.width / 2, paint);

    Paint progressPaint = Paint()
      ..color = progressColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;

    canvas.drawArc(
        Rect.fromCircle(center: center, radius: size.width / 2),
        math.radians(-90),
        math.radians(progressInDegrees),
        false,
        progressPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
