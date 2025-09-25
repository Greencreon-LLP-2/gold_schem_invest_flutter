// ignore_for_file: deprecated_member_use

import 'dart:math';
import 'package:flutter/material.dart';

import 'package:rajakumari_scheme/core/api_secrets/api_secrets.dart';
import 'package:rajakumari_scheme/core/global_widgets/custom_alert_box.dart';
import 'package:rajakumari_scheme/core/models/coredata_model.dart';
import 'package:rajakumari_scheme/core/services/auth_state_service.dart';
import 'package:rajakumari_scheme/features/authentication/controllers/login_otp_controller.dart';
import 'package:rajakumari_scheme/features/authentication/controllers/login_password_controller.dart';

import 'package:rajakumari_scheme/features/home/view/pages/main_scaffold.dart';

import '../pages/otp_verification_page.dart';

class LoginWithPhonePage extends StatefulWidget {
  final CoreData? coreData;
  const LoginWithPhonePage({super.key, this.coreData});

  @override
  State<LoginWithPhonePage> createState() => _LoginWithPhonePageState();
}

class _LoginWithPhonePageState extends State<LoginWithPhonePage> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _selectedCountryCode = '+91';
  bool _usePasswordLogin = false;
  bool _isLoading = false;
  bool _obscurePassword = true;

  // Login controllers
  late LoginOtpController _loginOtpController;
  late LoginPasswordController _loginPasswordController;

  // Auth state service
  final AuthStateService _authStateService = AuthStateService();

  final List<String> _countryCodes = [
    '+1',
    '+44',
    '+91',
    '+86',
    '+61',
    '+49',
    '+33',
    '+7',
    '+81',
    '+55',
  ];

  @override
  void initState() {
    super.initState();
    _loginOtpController = LoginOtpController();
    _loginPasswordController = LoginPasswordController();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String _generateOtp() {
    // Generate a random 6-digit OTP
    final random = Random();
    return List.generate(4, (_) => random.nextInt(10)).join();
  }

  Future<void> _handleLogin() async {
    if (_phoneController.text.isEmpty) {
      showGlassAlert(context, 'Please enter a phone number', AlertStatus.error);
      return;
    }
    if (_phoneController.text.length < 6) {
      showGlassAlert(
        context,
        'Please enter a valid phone number',
        AlertStatus.error,
      );
      return;
    }

    // Use the appropriate login method based on selection
    if (_usePasswordLogin) {
      await _loginWithPassword();
    } else {
      await _navigateToOtpScreen();
    }
  }

  Future<void> _loginWithPassword() async {
    if (_passwordController.text.isEmpty) {
      showGlassAlert(context, 'Please enter your password', AlertStatus.error);

      return;
    }

    // Show loading state
    setState(() {
      _isLoading = true;
    });

    // Get mobile code without the + prefix
    String mobileCode = _selectedCountryCode.replaceAll('+', '');

    // Login with password using controller
    final result = await _loginPasswordController.loginWithPassword(
      context: context,
      mobileCode: mobileCode,
      mobile: _phoneController.text,
      password: _passwordController.text,
    );

    // Reset loading state
    setState(() {
      _isLoading = false;
    });

    // Show error if login failed
    if (!result) {
      return;
    } else {
      if (mounted) {
        showGlassAlert(
          context,
          "Login Sucess!, Welcome ${_authStateService.userName}",
          AlertStatus.success,
        );
      }
      Future.delayed(const Duration(seconds: 1), () {
        // Navigate to main screen on successful login
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const MainScaffold()),
          );
        }
      });
    }
  }

  Future<void> _navigateToOtpScreen() async {
    final phoneNumber = '$_selectedCountryCode${_phoneController.text}';

    setState(() {
      _isLoading = true;
    });

    final otp = _generateOtp();

    String mobileCode = _selectedCountryCode.replaceAll('+', '');

    final result = await _loginOtpController.sendOtp(
      _phoneController.text,
      mobileCode,
      otp,
      context,
    );

    setState(() {
      _isLoading = false;
    });

    if (result == 'failed' && mounted) {
      showGlassAlert(
        context,
        _loginOtpController.errorMessage.isNotEmpty
            ? _loginOtpController.errorMessage
            : 'Failed to send OTP',
        AlertStatus.error,
      );
      return;
    }

    if (result == 'outdatedapp' && mounted) {
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MainScaffold()),
          );
        }
      });
      return;
    }

    final loginStatus = result == 'user_exists' ? true : false;
    if (loginStatus && mounted) {
      showGlassAlert(context, 'OTP SENT SUCESSFULLY', AlertStatus.success);
    }

    // If OTP sent successfully, go to OTP screen
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => OtpVerificationPage(
                  loginStatus: loginStatus,
                  mobile: _phoneController.text,
                  fullPhoneNumber: phoneNumber,
                  otp: otp,
                  mobileCode: mobileCode,
                  isTestMode: widget.coreData?.ifTestotp == "1",
                ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo space with subtle shadow
                const SizedBox(height: 60),
                Container(
                  height: 120,
                  alignment: Alignment.center,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 3,
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child:
                        (widget.coreData?.minLogo != null &&
                                widget.coreData!.minLogo.isNotEmpty)
                            ? Image.network(
                              '${ApiSecrets.imageBaseUrl}${widget.coreData!.minLogo}',
                              fit: BoxFit.contain,
                              height: 100,
                              width: 100,
                              loadingBuilder: (
                                context,
                                child,
                                loadingProgress,
                              ) {
                                if (loadingProgress == null) return child;
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(
                                  Icons.image_not_supported,
                                  size: 50,
                                  color: Colors.grey,
                                );
                              },
                            )
                            : const Icon(
                              Icons.sentiment_satisfied_alt,
                              size: 50,
                              color: Colors.amberAccent,
                            ),
                  ),
                ),
                const SizedBox(height: 50),

                // Title with minimal styling
                Text(
                  'Welcome back',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                    letterSpacing: -0.5,
                  ),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 8),
                Text(
                  'Login to your account',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 40),

                // Login mode toggle - more elegant
                Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Use password',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Switch.adaptive(
                        value: _usePasswordLogin,
                        activeColor: Colors.amber,
                        focusColor: Colors.amber.shade300,
                        inactiveTrackColor: Colors.amber.shade300,
                        inactiveThumbColor: Colors.amber.shade900,
                        trackOutlineColor: MaterialStateProperty.all(
                          Colors.transparent,
                        ),
                        onChanged: (value) {
                          setState(() {
                            _usePasswordLogin = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Phone number input with improved layout
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Phone Number',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey.shade50,
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Country code dropdown
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            height: 56,
                            child: Center(
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: _selectedCountryCode,
                                  icon: const Icon(
                                    Icons.keyboard_arrow_down,
                                    size: 18,
                                  ),
                                  elevation: 1,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87,
                                  ),
                                  items:
                                      _countryCodes.map((code) {
                                        return DropdownMenuItem<String>(
                                          value: code,
                                          child: Text(code),
                                        );
                                      }).toList(),
                                  onChanged: (value) {
                                    if (value != null) {
                                      setState(() {
                                        _selectedCountryCode = value;
                                      });
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),

                          // Divider
                          Container(
                            height: 32,
                            width: 1,
                            color: Colors.grey.shade300,
                          ),

                          // Phone number text field
                          Expanded(
                            child: TextFormField(
                              controller: _phoneController,
                              keyboardType: TextInputType.phone,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                              ),
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 18,
                                ),
                                hintText: 'Enter your phone number',
                                hintStyle: TextStyle(
                                  color: Colors.black38,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                if (_usePasswordLogin) ...[
                  const SizedBox(height: 20),
                  // Password field
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Password',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.grey.shade50,
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                        child: TextField(
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 18,
                            ),
                            hintText: 'Enter your password',
                            hintStyle: TextStyle(
                              color: Colors.black38,
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                            ),
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.lock_outline,
                              color: Colors.grey.shade600,
                              size: 20,
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                              child: Icon(
                                _obscurePassword
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: Colors.grey.shade600,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],

                const SizedBox(height: 40),

                // Login button
                SizedBox(
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _handleLogin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      foregroundColor:
                          Colors.black, // Ensures good contrast on amber
                      minimumSize: const Size(100, 44),
                      elevation: 4,
                      shadowColor: Colors.amber.shade200,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                    ),

                    child:
                        _isLoading
                            ? SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              ),
                            )
                            : Text(
                              _usePasswordLogin ? 'Login' : 'Send OTP',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                  ),
                ),
                const SizedBox(height: 16),
                TextButton.icon(
                  onPressed: () {
                    if (context.mounted) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MainScaffold(),
                        ),
                      );
                    }
                  },
                  icon: Icon(Icons.arrow_back),
                  label: Text('Go Back'),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black54,
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 12.0,
                    ),
                    textStyle: TextStyle(fontSize: 16),
                  ),
                ),

                // Space at the bottom
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
