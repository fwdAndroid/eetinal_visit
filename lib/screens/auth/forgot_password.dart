import 'package:eetinal_visit/screens/auth/login_screen.dart';
import 'package:eetinal_visit/utils/colors.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController _emailController = TextEditingController();
  bool isLoading = false;

  Future<void> _sendPasswordResetEmail() async {
    setState(() {
      isLoading = true;
    });

    try {
      String email = _emailController.text.trim();

      // Send password reset email

      // Show confirmation and navigate to the login screen
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Password reset email sent! Please check your email, including the spam folder, for any response',
          ),
        ),
      );

      // Navigate to the login screen after a successful password reset email
      Navigator.push(
        context,
        MaterialPageRoute(builder: (builder) => LoginScreen()),
      ); // Replace '/login' with your actual login route
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error sending password reset email: $e')),
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: colorWhite),
        title: Text(
     
              "Forgot Password",
          style: TextStyle(color: colorWhite),
        ),
        backgroundColor: mainColor,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'assets/logo.png', // Replace with your icon asset
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                  
                        "Forgot Password",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: colorBlack,
                    ),
                  ),
                  Text(
                  
                        "Please type your email below to reset your password",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: colorBlack,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 16),
                  child: Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Text(
'Email',
                      style: TextStyle(
                        color: mainColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  padding: const EdgeInsets.all(8),
                  child: TextFormField(
                    controller: _emailController,
                    style: TextStyle(color: colorBlack),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock, color: colorBlack),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: mainColor),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: mainColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: mainColor),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: mainColor),
                      ),
                      hintText:
                     
                          "Enter Email Address",
                      hintStyle: TextStyle(
                        color: mainColor,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Flexible(child: Container(), flex: 5),

          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () async {
                  _sendPasswordResetEmail();
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // <-- Radius
                  ),
                  backgroundColor: mainColor,
                  fixedSize: const Size(320, 60),
                ),
                child: Text(
                 
                      "Send Email",
                  style: TextStyle(color: colorWhite),
                ),
              ),
            ),
          ),
          Flexible(child: Container()),
        ],
      ),
    );
  }
}