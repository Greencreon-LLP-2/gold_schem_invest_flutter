// ignore_for_file: deprecated_member_use

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:rajakumari_scheme/core/global_widgets/custom_alert_box.dart';
import 'package:rajakumari_scheme/core/services/auth_state_service.dart';
import 'package:rajakumari_scheme/features/passbook/controller/passbook_details_controller.dart';
import 'package:rajakumari_scheme/features/passbook/models/passbook_details_model.dart';
import 'package:rajakumari_scheme/features/passbook/models/passbook_model.dart';
import 'package:rajakumari_scheme/features/passbook/view/pages/payment_page.dart';
import 'package:rajakumari_scheme/features/phonepe/controller/phonepe_pg.dart';

class PassbookDetailsPage extends StatefulWidget {
  final PassbookModel passbook;

  const PassbookDetailsPage({super.key, required this.passbook});

  @override
  State<PassbookDetailsPage> createState() => _PassbookDetailsPageState();
}

class _PassbookDetailsPageState extends State<PassbookDetailsPage> {
  String? expandedPaymentId;
  final TextEditingController amountController = TextEditingController();
  @override
  void initState() {
    super.initState();
    // Fetch passbook details when the page loads
    Future.microtask(() {
      context.read<PassbookDetailsController>().fetchPassbookDetails(
        widget.passbook.id,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Passbook Details',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0.5,
        backgroundColor: Colors.amber.shade600,
        foregroundColor: Colors.white,
      ),

      body: Consumer<PassbookDetailsController>(
        builder: (context, controller, child) {
          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64, color: Colors.red[400]),
                  const SizedBox(height: 16),
                  Text(
                    'Error Loading Details',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    controller.error!,
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () {
                      controller.clearError();
                      controller.fetchPassbookDetails(widget.passbook.id);
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('Retry'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          if (controller.passbookDetails.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.book_outlined, size: 64, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(
                    'No Details Found',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'No passbook details available',
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //!======== Passbook Card
                  _buildPassbookCard(context, controller, widget.passbook),

                  const SizedBox(height: 24),

                  // Investment Total
                  _buildInvestmentTotal(controller, widget.passbook),

                  const SizedBox(height: 24),

                  // Payments Section
                  _buildPaymentsSection(controller),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPassbookCard(
    BuildContext context,
    PassbookDetailsController controller,
    PassbookModel passbook,
  ) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.amber.shade900, Colors.amber.shade200],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Decorative patterns for premium feel
          Positioned(
            top: -20,
            right: -20,
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.05),
              ),
            ),
          ),
          Positioned(
            bottom: 40,
            left: -30,
            child: Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.05),
              ),
            ),
          ),
          Positioned(
            top: 60,
            right: 30,
            child: Icon(
              Icons.diamond_outlined,
              size: 40,
              color: Colors.white.withOpacity(0.1),
            ),
          ),
          // Content
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // !Top section with ID and invest button
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    /// Wrap this with Expanded to control overflow
                    Expanded(
                      child: Row(
                        children: [
                          /// Make the text flexible
                          Expanded(
                            child: Text(
                              controller.passbookNumber,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20, // reduced font slightly
                                fontWeight: FontWeight.bold,
                              ),
                              overflow:
                                  TextOverflow.ellipsis, // prevent breaking
                            ),
                          ),
                        ],
                      ),
                    ),

                    /// Keep button as is
                    ElevatedButton.icon(
                      onPressed: () {
                        _showInvestmentDialog(context, passbook);
                      },
                      icon: const Icon(Icons.add, size: 16),
                      label: const Text('Invest More'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF3949AB),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.amber,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.star,
                            color: Colors.white,
                            size: 12,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.amber,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.star,
                            color: Colors.white,
                            size: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          "Passbook Name: ",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          widget.passbook.passbookName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Text(
                          "Passbook Address: ",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.passbook.passbookAddress,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Date section
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF303030),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 4,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Started Date',
                          style: TextStyle(color: Colors.white60, fontSize: 14),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          controller.startDate,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          'Ending Date',
                          style: TextStyle(color: Colors.white60, fontSize: 14),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          controller.endDate,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInvestmentTotal(
    PassbookDetailsController controller,
    PassbookModel passbook,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Investment Total',
                style: TextStyle(color: Colors.black54, fontSize: 14),
              ),
              const SizedBox(height: 4),
              Text(
                'Amount: ${passbook.totalAddonInvestmentAmt}',
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          // ElevatedButton(
          //   onPressed: () {},
          //   style: ElevatedButton.styleFrom(
          //     backgroundColor: const Color(0xFF4CAF50),
          //     foregroundColor: Colors.white,
          //     elevation: 0,
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(8),
          //     ),
          //   ),
          //   child: const Text(
          //     'Show Details',
          //     style: TextStyle(fontWeight: FontWeight.w500),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildPaymentsSection(PassbookDetailsController controller) {
    final payments = controller.passbookDetails;
    final regularPayments =
        payments.where((p) => p.addOnInvestment == "0").toList();
    final investments =
        payments.where((p) => p.addOnInvestment == "1").toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Regular Payments Section
        const Padding(
          padding: EdgeInsets.only(left: 4, bottom: 16),
          child: Text(
            'Regular Payments',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        if (regularPayments.isEmpty)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                Icon(
                  Icons.receipt_long_outlined,
                  size: 48,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 16),
                Text(
                  'No regular payments found',
                  style: TextStyle(color: Colors.grey[600], fontSize: 16),
                ),
              ],
            ),
          )
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: regularPayments.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final payment = regularPayments[index];
              return _buildPaymentItem(payment);
            },
          ),

        // Add-on Investments Section
        if (investments.isNotEmpty) ...[
          const SizedBox(height: 32),
          const Padding(
            padding: EdgeInsets.only(left: 4, bottom: 16),
            child: Text(
              'Additional Investments',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: investments.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final investment = investments[index];
              return _buildInvestmentItem(investment);
            },
          ),
        ],
      ],
    );
  }

  Widget _buildPaymentItem(PassbookDetailsModel payment) {
    final isPaid = payment.status == '1';
    final paymentDate = DateTime.parse(payment.paymentDate);
    final formattedDate =
        '${paymentDate.day}/${paymentDate.month}/${paymentDate.year}';

    // Get the list of regular payments
    final regularPayments =
        context
            .read<PassbookDetailsController>()
            .passbookDetails
            .where((p) => p.addOnInvestment == "0")
            .toList();

    // Find the first pending payment
    final firstPendingPayment = regularPayments.firstWhere(
      (p) => p.status == '0',
      orElse:
          () => PassbookDetailsModel(
            id: '',
            uniqId: '',
            userSubscriptionId: '',
            schemeId: '',
            passbookNo: '',
            userId: '',
            storeId: '',
            noPayment: '',
            amount: '',
            remainingPayment: '',
            paymentDate: '',
            payedOn: '',
            paymentMode: '',
            collectedBy: '',
            createdOn: '',
            updatedOn: '',
            status: '1',
            addOnInvestment: '0',
          ),
    );

    // Check if this is the first pending payment
    final isFirstPendingPayment =
        !isPaid && payment.id == firstPendingPayment.id;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          InkWell(
            onTap:
                isPaid
                    ? () {
                      setState(() {
                        expandedPaymentId =
                            expandedPaymentId == payment.id ? null : payment.id;
                      });
                    }
                    : null,
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color:
                        isPaid
                            ? Colors.green.withOpacity(0.1)
                            : Colors.grey.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isPaid ? Icons.check_circle : Icons.pending,
                    color: isPaid ? Colors.green : Colors.grey,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Payment ${payment.noPayment}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        formattedDate,
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '₹${payment.amount}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    if (isPaid)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'Paid',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.green,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Icon(
                              expandedPaymentId == payment.id
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down,
                              color: Colors.green,
                              size: 16,
                            ),
                          ],
                        ),
                      )
                    else if (isFirstPendingPayment)
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => PaymentPage(
                                    payment: payment,
                                    passbookNumber: widget.passbook.passbookNo,
                                  ),
                            ),
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
                            vertical: 12,
                          ),
                        ),

                        child: const Text(
                          'Pay Now',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    else
                      ElevatedButton(
                        onPressed: () {
                          showGlassAlert(
                            context,
                            'Please clear any due payments first.',
                            AlertStatus.warning,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Colors.grey.shade300, // disabled look
                          foregroundColor: Colors.grey.shade600,
                          elevation: 0,
                          shadowColor: Colors.transparent,
                          minimumSize: const Size(80, 36),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          textStyle: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.4,
                          ),
                        ),
                        child: const Text('Pay Now'),
                      ),
                  ],
                ),
              ],
            ),
          ),
          if (isPaid && expandedPaymentId == payment.id) ...[
            const Divider(height: 24),
            Column(
              children: [
                _buildDetailRow('Payment Mode', payment.paymentMode),
                const SizedBox(height: 8),

                const SizedBox(height: 8),
                _buildDetailRow('Paid On', payment.payedOn),
                const SizedBox(height: 8),
                _buildDetailRow(
                  'Remaining Payment',
                  '₹${payment.remainingPayment}',
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _buildInvestmentItem(PassbookDetailsModel investment) {
    final isPaid = investment.status == '1';
    final paymentDate = DateTime.parse(investment.paymentDate);
    final formattedDate =
        '${paymentDate.day}/${paymentDate.month}/${paymentDate.year}';

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color:
                  isPaid
                      ? Colors.blue.withOpacity(0.1)
                      : Colors.grey.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isPaid ? Icons.trending_up : Icons.pending,
              color: isPaid ? Colors.blue : Colors.grey,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Additional Investment',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 4),
                Text(
                  formattedDate,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '₹${investment.amount}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color:
                      isPaid
                          ? Colors.blue.withOpacity(0.1)
                          : Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  isPaid ? 'Paid' : 'Pending',
                  style: TextStyle(
                    fontSize: 12,
                    color: isPaid ? Colors.blue : Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String generateMerchantTransactionId() {
    final authStateService = context.read<AuthStateService>();
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final randomSuffix = Random().nextInt(10000).toString(); // Random number
    return 'RKTXNID_${authStateService.userId}_$timestamp$randomSuffix'; // Format: userId_timestamp_random
  }

  void _showInvestmentDialog(BuildContext context, PassbookModel passbook) {
    String selectedPaymentMethod = 'PHONEPE';
    String merchantTransactionId = generateMerchantTransactionId();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: const Text(
                'Add Investment',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Amount input
                    const Text(
                      'Enter Amount',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: amountController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey[100],
                        hintText: '₹ 0.00',
                        prefixIcon: const Icon(Icons.currency_rupee),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Payment options
                    const Text(
                      'Select Payment Method',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
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
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (amountController.text.isNotEmpty) {
                      final amount = amountController.text.trim();

                      // Show loading indicator
                      _showProcessingDialog(context);

                      final isPaymentSuccess = await Navigator.push<bool>(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => PhonepePg(
                                passbookAddress: passbook.passbookAddress,
                                passbookName: passbook.passbookName,
                                userid: widget.passbook.userId,
                                schemeId: widget.passbook.schemeId,
                                passbookId: passbook.passbookNo,
                                userSubscriptionId: passbook.id,
                                userSubscriptionPaymentId: '',
                                amount: amount,
                                gateway: selectedPaymentMethod,
                                actionType: 1,
                                merchantTransactionId: merchantTransactionId,
                              ),
                        ),
                      );

                      if (isPaymentSuccess == true) {
                        // Close investment dialog
                        Fluttertoast.showToast(
                          msg: "Investment successful",
                          backgroundColor: Colors.green,
                          gravity: ToastGravity.BOTTOM,
                          toastLength: Toast.LENGTH_LONG,
                          textColor: Colors.white,
                        );
                        // Optionally refresh passbook details
                        amountController.clear();
                        if (context.mounted) {
                          context
                              .read<PassbookDetailsController>()
                              .fetchPassbookDetails(widget.passbook.id);
                          Navigator.of(context).pop();
                        }
                      } else {
                        Fluttertoast.showToast(
                          msg: "Payment failed",
                          backgroundColor: Colors.orange,
                          gravity: ToastGravity.BOTTOM,
                          toastLength: Toast.LENGTH_LONG,
                          textColor: Colors.white,
                        );
                      }

                      // Call the invest more controller to process investment

                      Navigator.of(context).pop(); // Close processing dialog
                    } else {
                      Fluttertoast.showToast(
                        msg: "Please enter amount",
                        backgroundColor: Colors.red,
                        gravity: ToastGravity.BOTTOM,
                        toastLength: Toast.LENGTH_LONG,
                        textColor: Colors.white,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                  child: const Text(
                    'Proceed',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            );
          },
        );
      },
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

  void _showProcessingDialog(BuildContext context) {
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
  }
}

// Add this class at the end of the file
class DiagonalPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.white.withOpacity(0.03)
          ..strokeWidth = 1
          ..style = PaintingStyle.stroke;

    // Draw repeating diagonal lines
    for (double i = -size.height; i < size.width + size.height; i += 20) {
      canvas.drawLine(
        Offset(i, 0),
        Offset(i + size.height, size.height),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
