import 'dart:io';

import 'package:eetinal_visit/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _usernameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  File? _imageFile;
  bool _obscurePassword = true;
  bool _acceptedPolicies = false; // ✅ Track acceptance
  bool _obscureConfirmPassword = true;
  String _selectedCountryCode = '+92'; // Default Pakistan 🇵🇰


  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) setState(() => _imageFile = File(pickedFile.path));
  }

  

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Register",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 60,
                backgroundImage: _imageFile != null
                    ? FileImage(_imageFile!)
                    : null,
                child: _imageFile == null
                    ? const Icon(Icons.camera_alt, size: 50)
                    : null,
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText:
                    "Username (Required)",
              ),
            ),
            IntlPhoneField(
              style: TextStyle(color: Colors.black),
              dropdownTextStyle: TextStyle(color: Colors.black),
              cursorColor: colorWhite,
              decoration: InputDecoration(
                labelText: "Phone Number (Optional)",
                labelStyle: TextStyle(color: Colors.black),
                filled: true,
                fillColor: Colors.white,
              ),
              initialCountryCode: 'PK',
              onChanged: (PhoneNumber number) {
                setState(() {
                  _selectedCountryCode = number.countryCode;
                  _phoneController.text = number.number;
                });
              },
              pickerDialogStyle: PickerDialogStyle(
                backgroundColor: mainColor,
                countryNameStyle: const TextStyle(color: Colors.white),
                countryCodeStyle: const TextStyle(color: Colors.white70),
                searchFieldInputDecoration: InputDecoration(
                  hintText: 'Search country',
                  hintStyle: const TextStyle(color: Colors.white54),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.white24),
                  ),
                ),
              ),
            ),

            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText:
                     "Email (Required)",
              ),
            ),

            TextField(
              controller: _passwordController,
              obscureText: _obscurePassword,
              decoration: InputDecoration(
                labelText:
                    "Password (Required)",
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () =>
                      setState(() => _obscurePassword = !_obscurePassword),
                ),
              ),
            ),

            // ✅ Confirm password field
            TextField(
              controller: _confirmPasswordController,
              obscureText: _obscureConfirmPassword,
              decoration: InputDecoration(
                labelText: "Confirm Password (Required)",
                labelStyle: TextStyle(color: Colors.black),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureConfirmPassword
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: Colors.black,
                  ),
                  onPressed: () => setState(
                    () => _obscureConfirmPassword = !_obscureConfirmPassword,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ✅ Checkbox + open dialog
            CheckboxListTile(
              value: _acceptedPolicies,
              onChanged: (_) {},

              title: Text(
                
                    "By checking this box, you agree to our Terms of Use when downloading this app.",
              ),
            ),
            const SizedBox(height: 16),

            // ✅ Register button disabled until accepted
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: mainColor,
                fixedSize: const Size(double.infinity, 60),
              ),
              onPressed: (){},
              child: Text(
                "Register",
                style: const TextStyle(color: Colors.white),
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}