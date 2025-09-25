import 'package:flutter/material.dart';
import 'package:rajakumari_scheme/features/home/controllers/gold_rate_controller.dart';
import 'package:rajakumari_scheme/features/home/models/gold_rate_model.dart';

class GoldCardWidget extends StatefulWidget {
  const GoldCardWidget({super.key});

  @override
  State<GoldCardWidget> createState() => _GoldCardWidgetState();
}

class _GoldCardWidgetState extends State<GoldCardWidget> {
  final GoldRateController _goldRateController = GoldRateController();
  bool _isLoading = true;
  GoldRateModel? _goldRate;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _loadGoldRates();
  }

  Future<void> _loadGoldRates() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = '';
      });

      final response = await _goldRateController.getGoldRate();

      if (response.data.isNotEmpty) {
        setState(() {
          _goldRate = response.data.first;
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = 'No gold rate data available';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load gold rates: Please}';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isSmallScreen = screenWidth < 300;

    // Define your font sizes based on screen size
    final double titleFont = isSmallScreen ? 14 : 18;
    final double labelFont = isSmallScreen ? 12 : 14;
    final double rateFont = isSmallScreen ? 15 : 18;
    final double karatFont = isSmallScreen ? 14 : 16;
    final double errorFont = isSmallScreen ? 12 : 14;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFFF8E1), Color(0xFFFFE0B2)],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.amber.withOpacity(0.3),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            Positioned(
              right: -15,
              bottom: -15,
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.amber.withOpacity(0.2),
              ),
            ),
            Positioned(
              left: -20,
              top: -20,
              child: CircleAvatar(
                radius: 40,
                backgroundColor: Colors.amber.withOpacity(0.15),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Today\'s Gold Rate',
                        style: TextStyle(
                          fontSize: titleFont,
                          color: Color(0xFF5D4037),
                        ),
                      ),
                      if (_isLoading)
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Color(0xFF5D4037),
                            ),
                          ),
                        ),
                      if (!_isLoading && _errorMessage.isNotEmpty)
                        IconButton(
                          icon: Icon(Icons.refresh, color: Color(0xFF5D4037)),
                          onPressed: _loadGoldRates,
                          iconSize: 20,
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  if (_errorMessage.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        _errorMessage,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: errorFont,
                        ),
                      ),
                    ),

                  if (!_isLoading &&
                      _errorMessage.isEmpty &&
                      _goldRate != null) ...[
                    // Gold rates in a row with two columns
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        //!=========== 22K Column
                        if (_goldRate!.k22_1gm.isNotEmpty ||
                            _goldRate!.k22_8gm.isNotEmpty)
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.only(left: 5),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Karat indicator
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.amber.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      '22K',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: labelFont,
                                        color: Color(0xFF5D4037),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 12),
                                  // 1gm & 8gm row
                                  Row(
                                    children: [
                                      // 1gm
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '1 Gram',
                                              style: TextStyle(
                                                fontSize: karatFont,
                                                color: Color(
                                                  0xFF5D4037,
                                                ).withOpacity(0.7),
                                              ),
                                            ),
                                            Text(
                                              _goldRate!.k22_1gm.isNotEmpty
                                                  ? '₹${_goldRate!.k22_1gm}'
                                                  : 'N/A',
                                              style: TextStyle(
                                                fontSize: rateFont,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFF5D4037),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // 8gm
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              '8 Gram',
                                              style: TextStyle(
                                                fontSize: karatFont,
                                                color: Color(
                                                  0xFF5D4037,
                                                ).withOpacity(0.7),
                                              ),
                                            ),
                                            Text(
                                              _goldRate!.k22_8gm.isNotEmpty
                                                  ? '₹${_goldRate!.k22_8gm}'
                                                  : 'N/A',
                                              style: TextStyle(
                                                fontSize: rateFont,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFF5D4037),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        SizedBox(width: 8),
                        // !==========24K Column==========
                        if (_goldRate!.k24_1gm.isNotEmpty ||
                            _goldRate!.k24_1gm.isNotEmpty)
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.only(right: 5),

                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.7),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Karat indicator
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.amber.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      '24K',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: labelFont,
                                        color: Color(0xFF5D4037),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 12),
                                  // 1gm
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '1 Gram',
                                              style: TextStyle(
                                                fontSize: karatFont,
                                                color: Color(
                                                  0xFF5D4037,
                                                ).withOpacity(0.7),
                                              ),
                                            ),
                                            Text(
                                              _goldRate!.k24_1gm.isNotEmpty
                                                  ? '₹${_goldRate!.k24_1gm}'
                                                  : 'N/A',
                                              style: TextStyle(
                                                fontSize: rateFont,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFF5D4037),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // 8gm
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '8 Gram',
                                              style: TextStyle(
                                                fontSize: karatFont,
                                                color: Color(
                                                  0xFF5D4037,
                                                ).withOpacity(0.7),
                                              ),
                                            ),
                                            Text(
                                              _goldRate!.k24_8gm.isNotEmpty
                                                  ? '₹${_goldRate!.k24_8gm}'
                                                  : 'N/A',
                                              style: TextStyle(
                                                fontSize: rateFont,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFF5D4037),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
