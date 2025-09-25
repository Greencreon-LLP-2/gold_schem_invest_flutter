import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rajakumari_scheme/features/home/controllers/gold_rate_list_controller.dart';
import 'package:rajakumari_scheme/features/home/models/gold_rate_list_model.dart';

class GoldRatePage extends StatefulWidget {
  const GoldRatePage({super.key});

  @override
  State<GoldRatePage> createState() => _GoldRatePageState();
}

class _GoldRatePageState extends State<GoldRatePage> {
  final GoldRateListController _controller = GoldRateListController();
  bool _isLoading = true;
  List<GoldRateListModel> _goldRates = [];
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

      final response = await _controller.getGoldRateList();

      if (response.status == 'true' && response.data.isNotEmpty) {
        setState(() {
          _goldRates = response.data;
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
        _errorMessage = 'Failed to load gold rates';
        _isLoading = false;
      });
    }
  }

  String _formatDate(String dateStr) {
    try {
      final DateTime date = DateTime.parse(dateStr);
      return DateFormat('dd MMM yyyy').format(date);
    } catch (e) {
      return dateStr;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Gold Rate History',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0.5,
        backgroundColor: Colors.amber.shade600,
        foregroundColor: Colors.white,
      ),
      body:
          _isLoading
              ? Center(child: Image.asset('assets/images/loading.gif'))
              : _errorMessage.isNotEmpty
              ? Center(child: Text(_errorMessage))
              : RefreshIndicator(
                onRefresh: _loadGoldRates,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Gold Rate History',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.15),
                                blurRadius: 12,
                                spreadRadius: 3,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: DataTable(
                                columnSpacing: 24,
                                dataRowHeight: 56,
                                headingRowHeight: 60,
                                dividerThickness: 1,
                                headingRowColor: WidgetStateProperty.all(
                                  Colors.amber,
                                ),
                                dataRowColor: WidgetStateProperty.resolveWith<
                                  Color?
                                >((Set<WidgetState> states) {
                                  if (states.contains(WidgetState.selected)) {
                                    return Colors.amber.shade50;
                                  }
                                  return null;
                                }),
                                columns: const [
                                  DataColumn(
                                    label: Text(
                                      'Date',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      '22K/1gm',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      '22K/8gm',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      '24K/1gm',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      '24K/8gm',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                                rows:
                                    _goldRates.map((rate) {
                                      return DataRow(
                                        cells: [
                                          DataCell(
                                            Text(_formatDate(rate.createdOn)),
                                          ),
                                          DataCell(Text('₹${rate.k22_1gm}')),
                                          DataCell(Text('₹${rate.k22_8gm}')),
                                          DataCell(
                                            Text(
                                              rate.k24_1gm.isEmpty
                                                  ? '-'
                                                  : '₹${rate.k24_1gm}',
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              rate.k24_8gm.isEmpty
                                                  ? '-'
                                                  : '₹${rate.k24_8gm}',
                                            ),
                                          ),
                                        ],
                                      );
                                    }).toList(),
                              ),
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
}
