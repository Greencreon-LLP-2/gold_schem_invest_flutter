import 'package:flutter/material.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:rajakumari_scheme/features/phonepe/models/local_payment.dart';
import 'package:rajakumari_scheme/features/phonepe/services/payment_cache_service.dart';

class LocalTransactionHistory extends StatefulWidget {
  const LocalTransactionHistory({super.key});

  @override
  State<LocalTransactionHistory> createState() =>
      _LocalTransactionHistoryState();
}

class _LocalTransactionHistoryState extends State<LocalTransactionHistory> {
  List<LocalPayment> _transactions = [];
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _loadTransactions();
    Hive.box('Rajakumari').listenable().addListener(_loadTransactions);
  }

  @override
  void dispose() {
    Hive.box('Rajakumari').listenable().removeListener(_loadTransactions);
    super.dispose();
  }

  Future<void> _loadTransactions() async {
    try {
      setState(() {
        _isLoading = true;
        _hasError = false;
      });

      final pending = await PaymentCacheService.getPendingPayments();
      final completed = await PaymentCacheService.getCompletedPayments();

      final allTransactions = [...pending, ...completed]
        ..sort((a, b) => b.timestamp.compareTo(a.timestamp));

      if (mounted) {
        setState(() {
          _transactions = allTransactions;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _hasError = true;
          _isLoading = false;
        });
      }
    }
  }

  String _getActionTypeText(int actionType) {
    switch (actionType) {
      case 0:
        return 'Join Scheme';
      case 1:
        return 'Invest More';
      case 2:
        return 'Monthly Payment';
      default:
        return 'Unknown';
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'failed':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final amberColor = Colors.amber.shade600;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Transaction History',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [amberColor, Colors.amber.shade400],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadTransactions,
          ),
        ],
      ),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _hasError
              ? _buildErrorUI()
              : _transactions.isEmpty
              ? _buildEmptyUI()
              : RefreshIndicator(
                onRefresh: _loadTransactions,
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _transactions.length,
                  itemBuilder: (context, index) {
                    final payment = _transactions[index];
                    return _buildTransactionCard(payment, amberColor);
                  },
                ),
              ),
    );
  }

  Widget _buildErrorUI() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.error_outline, color: Colors.red, size: 40),
          const SizedBox(height: 8),
          const Text("Failed to load transactions"),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _loadTransactions,
            child: const Text("Retry"),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyUI() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(FeatherIcons.file, color: Colors.grey.shade400, size: 40),
          const SizedBox(height: 8),
          const Text("No transactions found"),
        ],
      ),
    );
  }

  Widget _buildTransactionCard(LocalPayment payment, Color amberColor) {
    return Card(
      color: Colors.white,
      shadowColor: amberColor.withOpacity(0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center, // prevents overflow
          children: [
            // Icon bubble
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    amberColor.withOpacity(0.9),
                    amberColor.withOpacity(0.7),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                FeatherIcons.creditCard,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            // Text info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "₹${payment.amount}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _getActionTypeText(payment.actionType),
                    style: TextStyle(
                      color: Colors.grey.shade800,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "ID: ${payment.paymentId}",
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                  ),
                  Text(
                    "Scheme: ${payment.schemeId}",
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                  ),
                  Text(
                    DateFormat(
                      'dd MMM yyyy, hh:mm a',
                    ).format(payment.timestamp),
                    style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
                  ),
                ],
              ),
            ),
            // Status + delete
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor(payment.status).withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    payment.status.toUpperCase(),
                    style: TextStyle(
                      color: _getStatusColor(payment.status),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () async {
                    // Show confirmation dialog
                    final confirmDelete = await showDialog<bool>(
                      context: context,
                      builder:
                          (context) => AlertDialog(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            title: Row(
                              children: const [
                                Icon(
                                  Icons.warning_amber_rounded,
                                  color: Colors.amber,
                                  size: 28,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "Confirm Deletion",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                            content: const Text(
                              "Are you sure you want to remove this transaction?\n\n"
                              "✅ Only successful transactions will be removed from your passbook.\n"
                              "📌 Unsuccessful ones will be kept for managers to verify and track.",
                              style: TextStyle(color: Colors.black),
                            ),
                            actions: [
                              TextButton(
                                child: const Text(
                                  "Cancel",
                                  style: TextStyle(color: Colors.grey),
                                ),
                                onPressed: () => Navigator.pop(context, false),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.amber,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: const Text("Delete"),
                                onPressed: () => Navigator.pop(context, true),
                              ),
                            ],
                          ),
                    );

                    if (confirmDelete == true) {
                      // Check if payment is successful before removing
                      if (payment.status == "success") {
                        final removed = await PaymentCacheService.removePayment(
                          payment.paymentId,
                        );
                        if (!removed) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: Colors.amberAccent,
                              content: Text(
                                style: TextStyle(color: Colors.black),
                                "Failed to delete payment. Please try again.",
                              ),
                            ),
                          );
                        }
                      } else {
                        // Keep unsuccessful payments for manager review
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Colors.amberAccent,
                            content: Text(
                              style: TextStyle(color: Colors.black),
                              "This transaction is pending/failed and will be kept for manager verification.",
                            ),
                          ),
                        );
                      }
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
