import 'package:barcode_scan/barcode_scan.dart';
import 'package:barcode_scan/platform_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

class ScanScreen extends StatefulWidget {
  @override
  _ScanState createState() => new _ScanState();
}

class _ScanState extends State<ScanScreen> {
  String barcode = "";

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: RaisedButton(
                    color: Colors.orange,
                    textColor: Colors.black,
                    splashColor: Colors.orangeAccent,
                    onPressed: scan,
                    child: const Text('SCAN QR Code')),
              ),
              Padding(
                padding: EdgeInsets.all(40),
                child: Linkify(
                  onOpen: (link) async {
                    if (await canLaunch(link.url)) {
                      await launch(link.url);
                    } else {
                      throw 'Could not launch $link';
                    }
                  },
                  text: barcode,
                  style: TextStyle(
                      color: Colors.orangeAccent, fontWeight: FontWeight.bold),
                  linkStyle: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ));
  }

  Future scan() async {
    try {
      ScanResult barcode = await BarcodeScanner.scan();
      setState(() => {
      this.barcode = barcode.rawContent


    }

    );
      setData(barcode.rawContent);
    } on PlatformException catch (e) {
    if (e.code == BarcodeScanner.cameraAccessDenied) {
    setState(() {
    this.barcode = 'The user did not grant the camera permission!';
    });
    } else {
    setState(() => this.barcode = 'Unknown error: $e');
    }
    } on FormatException {
    setState(() => this.barcode =
    'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
    setState(() => this.barcode = 'Unknown error: $e');
    }
  }

  Future setData(link) async{
    if (await canLaunch(link)) {
    await launch(link);
    }
}
}
