import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sirrkothay/Dashboards/ViewEditpage.dart';

//floating button to add message//
// ignore: camel_case_types
class floating_button_page extends StatelessWidget {
  final TextEditingController _messageController = TextEditingController();
  final String name;
  final String email;
  final String bio;
  final String organization;
  final String phone;
  final String designation;
  final String roomNumber;
  final String message;

  floating_button_page({
    super.key,
    required this.name,
    required this.email,
    required this.bio,
    required this.organization,
    required this.phone,
    required this.designation,
    required this.roomNumber,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            backgroundColor: const Color.fromARGB(255, 171, 214, 221),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Add Message', style: TextStyle(fontSize: 18)),
                          SizedBox(height: 8),
                          TextField(controller: _messageController),
                          SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Cancel"),
                              ),
                              SizedBox(width: 8),
                              ElevatedButton(
                              onPressed: () {
                                String message = _messageController.text;
                                if (message.isEmpty) {
                                Get.snackbar(
                                  'Error',
                                  'Message cannot be empty',
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white,
                                );
                                } else {
                                Get.snackbar(
                                  'Message Added',
                                  message,
                                  snackPosition: SnackPosition.BOTTOM,
                                );
                                Navigator.pop(context);
                                
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                  builder: (context) => D2Page(
                                    name: name,
                                    email: email,
                                    phone: phone,
                                    designation: designation,
                                    organization: organization,
                                    roomNumber: roomNumber,
                                    message: message,
                                    bio: bio,
                                  ),
                                  ),
                                );
                                }
                              },
                              child: Text("Save"),
                              ),
                            ],
                            
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            child: Icon(Icons.add_comment),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            backgroundColor: const Color.fromARGB(255, 76, 135, 175),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => D2Page(
                        name: name,
                        email: email,
                        bio: bio,
                        organization: organization,
                        phone: phone,
                        designation: designation,
                        roomNumber: roomNumber,
                        message: '',
                      ),
                ),
              );
            },
            child: Icon(Icons.view_week),
          ),
        ],
      ),
    );
  }
}
