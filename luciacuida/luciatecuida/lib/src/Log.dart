import 'dart:async';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:luciatecuida/src/module/UtilModule/PdfViewer.dart';

class SignInDemo1 extends StatefulWidget {
  @override
  State createState() => SignIn1DemoState();
}

class SignIn1DemoState extends State<SignInDemo1> {
   String _pdfPath = '';
  String _previewPath;
  bool _isLoading = false;
  int _pageNumber = 1;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    if (!mounted) return;

    setState(() {});
  }

  void _pickPDF() async {
    try {
      var _extension = 'PDF';
            _pdfPath = await FilePicker.getFilePath(type: FileType.custom, allowedExtensions: (_extension?.isNotEmpty ?? false)
                ? _extension?.replaceAll(' ', '')?.split(',')
                : null);


      setState(() {});
      if (_pdfPath == '') {
        return;
      }
      //print("File path: " + _pdfPath);
      setState(() {
        _isLoading = true;
      });
    } on PlatformException catch (e) {
      //print("Error while picking the file: " + e.toString());
    }

    _previewPath = await PdfPreviewer.getPagePreview(filePath: _pdfPath, pageNumber: _pageNumber);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('PDF Previewer example app'),
        ),
        body: new SingleChildScrollView(
          child: new Padding(
            padding: const EdgeInsets.all(30.0),
            child: Center(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new TemplatePageWidget(
                    height: 370.0,
                    isLoading: _isLoading,
                    width: 280.0,
                    previewPath: _previewPath,
                  ),
                  new SizedBox(
                    height: 50.0,
                    width: 50.0,
                    child: new TextField(
                      decoration: InputDecoration(hintText: 'Page...'),
                      textAlign: TextAlign.center,
                      onSubmitted: (value) => _pageNumber = int.parse(value),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  new RaisedButton(
                    child: Text('Pick PDF'),
                    onPressed: _pickPDF,
                  ),
                  new Text('File: ' + _pdfPath.split('/').last),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
} 
  
  
  
  
//   GoogleSignInAccount _currentUser;
//   String _contactText;

//   @override
//   void initState() {
//     super.initState();
//     _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
//       setState(() {
//         _currentUser = account;
//       });
//       if (_currentUser != null) {
//         _handleGetContact();
//       }
//     });
//     _googleSignIn.signInSilently();
//   }

//   Future<void> _handleGetContact() async {
//     setState(() {
//       _contactText = "Loading contact info...";
//     });
//     final http.Response response = await http.get(
//       'https://people.googleapis.com/v1/people/me/connections'
//       '?requestMask.includeField=person.names',
//       headers: await _currentUser.authHeaders,
//     );
//     if (response.statusCode != 200) {
//       setState(() {
//         _contactText = "People API gave a ${response.statusCode} "
//             "response. Check logs for details.";
//       });
//       //print('People API ${response.statusCode} response: ${response.body}');
//       return;
//     }
//     final Map<String, dynamic> data = json.decode(response.body);
//     final String namedContact = _pickFirstNamedContact(data);
//     setState(() {
//       if (namedContact != null) {
//         _contactText = "I see you know $namedContact!";
//       } else {
//         _contactText = "No contacts to display.";
//       }
//     });
//   }

//   String _pickFirstNamedContact(Map<String, dynamic> data) {
//     final List<dynamic> connections = data['connections'];
//     final Map<String, dynamic> contact = connections?.firstWhere(
//       (dynamic contact) => contact['names'] != null,
//       orElse: () => null,
//     );
//     if (contact != null) {
//       final Map<String, dynamic> name = contact['names'].firstWhere(
//         (dynamic name) => name['displayName'] != null,
//         orElse: () => null,
//       );
//       if (name != null) {
//         return name['displayName'];
//       }
//     }
//     return null;
//   }

//   Future<void> _handleSignIn() async {
//     try {
//       await _googleSignIn.signIn();
//     } catch (error) {
//       //print(error);
//     }
//   }

//   Future<void> _handleSignOut() => _googleSignIn.disconnect();

//   Widget _buildBody() {
//     if (_currentUser != null) {
//       return Column(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: <Widget>[
//           ListTile(
//             leading: GoogleUserCircleAvatar(
//               identity: _currentUser,
//             ),
//             title: Text(_currentUser.displayName ?? ''),
//             subtitle: Text(_currentUser.email ?? ''),
//           ),
//           const Text("Signed in successfully."),
//           Text(_contactText ?? ''),
//           RaisedButton(
//             child: const Text('SIGN OUT'),
//             onPressed: _handleSignOut,
//           ),
//           RaisedButton(
//             child: const Text('REFRESH'),
//             onPressed: _handleGetContact,
//           ),
//         ],
//       );
//     } else {
//       return Column(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: <Widget>[
//           const Text("You are not currently signed in."),
//           RaisedButton(
//             child: const Text('SIGN IN'),
//             onPressed: _handleSignIn,
//           ),
//         ],
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Google Sign In'),
//         ),
//         body: ConstrainedBox(
//           constraints: const BoxConstraints.expand(),
//           child: _buildBody(),
//         ));
//   }
// }