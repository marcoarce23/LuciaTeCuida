import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;


import 'dart:async';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';


class PdfViewerPage extends StatefulWidget {
  @override
  _PdfViewerPageState createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  String localPath;

  @override
  void initState() {
    super.initState();

    ApiServiceProvider.loadPDF().then((value) {
      setState(() {
        localPath = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CodingBoot Flutter PDF Viewer",style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: localPath != null
          ? PDFView(
              filePath: localPath,
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}

class ApiServiceProvider {
  static final String url = "http://jornadasciberseguridad.riasc.unileon.es/archivos/ejemplo_esp.pdf";

  static Future<String> loadPDF() async {
    var response = await http.get(url);

    var dir = await getApplicationDocumentsDirectory();
    File file = new File("${dir.path}/data.pdf");
    file.writeAsBytesSync(response.bodyBytes, flush: true);
    return file.path;
  }
}










class PdfPreviewer {
  static const MethodChannel _channel = const MethodChannel('pdf_previewer');

  /// Creates a temporary PNG image for the provided [filePath]
  ///
  /// [pageNumber] defaults to `1` and must be equal or above it.
  static Future<dynamic> getPagePreview(
      {@required String filePath, int pageNumber = 1}) async {
    assert(pageNumber > 0 && filePath != null);
    return _channel.invokeMethod(
        'getPagePreview', {'filePath': filePath, 'pageNumber': pageNumber});
  }

  /// Creates a temporary PNG image for the last page of the provided PDF in [filePath]
  ///
  /// If the file has only a single page, it will return it.
  static Future<dynamic> getLastPagePreview({@required String filePath}) {
    assert(filePath != null);
    return _channel.invokeMethod('getLastPagePreview', {'filePath': filePath});
  }
}



/// Displays an empty container that will represent a document page template with a fixed [width] and [height]
/// where the user will use to pick a coordenate.
/// [widgetWidth] should be called along with the [widgetHeight] in order to make the aspect ratio fit
class TemplatePageWidget extends StatefulWidget {
  final double width;
  final double height;
  final bool isLoading;
  final String previewPath;

  TemplatePageWidget({@required this.width, @required this.height, this.isLoading, this.previewPath}) : assert(width > 0.0 && height > 0.0);
  TemplatePageState createState() => new TemplatePageState();
}

class TemplatePageState extends State<TemplatePageWidget> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Center(
        child: widget.previewPath != null
            ? new PdfPagePreview(
                imgPath: widget.previewPath,
              )
            : widget.isLoading
                ? new CircularProgressIndicator(
                    strokeWidth: 2.0,
                    value: null,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                  )
                : new Text('Load a PDF file to see a preview'),
      ),
      height: widget.height,
      width: widget.width,
      decoration: new BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(spreadRadius: 1.0, color: Color(0xffebebeb), blurRadius: 3.0),
        ],
        border: Border.all(
          width: 1.0,
          color: Color(0xffebebeb),
        ),
        shape: BoxShape.rectangle,
      ),
    );
  }
}


class PdfPagePreview extends StatefulWidget {
  final String imgPath;
  PdfPagePreview({@required this.imgPath});
  _PdfPagePreviewState createState() => new _PdfPagePreviewState();
}

class _PdfPagePreviewState extends State<PdfPagePreview> {
  bool imgReady = false;
  ImageProvider provider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadPreview(needsRepaint: true);
  }

  @override
  void didUpdateWidget(PdfPagePreview oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.imgPath != widget.imgPath) {
      _loadPreview(needsRepaint: true);
    }
  }

  void _loadPreview({@required bool needsRepaint}) {
    if (needsRepaint) {
      imgReady = false;
      provider = FileImage(File(widget.imgPath));
      final resolver = provider.resolve(createLocalImageConfiguration(context));
      resolver.addListener(ImageStreamListener((imgInfo, alreadyPainted) {
        imgReady = true;
        if (!alreadyPainted) setState(() {});
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: imgReady
          ? new Image(
              image: provider,
            )
          : new CircularProgressIndicator(
              strokeWidth: 2.0,
              value: null,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
            ),
    );
  }
}