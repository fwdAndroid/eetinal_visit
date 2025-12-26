import 'dart:io';

import 'package:eetinal_visit/screens/auth/forgot_password.dart';
import 'package:eetinal_visit/screens/auth/register_screen.dart';
import 'package:eetinal_visit/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  bool isLoadingGoogle = false;
  bool _obscureConfirmPassword = true;
  bool _isSocialLoading = false;


  // 🔹 Platform-aware social login
  Future<void> _loginWithSocial() async {
    if (Platform.isAndroid) {
   //   await _loginWithGoogle();
    } else if (Platform.isIOS) {
  //    await _loginWithApple();
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              "assets/splash.png",
              width: MediaQuery.of(context).size.width,
            ),
          
            const SizedBox(height: 12),

            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                suffixIcon: const Icon(Icons.email),
                hintText:  "Email",
                filled: true,
                fillColor: textFieldColor,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: textFieldColor),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: textFieldColor),
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              obscureText: _obscureConfirmPassword,
              controller: _passwordController,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureConfirmPassword
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureConfirmPassword = !_obscureConfirmPassword;
                    });
                  },
                ),
                hintText:
                    "Password",
                filled: true,
                fillColor: textFieldColor,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: textFieldColor),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: textFieldColor),
                ),
              ),
            ),
            // 🔹 Added Forgot Password Button
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (builder) => ForgotPassword()),
                  );
                },
                child: Text(
                  
                      "Forgot Password?",
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(360, 50),
                        backgroundColor: mainColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: (){},
                      child: Text(
                        
                            "Login with Email",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
            ),
            const SizedBox(height: 15),
            Center(
              child: _isSocialLoading
                  ? const CircularProgressIndicator()
                  : SizedBox(
                      width: 350,
                      height: 50,
                      child: SignInButton(
                        Platform.isAndroid ? Buttons.google : Buttons.apple,
                        onPressed: _loginWithSocial,
                        text: Platform.isAndroid ? 
                            
                                  "Sign In With Google"
                            : 
                                  "Sign In With Apple",
                      ),
                    ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const RegisterScreen()),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text.rich(
                    TextSpan(
                      text:
                         
                          'Don’t have an account?  ',
                      children: <InlineSpan>[
                        TextSpan(
                          text:
                              'Register',
                          style: TextStyle(
                            fontSize: 20,
                            color: mainColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}