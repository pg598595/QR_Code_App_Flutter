//import 'dart:html';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
//
//class CreateQR extends StatelessWidget {
//  final TextEditingController _qRTextController = TextEditingController();
//
//  @override
//  Widget build(BuildContext context) {
//    return Padding(
//        padding: const EdgeInsets.symmetric(horizontal: 20),
//        child: Column(
//            crossAxisAlignment: CrossAxisAlignment.start,
//            children: <Widget>[
//              Padding(
//                padding: const EdgeInsets.only(
//                    top: 20.0, right: 10.0, bottom: 10.0, left: 10.0),
//                child: TextFormField(
//                  textInputAction: TextInputAction.next,
//                  style: TextStyle(color: Colors.black),
//                  controller: _qRTextController,
//                  decoration: InputDecoration(
//                    labelText: "Enter Text to create QR code",
//                    labelStyle: TextStyle(color: Colors.grey),
//                    border: OutlineInputBorder(
//                      borderRadius: BorderRadius.circular(5.0),
//                      borderSide: new BorderSide(color: Colors.black),
//                    ),
//                  ),
//                ),
//              ),
//              QrImage(
//                data: "1213",
//                version: QrVersions.auto,
//                size: 320,
//                gapless: true,
//              )
//            ]));
//  }
//}

class GenerateScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => GenerateScreenState();
}

class GenerateScreenState extends State<GenerateScreen> {

  static const double _topSectionTopPadding = 50.0;
  static const double _topSectionBottomPadding = 20.0;
  static const double _topSectionHeight = 50.0;

  GlobalKey globalKey = new GlobalKey();
  String _dataString = "Hello from this QR";
  String _inputErrorText;
  final TextEditingController _textController =  TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _contentWidget(),
    );
  }

  Future<void> _captureAndSharePng() async {
    try {

    } catch(e) {
      print(e.toString());
    }
  }

  _contentWidget() {
    final bodyHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).viewInsets.bottom;
    return  Container(
      color: const Color(0xFFFFFFFF),
      child:  Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              top: _topSectionTopPadding,
              left: 20.0,
              right: 10.0,
              bottom: _topSectionBottomPadding,
            ),
            child:  Container(
              height: _topSectionHeight,
              child:  Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    child:  TextField(
                      controller: _textController,
                      decoration:  InputDecoration(
                        hintText: "Enter a text for QR code",
                        errorText: _inputErrorText,
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: RaisedButton(
                      color: Colors.orange,
                      onPressed: () {
                        setState((){
                          _dataString = _textController.text;
                          _inputErrorText = null;
                        });
                      },
                      child: Text("Create"),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child:  Center(
              child: RepaintBoundary(
                key: globalKey,
                child: QrImage(
                  data: _dataString,
                  size: 0.5 * bodyHeight,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}