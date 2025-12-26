import 'package:eetinal_visit/screens/auth/login_screen.dart';
import 'package:eetinal_visit/utils/colors.dart';
import 'package:flutter/material.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhite,
       appBar: AppBar(
        backgroundColor: colorWhite,
        actions: [
          TextButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (builder) => LoginScreen()));
          }, child: Text("Login",style: TextStyle(color: mainColor),))
        ],
        leading: Image.asset("assets/splash.png"),
     ) );
  }
}