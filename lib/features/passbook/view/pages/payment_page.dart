import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:rajakumari_scheme/core/services/auth_state_service.dart';

import 'package:rajakumari_scheme/features/passbook/controller/passbook_details_controller.dart';
import 'package:rajakumari_scheme/features/passbook/models/passbook_details_model.dart';

import 'package:rajakumari_scheme/features/phonepe/controller/phonepe_pg.dart';

class PaymentPage extends StatefulWidget {
  final PassbookDetailsModel payment;
  final String passbookNumber;

  const PaymentPage({
    super.key,
    required this.payment,
    required this.passbookNumber,
  });

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String selectedPaymentMethod = 'PhonePe';
  String merchantTransactionId = '';

  String generateMerchantTransactionId() {
    final authStateService = context.read<AuthStateService>();
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final randomSuffix = Random().nextInt(10000).toString(); // Random number
    return 'RKTXNID_${authStateService.userId}_$timestamp$randomSuffix'; // Format: userId_timestamp_random
  }

  @override
  void initState() {
    super.initState();
    merchantTransactionId = generateMerchantTransactionId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],

      appBar: AppBar(
        title: const Text(
          'Make Payment',
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
              // Payment Details Card
              _buildPaymentDetailsCard(),

              const SizedBox(height: 24),

              // Payment Method Selection
              _buildPaymentMethodSection(),

              const SizedBox(height: 32),

              // Proceed Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    _processPayment(
                      context,
                      widget.passbookNumber,
                      merchantTransactionId,
                    );
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
                      vertical: 16,
                    ),
                  ),
                  child: const Text(
                    'Proceed to Pay',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentDetailsCard() {
    final paymentDate = DateTime.parse(widget.payment.paymentDate);
    final formattedDate =
        '${paymentDate.day}/${paymentDate.month}/${paymentDate.year}';

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Payment Details',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 20),
          _buildDetailRow('Passbook Number', widget.passbookNumber),
          const SizedBox(height: 12),
          _buildDetailRow(
            'Payment Number',
            'Payment ${widget.payment.noPayment}',
          ),
          const SizedBox(height: 12),
          _buildDetailRow('Due Date', formattedDate),
          const SizedBox(height: 12),
          _buildDetailRow('Amount', '₹${widget.payment.amount}'),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 15, color: Colors.grey[600])),
        Text(
          value,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentMethodSection() {
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

        // PhonePe option
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

  void _processPayment(
    BuildContext context,
    String passbookId,
    String merchantTransactionId,
  ) async {
    final authStateService = context.read<AuthStateService>();

    // Launch PhonePe payment
    final paymentResult = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder:
            (context) => PhonepePg(
              passbookId: passbookId,
              passbookName: '',
              passbookAddress: '',
              schemeId: widget.payment.schemeId,
              payment: widget.payment,
              actionType: 2,
              userSubscriptionId: '',
              gateway: selectedPaymentMethod,
              amount: widget.payment.amount,
              userid: authStateService.userId,
              merchantTransactionId: merchantTransactionId,
              userSubscriptionPaymentId: widget.payment.id,
              // packageId: widget.payment.uniqId,
              // ref: 'MONTHLY_${widget.payment.id}',
            ),
      ),
    );

    if (paymentResult == true) {
      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 16),
                const CircularProgressIndicator(),
                const SizedBox(height: 24),
                const Text(
                  'Processing Payment',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 8),
                Text(
                  'Please wait while we process your payment',
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
              ],
            ),
          );
        },
      );
      context.read<PassbookDetailsController>().fetchPassbookDetails(
        passbookId,
      );
      Navigator.pop(context); // Close the loading dialog
      Navigator.pop(context); // Close the payment page
      Navigator.pop(context); // Close the passbook details page

      // Show success message
      Fluttertoast.showToast(
        msg: "Payment Successful",
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
