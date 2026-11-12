import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:rp_silver_house/src/Services/registernotifier.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();

  final fullNameController = TextEditingController();
  final phoneController = TextEditingController();
  final cityController = TextEditingController();
  final supabase = Supabase.instance.client;
  bool loading = false;

  @override
  void dispose() {
    fullNameController.dispose();
    phoneController.dispose();
    cityController.dispose();
    super.dispose();
  }

  Future<void> handleRegister() async {
    FocusScope.of(context).unfocus();

    if (!formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      loading = true;
    });

    try {
      await supabase.from('register').insert({
        'full_name': fullNameController.text.trim(),
        'phone': phoneController.text.trim(),
        'city': cityController.text.trim(),
      });

      await registerNotifier.completeRegistration();
      if (!mounted) return;

      context.go('/home');
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Something went wrong: $e')));
    } finally {
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2B0008),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(25, 25, 25, 40),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                // Logo
                Container(
                  width: 65,
                  height: 65,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFD4AF37),
                      width: 1,
                    ),
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/logo.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // Brand
                const Text(
                  'RP SILVER HOUSE',
                  style: TextStyle(
                    color: Color(0xFFD4AF37),
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 4,
                  ),
                ),

                const SizedBox(height: 28),

                // Title
                const Text(
                  'Create your account',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFFFF8E7),
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  'Enter your details to continue.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color(0xFFBFA5A0), fontSize: 14),
                ),

                const SizedBox(height: 35),

                // Full Name
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'FULL NAME',
                    style: TextStyle(
                      color: Color(0xFFD4AF37),
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                TextFormField(
                  controller: fullNameController,
                  textInputAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.words,
                  style: const TextStyle(
                    color: Color(0xFFFFF8E7),
                    fontSize: 15,
                  ),
                  decoration: inputDecoration('Enter your full name'),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your full name';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // Phone
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'PHONE NUMBER',
                    style: TextStyle(
                      color: Color(0xFFD4AF37),
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  maxLength: 10,
                  style: const TextStyle(
                    color: Color(0xFFFFF8E7),
                    fontSize: 15,
                  ),
                  onChanged: (value) {
                    final numbersOnly = value.replaceAll(RegExp(r'[^0-9]'), '');

                    if (numbersOnly != value) {
                      phoneController.value = TextEditingValue(
                        text: numbersOnly,
                        selection: TextSelection.collapsed(
                          offset: numbersOnly.length,
                        ),
                      );
                    }
                  },
                  decoration: inputDecoration(
                    'Enter 10 digit phone number',
                  ).copyWith(counterText: ''),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }

                    if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                      return 'Phone number must be exactly 10 digits';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // City
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'CITY',
                    style: TextStyle(
                      color: Color(0xFFD4AF37),
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                TextFormField(
                  controller: cityController,
                  textInputAction: TextInputAction.done,
                  textCapitalization: TextCapitalization.words,
                  style: const TextStyle(
                    color: Color(0xFFFFF8E7),
                    fontSize: 15,
                  ),
                  decoration: inputDecoration('Enter your city'),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your city';
                    }

                    return null;
                  },
                  onFieldSubmitted: (_) {
                    handleRegister();
                  },
                ),

                const SizedBox(height: 30),

                // Button
                SizedBox(
                  width: double.infinity,
                  height: 58,
                  child: ElevatedButton(
                    onPressed: loading ? null : handleRegister,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD4AF37),
                      disabledBackgroundColor: const Color(
                        0xFFD4AF37,
                      ).withValues(alpha: 0.6),
                      foregroundColor: const Color(0xFF2B0008),
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: loading
                        ? const Text(
                            'SAVING...',
                            style: TextStyle(
                              color: Color(0xFF2B0008),
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1.5,
                            ),
                          )
                        : const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'CREATE ACCOUNT',
                                style: TextStyle(
                                  color: Color(0xFF2B0008),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 1.5,
                                ),
                              ),
                              SizedBox(width: 12),
                              Text(
                                '→',
                                style: TextStyle(
                                  color: Color(0xFF2B0008),
                                  fontSize: 21,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),

                const SizedBox(height: 35),

                // Footer
                const Text(
                  'RP SILVER HOUSE',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    letterSpacing: 3,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Color(0xFF9B7777), fontSize: 15),
      filled: true,
      fillColor: const Color(0xFF350B12),
      contentPadding: const EdgeInsets.symmetric(horizontal: 17, vertical: 16),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFF61323A)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFFD4AF37)),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFFFF8A80)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFFFF8A80)),
      ),
      errorStyle: const TextStyle(color: Color(0xFFFF8A80), fontSize: 12),
    );
  }
}
