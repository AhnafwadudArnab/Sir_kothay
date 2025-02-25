import 'package:flutter/material.dart';
import 'package:sirrkothay/Dashboards/D1.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sir kothay?',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: D1Page(
        name: 'Ahnaf',
        designation: 'UIU Ambassador',
        roomNumber: '123',
        email: 'ahnaf@example.com',
        bio: 'Embasador at UIU',
        organization: 'UIts',
        phone: '987-654-3210',
      ),
      // home: MainQRcodepage(
      //   name: 'Ahnaf',
      //   email: 'ahnaf@example.com',
      //   phone: '987-654-3210',
      //   designation: 'UIU Ambassador',
      //   organization: 'UIU',
      //   roomNumber: '123',
      //   bio: 'Embasador at UIU',
      // ),
      
     //home: EditProfileScreen(),
      //home: const SignUpPage(),
      //home: EditProfileForm(name: 'Ahnaf',email: '',),
    );
  }
}
