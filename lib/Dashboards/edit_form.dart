// ignore_for_file: library_private_types_in_public_api

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'D1.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (BuildContext context) {
                return Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: EditProfileForm(),
                );
              },
            );
          },
          child: Text("Edit Profile"),
        ),
      ),
    );
  }
}

class EditProfileForm extends StatefulWidget {
  const EditProfileForm({super.key});

  @override
  _EditProfileFormState createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  String? _profileImage;
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _organizationController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _designationController = TextEditingController();
  final TextEditingController _roomno = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () async {
              final ImagePicker picker = ImagePicker();
              final XFile? image = await picker.pickImage(source: ImageSource.gallery);
              if (image != null) {
                setState(() {
                _profileImage = image.path;
                });
                if (kDebugMode) {
                print('Image selected: ${image.path}');
                }
              }
              },
              child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey[300],
              backgroundImage: _profileImage != null ? FileImage(File(_profileImage!)) : null,
              child: _profileImage == null
                ? Icon(
                  Icons.camera_alt,
                  size: 50,
                  color: Colors.white,
                  )
                : null,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: "Username",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 10),
            TextField(
              controller: _bioController,
              decoration: InputDecoration(
                labelText: "Bio",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _designationController,
              decoration: InputDecoration(
                labelText: "Designation",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _organizationController,
              decoration: InputDecoration(
                labelText: "Organization",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _roomno,
              decoration: InputDecoration(
                labelText: "Room No:",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 10),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: "Phone",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => D1Page(
                          name: _usernameController.text,
                          email: _emailController.text,
                          bio: _bioController.text,
                          organization: _organizationController.text,
                          phone: _phoneController.text,
                          designation: _designationController.text,
                          roomNumber: _roomno.text,
                          image: XFile(_profileImage!),

                        ),
                      ),
                    );
                  },
                  child: Text("Save"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


class MessageDialog extends StatefulWidget {
  const MessageDialog({super.key});

  @override
  _MessageDialogState createState() => _MessageDialogState();
}

class _MessageDialogState extends State<MessageDialog> {
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Message'),
      content: TextField(
        controller: _messageController,
        maxLines: 3,
        decoration: InputDecoration(
          hintText: "Type your message here...",
          border: OutlineInputBorder(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: TextButton.styleFrom(
            backgroundColor: Colors.grey[600],
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 20),
          ),
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (_messageController.text.isNotEmpty) {
              if (kDebugMode) {
                print('Message: ${_messageController.text}');
              }
              Navigator.of(context).pop();
            }
          },
          style: TextButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 20),
          ),
          child: Text('Add'),
        ),
      ],
    );
  }
}
