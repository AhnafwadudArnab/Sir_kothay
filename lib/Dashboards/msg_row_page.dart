
// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class msg_row_page extends StatefulWidget {
  final String message;

  const msg_row_page({super.key, required this.message});
  @override
  _msg_row_pageState createState() => _msg_row_pageState();
}

class _msg_row_pageState extends State<msg_row_page> {
  List<Map<String, dynamic>> items = [];

  @override
  void initState() {
    super.initState();
    items = [
      {"text": widget.message, "active": false},
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          var item = items[index];

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Container(
              width: double.infinity,
              height: 120, // Set the height of the card
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item["text"], style: const TextStyle(fontSize: 14)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            items[index]["active"] = !items[index]["active"];
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              item["active"] ? Colors.blue : Colors.green,
                        ),
                        child: Text(item["active"] ? "Deactivate" : "Activate"),
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
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            items.removeAt(index);
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
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
    );
  }
}
