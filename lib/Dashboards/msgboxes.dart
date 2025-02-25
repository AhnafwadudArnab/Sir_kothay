// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class CustomContainerPage extends StatefulWidget {
  const CustomContainerPage({Key? key}) : super(key: key);

  @override
  CustomContainerPageState createState() => CustomContainerPageState();
}

class CustomContainerPageState extends State<CustomContainerPage> {
  bool isActive = false;
  List<String> messages = [];
  int tapCount = 0;

  void _addMessage() {
    setState(() {
      tapCount++;
      messages.add("New Message $tapCount");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 360,
          height: MediaQuery.of(context).size.height * 0.55,
          decoration: BoxDecoration(
            color: const Color.fromARGB(241, 109, 176, 214),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 28),
              for (int i = 0; i < messages.length; i++) _buildMessageCard(messages[i]),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addMessage,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildMessageCard(String message) {
    return Container(
      width: 290,
      height: 130,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message,
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isActive = !isActive;
                  });
                },
                child: Text(isActive ? "Deactivate" : "Activate"),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                child: const Text("Edit"),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text("Delete"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
