import 'dart:math';
import 'package:eetinal_visit/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _messageCtrl = TextEditingController();
  final _captchaCtrl = TextEditingController();

  late AnimationController _shakeController;
  late Animation<double> _shakeAnimation;
  late AnimationController _fadeController;
  late AnimationController _successController;

  // Math captcha values
  late int _a, _b, _answer;
  late String _captchaQuestion;

  bool _isSending = false;
  bool _showSuccess = false;

  @override
  void initState() {
    super.initState();

    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _shakeAnimation = Tween<double>(
      begin: 0,
      end: 10,
    ).chain(CurveTween(curve: Curves.elasticIn)).animate(_shakeController);

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _successController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _generateCaptcha();
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _messageCtrl.dispose();
    _captchaCtrl.dispose();
    _shakeController.dispose();
    _fadeController.dispose();
    _successController.dispose();
    super.dispose();
  }

  void _generateCaptcha() {
    final rnd = Random.secure();
    final opIndex = rnd.nextInt(3); // 0:+ 1:- 2:*
    _a = rnd.nextInt(16) + 5; // 5–20
    _b = rnd.nextInt(16) + 5; // 5–20

    if (opIndex == 0) {
      _answer = _a + _b;
      _captchaQuestion = '$_a + $_b = ?';
    } else if (opIndex == 1) {
      if (_b > _a) {
        final temp = _a;
        _a = _b;
        _b = temp;
      }
      _answer = _a - _b;
      _captchaQuestion = '$_a − $_b = ?';
    } else {
      _answer = _a * _b;
      _captchaQuestion = '$_a × $_b = ?';
    }

    _captchaCtrl.clear();

    // Restart fade-in effect
    _fadeController.reset();
    _fadeController.forward();

    setState(() {
      _showSuccess = false;
    });
  }

  String? _validateEmail(String? v) {
    if (v == null || v.trim().isEmpty) return 'Please enter your email';
    final email = v.trim();
    final emailRegex = RegExp(r"^[^\s@]+@[^\s@]+\.[^\s@]+$");
    if (!emailRegex.hasMatch(email)) return 'Enter a valid email';
    return null;
  }

  // Future<void> sendContactQuery({
  //   required String name,
  //   required String email,
  //   required String message,
  // }) async {
  //   final url = Uri.parse(
  //     'https://us-central1-victoria-uae-real-estate.cloudfunctions.net/contactus',
  //   );

  // //   final response = await http.post(
  //     url,
  //     headers: {'Content-Type': 'application/json'},
  //     body: jsonEncode({'name': name, 'email': email, 'message': message}),
  //   );

  //   if (response.statusCode != 200) {
  //     throw Exception('Failed to send message: ${response.body}');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: const Text('Contact Us',style: TextStyle(color: Colors.white),),backgroundColor: mainColor,),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameCtrl,
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (v) =>
                      v == null || v.trim().isEmpty ? 'Enter your name' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _emailCtrl,
                  decoration: const InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  validator: _validateEmail,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _messageCtrl,
                  decoration: const InputDecoration(labelText: 'Message'),
                  maxLines: 6,
                  validator: (v) => v == null || v.trim().isEmpty
                      ? 'Enter your message'
                      : null,
                ),
                const SizedBox(height: 18),

                // 🔐 Captcha with Shake + Fade + Success animations
                AnimatedBuilder(
                  animation: _shakeController,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(_shakeAnimation.value, 0),
                      child: child,
                    );
                  },
                  child: FadeTransition(
                    opacity: _fadeController,
                    child: Card(
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Captcha Challenge',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium,
                                ),
                                IconButton(
                                  tooltip: 'New captcha',
                                  onPressed: _generateCaptcha,
                                  icon: const Icon(
                                    Icons.refresh,
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),

                            if (_showSuccess)
                              ScaleTransition(
                                scale: CurvedAnimation(
                                  parent: _successController,
                                  curve: Curves.elasticOut,
                                ),
                                child: const Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                  size: 40,
                                ),
                              )
                            else
                              Text(
                                _captchaQuestion,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepPurple,
                                ),
                              ),

                            const SizedBox(height: 12),
                            TextFormField(
                              controller: _captchaCtrl,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'Your Answer',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _isSending
                        ? null
                        : () async {
                            if (!_formKey.currentState!.validate()) return;

                            if (_captchaCtrl.text.trim() !=
                                _answer.toString()) {
                              _shakeController.forward(from: 0);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Captcha answer is incorrect."),
                                ),
                              );
                              return;
                            }

                            setState(() => _isSending = true);

                            try {
                              // await sendContactQuery(
                              //   name: _nameCtrl.text.trim(),
                              //   email: _emailCtrl.text.trim(),
                              //   message: _messageCtrl.text.trim(),
                              // );

                              setState(() => _showSuccess = true);
                              _successController.forward(from: 0);

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "Your query was sent to the admin. Admin will contact you shortly.",
                                  ),
                                ),
                              );

                              _nameCtrl.clear();
                              _emailCtrl.clear();
                              _messageCtrl.clear();
                              _captchaCtrl.clear();
                              _generateCaptcha();
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Error sending message: $e"),
                                ),
                              );
                            } finally {
                              setState(() => _isSending = false);
                            }
                          },
                    icon: _isSending
                        ? const SizedBox.shrink()
                        : const Icon(Icons.send),
                    label: _isSending
                        ? const SizedBox(
                            height: 18,
                            width: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text('Send Message'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
