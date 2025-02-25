// ignore_for_file: deprecated_member_use, use_build_context_synchronously, unnecessary_brace_in_string_interps, camel_case_types

import 'dart:io';
import 'dart:ui' as ui;
import 'package:cross_file/cross_file.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sirrkothay/Dashboards/floating_button_page.dart';

import '../Login_signup/login.dart';
import 'edit_form.dart' as edit_form show EditProfileForm;

class D1Page extends StatefulWidget {
  final String name;
  final String email;
  final String bio;
  final String organization;
  final String phone;
  final String designation;
  final String roomNumber;
  final String messages = '';
  final XFile? image;
  const D1Page({
    super.key,
    required this.name,
    required this.email,
    required this.bio,
    required this.organization,
    required this.phone,
    required this.designation,
    required this.roomNumber,
    this.image,
  });
  @override
  // ignore: library_private_types_in_public_api
  _D1PageState createState() => _D1PageState();
}

class _D1PageState extends State<D1Page> {
  final GlobalKey _qrkey = GlobalKey();
  bool isActive = true;
  bool isqrActive = true;
  bool isProfileComplete = false;
  bool isQRCodeGenerated = false;
  String messege = '';
  String data = '';
  List<Map<String, dynamic>> messages = [
    {"text": "Message 1", "active": false},
    {"text": "Message 2", "active": true},
    // Add more messages as needed
  ];
  int tapCount = 0;
  void addMessage(String newMessage) {
    setState(() {
      messages.add({"text": newMessage, "isActive": false});
    });
  }

  @override
  void initState() {
    super.initState();
    messages = [
      {"text": widget.messages, "active": false},
    ];
  }

  void deleteMessage(int index) {
    setState(() {
      messages.removeAt(index);
    });
  }

  bool dirExist = false;
  Future<void> _captureAndSavePng() async {
    try {
      RenderRepaintBoundary boundary =
          _qrkey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(
        format: ui.ImageByteFormat.png,
      );
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      // Save to the app's document directory instead of external storage
      final directory = await getApplicationDocumentsDirectory();
      final imagePath = File('${directory.path}/QRCode_preview.png');
      await imagePath.writeAsBytes(pngBytes);
      if (kDebugMode) {
        print("Image saved to: ${imagePath.path}");
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("QR Code saved to app directory!")),
      );
    } catch (e) {
      if (kDebugMode) {
        print("Error saving QR code: $e");
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Failed to save QR Code!")));
    }
  }

  Future<void> requestPermissions() async {
    var status = await Permission.storage.request();
    if (status.isGranted) {
      if (kDebugMode) {
        print("Permission granted!");
      }
    } else {
      if (kDebugMode) {
        print("Permission denied!");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ClipRRect(
          borderRadius: BorderRadius.circular(9),
          child: Image.asset('assets/sirkothayLogo.png', height: 40),
        ),
        backgroundColor: const Color.fromARGB(255, 154, 172, 184),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder:
                      (context) => LoginPage(), // Replace with your login page
                ),
              );
            },
            child: Text('Logout', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 15),
              Container(
                width: 360,
                height: 400,
                decoration: BoxDecoration(
                  color: ui.Color.fromARGB(241, 49, 65, 97),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 96,
                      height: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        image: DecorationImage(
                          image:
                              widget.image != null
                                  ? FileImage(File(widget.image!.path))
                                  : AssetImage('assets/user.gif')
                                      as ImageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (BuildContext context) {
                            return Padding(
                              padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom,
                              ),
                              child: edit_form.EditProfileForm(),
                            );
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                      ),
                      child: Text("Edit"),
                    ),
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
                  ],
                ),
              ),
              SizedBox(height: 15),
              Container(
                width: 360,
                height: 335,
                decoration: BoxDecoration(
                  color: const ui.Color.fromARGB(240, 76, 109, 128),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 15),
                    Text(
                      'Get the QR Code from here!!',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    SizedBox(height: 15),
                    if (!isProfileComplete)
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isProfileComplete = true;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
                        child: Text(
                          "Please complete your profile to generate QR code !",
                        ),
                      )
                    else if (!isQRCodeGenerated)
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isQRCodeGenerated = true;
                            isqrActive = true;
                            data =
                                '${widget.name}\n${widget.email}\n${widget.phone}\n${widget.designation}\n${widget.organization}\n${widget.bio}\n${widget.roomNumber}';
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                        ),
                        child: Text(
                          "Generate",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      )
                    else
                      Column(
                        children: [
                          QrImageView(data: data, size: 200),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              _captureAndSavePng();
                            },
                            child: Text("Download"),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              if (messages.isNotEmpty)
                Container(
                  width: 360,
                  height: MediaQuery.of(context).size.height * 0.40,
                  decoration: BoxDecoration(
                    color: const ui.Color.fromARGB(255, 117, 151, 170),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      var item = messages[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 10,
                        ),
                        child: Container(
                          width: double.infinity,
                          height: 130,
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item["text"],
                                style: const TextStyle(fontSize: 14),
                              ),
                              const SizedBox(height: 8),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        messages[index]["active"] =
                                            !messages[index]["active"];
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          item["active"]
                                              ? Colors.blue
                                              : Colors.green,
                                    ),
                                    child: Text(
                                      item["active"]
                                          ? "Deactivate"
                                          : "Activate",
                                    ),
                                  ),

                                  const SizedBox(width: 8),
                                  ElevatedButton(
                                    onPressed: () {
                                      // Edit action
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.amber,
                                    ),
                                    child: const Text("Edit"),
                                  ),
                                  const SizedBox(width: 2),
                                  ElevatedButton(
                                    onPressed: () => deleteMessage(index),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.redAccent,
                                    ),
                                    child: const Text("Delete"),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
      floatingActionButton: floating_button_page(
        name: widget.name,
        email: widget.email,
        bio: widget.bio,
        organization: widget.organization,
        phone: widget.phone,
        designation: widget.designation,
        roomNumber: widget.roomNumber,
        message: '',
      ),
    );
  }
}
