
import 'package:dotted_border/dotted_border.dart';
import 'package:eetinal_visit/utils/colors.dart';
import 'package:flutter/material.dart';

class AddCareRequestService extends StatefulWidget {
  const AddCareRequestService({super.key});

  @override
  State<AddCareRequestService> createState() => _AddCareRequestServiceState();
}

class _AddCareRequestServiceState extends State<AddCareRequestService> {
  final TextEditingController serviceNameCtrl = TextEditingController();
  final TextEditingController categoryCtrl = TextEditingController();
  final TextEditingController addressCtrl = TextEditingController();
  final TextEditingController descriptionCtrl = TextEditingController();

  int selectedPrice = 1;
  bool isFeatured = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryGreen,
        leading: const BackButton(color: Colors.white),
        title: const Text('Care Request', style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// Image Picker UI
            DottedBorder(
             
              child: Container(
                height: 150,
                width: double.infinity,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.image_outlined, size: 40),
                    SizedBox(height: 8),
                    Text('Choose Image'),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// Form Card
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: lightGrey,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  _textField(
                    controller: serviceNameCtrl,
                    hint: 'Service Name',
                  ),
                  const SizedBox(height: 12),

                  _textField(
                    controller: categoryCtrl,
                    hint: 'Select Category',
                  ),
                  const SizedBox(height: 12),

                  _textField(
                    controller: addressCtrl,
                    hint: 'Select Address',
                  ),
                  const SizedBox(height: 12),

                  /// Price Dropdown (1–1000)
                  DropdownButtonFormField<int>(
                    value: selectedPrice,
                    decoration: _decoration('Price'),
                    items: List.generate(
                      1000,
                      (index) => DropdownMenuItem(
                        value: index + 1,
                        child: Text('${index + 1}'),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        selectedPrice = value!;
                      });
                    },
                  ),

                  const SizedBox(height: 12),

                  /// Description
                  TextFormField(
                    controller: descriptionCtrl,
                    maxLines: 4,
                    decoration: _decoration('Description of service'),
                  ),

                  const SizedBox(height: 12),

                ],
              ),
            ),

            const SizedBox(height: 24),

            /// Save Button
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryGreen,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  /// Access values here
         
                },
                child:  Text('Save', style: TextStyle(fontSize: 16,color: colorWhite)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Reusable TextField
  Widget _textField({
    required TextEditingController controller,
    required String hint,
  }) {
    return TextFormField(
      controller: controller,
      decoration: _decoration(hint),
    );
  }

  InputDecoration _decoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: borderGrey),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: borderGrey),
      ),
    );
  }
}
