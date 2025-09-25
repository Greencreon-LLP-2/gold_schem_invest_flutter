// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:rajakumari_scheme/core/global_widgets/custom_alert_box.dart';
import 'package:rajakumari_scheme/core/services/auth_state_service.dart';

import 'package:rajakumari_scheme/features/authentication/view/pages/register_page.dart';

import 'package:rajakumari_scheme/features/home/view/pages/main_scaffold.dart';

class OtpVerificationPage extends StatefulWidget {
  final String fullPhoneNumber;
  final String mobileCode;
  final String mobile;
  final String otp;
  final bool isTestMode;
  final bool loginStatus;
  const OtpVerificationPage({
    super.key,
    required this.fullPhoneNumber,
    required this.otp,
    required this.mobileCode,
    required this.mobile,
    this.isTestMode = false,
    this.loginStatus = false,
  });

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  final List<TextEditingController> _otpControllers = List.generate(
    4,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

  String get _enteredOtp =>
      _otpControllers.map((controller) => controller.text).join();

  final AuthStateService _authStateService = AuthStateService();

  @override
  void initState() {
    super.initState();
   
    // Auto-fill OTP for testing purposes if provided
    if (widget.isTestMode) {
      if (widget.otp.length == 4) {
        for (int i = 0; i < 4; i++) {
          _otpControllers[i].text = widget.otp[i];
        }
      }
    }
  }

  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    if (_enteredOtp != widget.otp) {
      _authStateService.logout();
    }

    // actually the login api is not proeprly configured, when sending otp getting the user data, so using a flag to know user exist , im setting the value, here destroying the value if the otp validation not happened
    super.dispose();
  }

  Future<void> _verifyOtp(BuildContext context) async {
    final enteredOtp = _enteredOtp;
    if (enteredOtp.length == 4) {
      if (enteredOtp == widget.otp) {
        if (widget.loginStatus && mounted) {
          await _authStateService.setLoggedIn();
          showGlassAlert(context, "Login Sucess!", AlertStatus.success);
          Future.delayed(const Duration(seconds: 1), () {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => MainScaffold()),
              (route) => false,
            );
          });
          // Directly navigate to home screen
          return;
        } else {
          showGlassAlert(
            context,
            'You will be taken to account creation screen, please wait',
            AlertStatus.warning,
          );

          // Navigate to register page
          Future.delayed(const Duration(seconds: 1), () {
            // Navigate to register page
            if (mounted) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => RegisterPage(
                        countryCode: widget.mobileCode,
                        mobile: widget.mobile,
                      ),
                ),
              );
            }
          });
        }
      } else {
        if (mounted) {
          showGlassAlert(
            context,
            'Invalid OTP. Please try again.',
            AlertStatus.error,
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                'Verification Code',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                "If you didn't receive the OTP, please contact us for assistance. Share this reference number for login help: ${widget.fullPhoneNumber}. Please wait up to 8 minutes and leave this screen open — there may be delays due to high traffic.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 20),

              // Test OTP Display Section (Visible only in test mode)
              Visibility(
                visible: widget.isTestMode,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.amber.shade50,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.amber.shade200),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: Colors.amber.shade800,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Server is busy',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.amber.shade800,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Use this test OTP for verification:',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.amber.shade900,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 12,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: Colors.amber.shade300),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              widget.otp,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.amber.shade900,
                                letterSpacing: 4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // OTP Input Fields
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  4,
                  (index) => _buildOtpDigitField(index),
                ),
              ),

              const SizedBox(height: 20),

              // Resend code option
              Center(
                child: TextButton(
                  onPressed: () {
                    showGlassAlert(
                      context,
                      "Please contact us for otp verification",
                      AlertStatus.warning,
                    );
                  },
                  child: Text(
                    'Resend Code',
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),

              const Spacer(),

              // Verify button
              Container(
                height: 56,
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 40),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: primaryColor.withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: () {
                    _verifyOtp(context);
                  },
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

                  child: const Text(
                    'Verify',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOtpDigitField(int index) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate adaptive width/height based on screen width
        double screenWidth = MediaQuery.of(context).size.width;
        double fieldWidth = screenWidth < 400 ? 50 : 68;
        double fieldHeight = screenWidth < 400 ? 45 : 56;

        return Container(
          width: fieldWidth,
          height: fieldHeight,
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: TextField(
            controller: _otpControllers[index],
            focusNode: _focusNodes[index],
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            maxLength: 1,
            onChanged: (value) {
              if (value.isNotEmpty && index < 3) {
                _focusNodes[index + 1].requestFocus();
              }
              if (_enteredOtp.length == 4) {
                _verifyOtp(context);
              }
            },
            decoration: const InputDecoration(
              counterText: '',
              border: InputBorder.none,
            ),
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        );
      },
    );
  }
}
