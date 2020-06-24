import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:luciatecuida/src/Model/Entity.dart';
import 'package:mime_type/mime_type.dart';

class Generic {

  Future<List<Entity>> getAll(Entity objeto, String urlGet, String primaryKey) async 
  {
      final _url = urlGet;
      final _primaryKey = primaryKey;

      final List<Entity> list = new List();
      Map<String, dynamic> decodeData;
       //print(_url);
      // //print(_primaryKey);
      final response = await http.get(_url);

      if (response.statusCode == 200) {
          Map dataMap = json.decode(response.body);
          List<dynamic> listDynamic = dataMap[_primaryKey];
     //      //print(listDynamic);
          for (int i = 0; i < listDynamic.length; i++) {
            decodeData = listDynamic[i];
            list.add(objeto.fromJson(decodeData));
          }
      }
      else {
        Exception('Error: Status 400');
      }
      return list;
  }


Future<Map<String, dynamic>> add(Entity objeto, String urlService) async {
      String _body = json.encode(objeto.toJson());
      //print('body: $_body');
      final url = urlService;
      //print('url: $url');
      final response = await http.post(url, headers: {"Content-Type": "application/json"}, body: _body);

      return dataMap(response);
  }

  Future<Map<String, dynamic>> update(Entity objeto) async {
      String _body = json.encode(objeto.toJson());
      final url = 'getUrlUpdate()';
      final response = await http.put(url, headers: {"Content-Type": "application/json"}, body: _body);

      return dataMap(response);
  }

  Future<Map<String, dynamic>> delete(String url) async {
    //print('Eliminarrrr: $url');
       final response = await http.post(url);
      dataMap(response);
      return dataMap(response);
  }

  Map dataMap(Response response) {
      Map dataMap;

      if (response.statusCode == 200)  dataMap = json.decode(response.body);
      else   dataMap.addAll(throw Exception('Error: Status 400'));

    return dataMap;
  }

Future<Map<String, dynamic>> sebnFCM(String token, String body, String data ) async
 {
     String sJSON='{"to": "$token","notification": {"title": "Lucia Te Cuida", "body": "$body"}, "data":{"data": "$data"}}';
      String _body = sJSON;
      //print('body: $_body');
      final url = 'https://fcm.googleapis.com/fcm/send';
      //print('url: $url');
      final response = await http.post(url, headers: {"Authorization": "key=AAAAxotDu0w:APA91bGSP8HuiwfdXoSb7cN0-U6WTW4eU_-Qj_c9Hd0msRD7becPLVV5rI0Ihj12KWeKYCc7pUuBTPr-R4Uq2oHgumcrj2ADS3_-rzKwTsT_567-1QFJ1NJjLmhNAa3Qt3Z3XG1rv3ol",
                                                      "Content-Type": "application/json"}, 
                                                      body: _body);
        if (response.statusCode == 200) 
        {
//print('MI REPSNSE: $response');
        } 
       else 
       {
         //print('Error: Status 400');
       }
      //print('ENvio FCM ------: ${response.headers} ---- ${response.body} ----  ${response.statusCode} ---- ${response.request}');
      return dataMap(response);
  }


 Future<String> subirImagen( File imagen ) async {

    final url = Uri.parse('https://api.cloudinary.com/v1_1/propia/image/upload?upload_preset=luwzr1vw');
    final mimeType = mime(imagen.path).split('/'); //image/jpeg
    final imageUploadRequest = http.MultipartRequest('POST', url );
    final file = await http.MultipartFile.fromPath( 'file',imagen.path, contentType: MediaType( mimeType[0], mimeType[1]));

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if ( resp.statusCode != 200 && resp.statusCode != 201 ) {
      print('Algo salio mal IMAGENNNN ${resp.body}');
      return null;
    }

    final respData = json.decode(resp.body);
    print( respData);
    return respData['secure_url'];
  }

Future<String> subirImagenFile( String imagen ) async {

    final url = Uri.parse('https://api.cloudinary.com/v1_1/propia/image/upload?upload_preset=luwzr1vw');
    final mimeType = mime(imagen).split('/'); //image/jpeg
    final imageUploadRequest = http.MultipartRequest('POST', url );
    final file = await http.MultipartFile.fromPath( 'file',imagen, contentType: MediaType( mimeType[0], mimeType[1]));

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if ( resp.statusCode != 200 && resp.statusCode != 201 ) {
      print('Algo salio mal PDF ${resp.body}');
      return null;
    }

    final respData = json.decode(resp.body);
    print( respData);
    return respData['secure_url'];
  }

 Future<String> subirVideo( String imagen ) async {

    final url = Uri.parse('https://api.cloudinary.com/v1_1/propia/video/upload?upload_preset=luwzr1vw');
    final mimeType = mime(imagen).split('/'); //image/jpeg
    final imageUploadRequest = http.MultipartRequest('POST', url );
    final file = await http.MultipartFile.fromPath( 'file',imagen, contentType: MediaType( mimeType[0], mimeType[1]));

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if ( resp.statusCode != 200 && resp.statusCode != 201 ) {
      print('Algo salio mal videooo ${resp.body}');
      return null;
    }

    final respData = json.decode(resp.body);
    print( respData);
    return respData['secure_url'];
  }

  // Future<String> subirImagen( File imagen ) async {

  //   final url = Uri.parse('https://api.cloudinary.com/v1_1/dc0tufkzf/image/upload?upload_preset=cwye3brj');
  //   final targetPath ='';
  //   final mimeType = mime(imagen.path).split('/'); //image/jpeg

  //   var result = await FlutterImageCompress.compressAndGetFile(imagen.absolute.path, targetPath, quality: 88, rotate: 180,);

  //   //print(imagen.lengthSync());
  //   //print(result.lengthSync());

  //   final imageUploadRequest = http.MultipartRequest(
  //     'POST',
  //     url
  //   );

  //   final file = await http.MultipartFile.fromPath(
  //     'file', 
  //     imagen.path,
  //     contentType: MediaType( mimeType[0], mimeType[1] )
  //   );

  //   imageUploadRequest.files.add(file);


  //   final streamResponse = await imageUploadRequest.send();
  //   final resp = await http.Response.fromStream(streamResponse);

  //   if ( resp.statusCode != 200 && resp.statusCode != 201 ) {
  //     //print('Algo salio mal');
  //     //print( resp.body );
  //     return null;
  //   }

  //   final respData = json.decode(resp.body);
  //   //print( respData);

  //   return respData['secure_url'];
  // }  

  // Future<File> _compressAndGetFile(File file, String targetPath) async {
  //   var result = await FlutterImageCompress.compressAndGetFile(
  //       file.absolute.path, targetPath,
  //       quality: 88,
  //       rotate: 180,
  //     );

  //   //print(file.lengthSync());
  //   //print(result.lengthSync());

  //   return result;
  // }
}
