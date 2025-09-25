import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:rajakumari_scheme/core/services/auth_state_service.dart';
import 'package:rajakumari_scheme/features/gold_scheme/controller/invest_in_scheme_controller.dart';
import 'package:rajakumari_scheme/features/home/view/pages/main_scaffold.dart';
import 'package:rajakumari_scheme/features/phonepe/controller/phonepe_pg.dart';

class SchemeInvestPage extends StatefulWidget {
  final String schemeId;
  final String amount;

  const SchemeInvestPage({
    super.key,
    required this.schemeId,
    required this.amount,
  });

  @override
  _SchemeInvestPageState createState() => _SchemeInvestPageState();
}

class _SchemeInvestPageState extends State<SchemeInvestPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _holderNameController = TextEditingController();
  final TextEditingController _passbookNameController = TextEditingController();
  String selectedPaymentMethod = 'PHONEPE';
  String merchantTransactionId = '';

  String generateMerchantTransactionId() {
    final authStateService = context.read<AuthStateService>();
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final randomSuffix = Random().nextInt(10000).toString(); // Random number
    return 'RKTXNID_${authStateService.userId}_$timestamp$randomSuffix'; // Format: userId_timestamp_random
  }

  @override
  void dispose() {
    _holderNameController.dispose();
    _passbookNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    merchantTransactionId = generateMerchantTransactionId();

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Invest in Scheme',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0.5,
        backgroundColor: Colors.amber.shade600,
        foregroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Investment Details Card
              _buildInvestmentDetailsCard(),

              const SizedBox(height: 24),

              // Payment Method Selection
              _buildPaymentMethodSection(merchantTransactionId),

              const SizedBox(height: 32),

              // Invest Button
              Consumer<InvestInSchemeController>(
                builder: (context, controller, child) {
                  return SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed:
                          controller.isLoading ? null : _processInvestment,
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
                          vertical: 16,
                        ),
                      ),

                      child:
                          controller.isLoading
                              ? const SizedBox(
                                height: 26,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                ),
                              )
                              : const Text(
                                'Proceed to Invest',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInvestmentDetailsCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Investment Details',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _holderNameController,
              decoration: InputDecoration(
                labelText: 'Passbook Holder Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                prefixIcon: const Icon(Icons.person),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter the passbook holder name';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _passbookNameController,
              decoration: InputDecoration(
                labelText: 'Passbook Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                prefixIcon: const Icon(Icons.book),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter the passbook name';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethodSection(String merchantTransactionId) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select Payment Method',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),
        _buildUpiPaymentOption(
          title: 'PhonePe',
          logoPath: 'assets/images/phonepe.png',
          isSelected: selectedPaymentMethod == 'PhonePe',
          onTap: () {
            setState(() {
              selectedPaymentMethod = 'PhonePe';
            });
          },
          fallbackIcon: Icons.phone_android,
          fallbackColor: const Color(0xFF5F259F),
        ),
      ],
    );
  }

  Widget _buildUpiPaymentOption({
    required String title,
    required String logoPath,
    required IconData fallbackIcon,
    required Color fallbackColor,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.grey[100] : Colors.white,
          border: Border.all(
            color: isSelected ? const Color(0xFF3949AB) : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: fallbackColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.asset(
                  logoPath,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(fallbackIcon, color: fallbackColor, size: 24);
                  },
                ),
              ),
            ),
            const SizedBox(width: 16),
            Text(
              title,
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 16,
              ),
            ),
            const Spacer(),
            if (isSelected)
              const Icon(Icons.check_circle, color: Color(0xFF3949AB)),
          ],
        ),
      ),
    );
  }

  void _processInvestment() async {
    if (_formKey.currentState?.validate() ?? false) {
      final authStateService = context.read<AuthStateService>();

      // Launch PhonePe payment
      final paymentResult = await Navigator.push<bool>(
        context,
        MaterialPageRoute(
          builder:
              (context) => PhonepePg(
                passbookId: '',
                userSubscriptionId: '',
                userSubscriptionPaymentId: '',
                actionType: 0,
                userid: authStateService.userId,
                schemeId: widget.schemeId,
                amount: widget.amount,
                merchantTransactionId: merchantTransactionId,
                gateway: selectedPaymentMethod.toUpperCase(),
                passbookName: _passbookNameController.text,
                passbookAddress: _holderNameController.text,
              ),
        ),
      );

      if (paymentResult == true) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const MainScaffold()),
          (route) => false, // This will clear all previous routes
        );
        Fluttertoast.showToast(
          msg: "Investment Successful",
          backgroundColor: Colors.green,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );
      } else {
        Fluttertoast.showToast(
          msg: "Payment failed",
          backgroundColor: Colors.orange,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );
      }
    }
  }
}
