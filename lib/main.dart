import 'package:flutter/material.dart';
import 'package:qr_code/create_qr.dart';
import 'package:qr_code/scan_qr.dart';

void main() {
  runApp(TabBarScreen());
}

class TabBarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              indicatorColor: Colors.black,
              tabs: [
                Tab(icon: Icon(Icons.create),text: "Create"),
                Tab(icon: Icon(Icons.settings_overscan),text: "Scan")
              ],
            ),
            title: Text('QR Code App'),
          ),
          body: TabBarView(
            children: [
              GenerateScreen(),
              ScanScreen()
            ],
          ),
        ),
      ),
    );
  }
}


