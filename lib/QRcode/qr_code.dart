// ignore_for_file: no_logic_in_create_state

import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:qr_flutter/qr_flutter.dart' show QrImageView, QrVersions;

class AppColor {
  static const Color primary = Color(0xFF0D47A1);
  static const Color white = Color.fromARGB(255, 255, 255, 255);
}

class MainQRcodepage extends StatefulWidget {
  final String name;
  final String email;
  final String phone;
  final String designation;
  final String organization;
  final String roomNumber;
  final String bio;

  const MainQRcodepage({
    super.key,
    required this.name,
    required this.email,
    required this.phone,
    required this.designation,
    required this.organization,
    required this.roomNumber,
    required this.bio,
  });

  @override
  State<StatefulWidget> createState() => _MainQRcodepageState();
}

class _MainQRcodepageState extends State<MainQRcodepage> {
  final GlobalKey _qrkey = GlobalKey();
  bool dirExist = false;
  dynamic externalDir = '/storage/emulated/0/Download';
  String data = 'hello';
  String urlname = 'https://sirkothay.pythonanywhere.com/';


  Future<void> _captureAndSavePng() async {
    try {
      RenderRepaintBoundary boundary =
          _qrkey.currentContext!.findRenderObject() as RenderRepaintBoundary;

      var image = await boundary.toImage(pixelRatio: 3.0);

      final whitepaint = Paint()..color = Colors.white;
      final recorder = PictureRecorder();
      final canvas = Canvas(
        recorder,
        Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
      );
      canvas.drawRect(
        Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
        whitepaint,
      );
      canvas.drawImage(image, Offset.zero, Paint());
      final picture = recorder.endRecording();
      final img = await picture.toImage(image.width, image.height);

      ByteData? byteData = await img.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();
      //for duplicate file name ?//
      String filename = 'qr_code';
      int i = 1;
      while (await File('$externalDir/$filename.png').exists()) {
        filename = 'qr_code($i)';
        i++;
      }
      //path already exist or not//
      dirExist = await Directory('$externalDir').exists();

      if (!dirExist) {
        await Directory('$externalDir').create(recursive: true);
      }

      final file = await File(
        '$externalDir/$filename.png',
      ).create(recursive: true);
      await file.writeAsBytes(pngBytes);

      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('QR Code saved to Gallery')));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to save QR Code!!')));
      }
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/sirkothayLogo.png', height: 40),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Text(
                'Name: ${widget.name}',
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
              SizedBox(height: 7),
              Text(
                'Email: ${widget.email}',
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
              SizedBox(height: 7),
              Text(
                'Phone Number: ${widget.phone}',
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
              SizedBox(height: 7),
              Text(
                'Designation: ${widget.designation}',
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
              SizedBox(height: 7),
              Text(
                'Organizations: ${widget.organization}',
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
              SizedBox(height: 7),
              Text(
                'Bio: ${widget.bio}',
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
              SizedBox(height: 7),
              Text(
                'Room Number: ${widget.roomNumber}',
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
              const SizedBox(height: 20),
              RawMaterialButton(
                onPressed: () {
                  setState(() {
                    data ='${widget.name}\n${widget.email}\n${widget.phone}\n${widget.designation}\n${widget.organization}\n${widget.roomNumber}\n${widget.bio}\n$urlname';
                  });
                },
                fillColor: AppColor.primary,
                padding: EdgeInsets.symmetric(horizontal: 36, vertical: 16),
                child: Text(
                  'Generate QR Code',
                  style: TextStyle(color: AppColor.white),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: RepaintBoundary(
                  key: _qrkey,
                  child: QrImageView(
                    data: data,
                    version: QrVersions.auto,
                    size: 190.0,
                    gapless: true,
                    errorStateBuilder: (ctx, err) {
                      return Center(
                        child: Text(
                          "Uh oh! Something went wrong...",
                          textAlign: TextAlign.center,
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              RawMaterialButton(
                onPressed: _captureAndSavePng,
                fillColor: AppColor.primary,
                shape: const StadiumBorder(),
                padding: EdgeInsets.symmetric(horizontal: 36, vertical: 16),
                child: Text(
                  'Save QR Code',
                  style: TextStyle(color: AppColor.white, fontSize: 18),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
