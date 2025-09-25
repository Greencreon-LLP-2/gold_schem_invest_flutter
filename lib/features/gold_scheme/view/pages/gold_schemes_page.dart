// ignore_for_file: deprecated_member_use

import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:rajakumari_scheme/features/gold_scheme/controllers/scheme_list_controller.dart';
import 'package:rajakumari_scheme/features/gold_scheme/models/scheme_model.dart';
import 'package:rajakumari_scheme/features/gold_scheme/view/pages/scheme_invest_page.dart';

class GoldSchemesPage extends StatefulWidget {
  const GoldSchemesPage({super.key});

  @override
  State<GoldSchemesPage> createState() => _GoldSchemesPageState();
}

class _GoldSchemesPageState extends State<GoldSchemesPage> {
  final SchemeListController _controller = SchemeListController();
  bool _isLoading = true;
  List<SchemeModel> _schemes = [];
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _loadSchemes();
  }

  Future<void> _loadSchemes() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = '';
      });

      final response = await _controller.getSchemeList();

      if (response.status == 'true' && response.data.isNotEmpty) {
        setState(() {
          _schemes = response.data;
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = 'No schemes available';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load schemes';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Our Schemes',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0.5,
        backgroundColor: Colors.amber.shade600,
        foregroundColor: Colors.white,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return Center(child: Image.asset('assets/images/loading.gif'));
    }

    if (_errorMessage.isNotEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _errorMessage,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: _loadSchemes, child: const Text('Retry')),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadSchemes,
      child: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _schemes.length + 1, // +1 for the warning
        itemBuilder: (context, index) {
          if (index == 0) {
            return _buildWarningMessage(); // Add warning at the top
          }
          final scheme = _schemes[index - 1]; // Shift index
          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: _buildSchemeCardFromModel(scheme),
          );
        },
      ),
    );
  }

  Widget _buildWarningMessage() {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.amber.shade100.withOpacity(0.6),
        border: Border.all(color: Colors.amber.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.warning_amber_rounded,
            color: Colors.deepOrange,
            size: 40,
          ),
          const SizedBox(width: 12),
          Text(
            'Before you join a scheme, make sure to follow all on-screen instructions carefully.\n\n'
            'Do NOT close the app or payment gateway unless a success or failure message is shown.\n\n'
            'If you face any issues, avoid exiting the app abruptly.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade900,
              fontWeight: FontWeight.w500,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSchemeCardFromModel(SchemeModel scheme) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.amber.withOpacity(0.3)),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(
                  255,
                  247,
                  225,
                  159,
                ).withOpacity(0.2),
                blurRadius: 10,
                offset: Offset(0, 6),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Column(
            children: [
              Text(
                scheme.name.toUpperCase(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),
              _buildInfoItem(
                icon: Icons.calendar_month_outlined,
                label: 'Duration',
                value: '${scheme.noMonths} months',
              ),
              _buildInfoItem(
                icon: Icons.payments_outlined,
                label: 'Monthly Payment',
                value: '₹ ${scheme.instalmentAmt}',
              ),
              _buildInfoItem(
                icon: Icons.savings_outlined,
                label: 'Total Paid',
                value: '₹ ${scheme.totalInstalmentAmt}',
              ),
              _buildInfoItem(
                icon: Icons.card_giftcard_outlined,
                label: 'Bonus',
                value: '₹ ${scheme.bonusAmt}',
              ),
              _buildInfoItem(
                icon: Icons.account_balance_wallet_outlined,
                label: 'Total Benefit',
                value: '₹ ${scheme.totalAmt}',
              ),
              const SizedBox(height: 16),
              _buildJoinButton(scheme),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    // Define a list of potential icon colors
    final List<Color> iconColors = [
      Colors.amber.shade700,
      Colors.teal.shade600,
      Colors.deepOrange.shade600,
      Colors.indigo.shade600,
      Colors.purple.shade600,
      Colors.green.shade700,
    ];

    // Pick a random color
    final Color randomColor = iconColors[Random().nextInt(iconColors.length)];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(flex: 1, child: Icon(icon, size: 28, color: randomColor)),
          const SizedBox(width: 12),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJoinButton(SchemeModel scheme) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => SchemeInvestPage(
                  schemeId: scheme.id,
                  amount: scheme.instalmentAmt,
                ),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.amber,
        foregroundColor: Colors.black, // Ensures good contrast on amber
        minimumSize: const Size(100, 44),
        elevation: 4,
        shadowColor: Colors.amber.shade200,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),

      child: const Text(
        'Join',
        style: TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
