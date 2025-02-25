// ignore_for_file: unnecessary_string_interpolations, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'dart:ui' as ui;
class D2Page extends StatefulWidget {
  final String name;
  final String email;
  final String phone;
  final String designation;
  final String organization;
  final String bio;
  final String roomNumber;
  final String message;

  const D2Page({
    super.key,
    required this.name,
    required this.email,
    required this.phone,
    required this.designation,
    required this.organization,
    required this.roomNumber,
    required this.message, 
    required this.bio,
  });

  @override
  _D2PageState createState() => _D2PageState();
}

class _D2PageState extends State<D2Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("View Page"),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          width: 360,
          height: 450,
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
              SizedBox(height: 20),
              Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                image: DecorationImage(
                image: AssetImage('assets/user.gif'),
                fit: BoxFit.cover,
                ),
              ),
              ),
              SizedBox(height: 20),
              Text(
              'Name: ${widget.name}',
              style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              SizedBox(height: 7),
              Text(
              'Email: ${widget.email}',
              style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              SizedBox(height: 7),
              Text(
              'Phone Number: ${widget.phone}',
              style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              SizedBox(height: 7),
              Text(
              'Designation: ${widget.designation}',
              style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              SizedBox(height: 7),
              Text(
              'Organizations: ${widget.organization}',
              style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              SizedBox(height: 7),
              Text(
              'Bio: ${widget.bio}',
              style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              SizedBox(height: 7),
              Text(
              'Room Number: ${widget.roomNumber}',
              style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              SizedBox(height: 20),
              Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                Text(
                  '${widget.message}',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                ],
              ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EditProfileForm extends StatelessWidget {
  const EditProfileForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(decoration: InputDecoration(labelText: 'Name')),
          TextField(decoration: InputDecoration(labelText: 'Email')),
          // Add more fields as needed
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }
}
