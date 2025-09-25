import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rajakumari_scheme/core/controllers/store_list_controller.dart';
import 'package:rajakumari_scheme/core/models/store_model.dart';
import 'package:rajakumari_scheme/features/schedule_visit/controller/schedule_visit_controller.dart';

class ScheduleVisitPage extends StatefulWidget {
  const ScheduleVisitPage({super.key});

  @override
  State<ScheduleVisitPage> createState() => _ScheduleVisitPageState();
}

class _ScheduleVisitPageState extends State<ScheduleVisitPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _storeListController = StoreListController();
  StoreModel? _selectedStore;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _loadStores();
  }

  Future<void> _loadStores() async {
    try {
      await _storeListController.fetchStoreList();
      setState(() {}); // Trigger rebuild to show data in dropdowns
    } catch (e) {
      print('Error loading stores: $e');
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 90)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF6949FF),
              onPrimary: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _handleSubmit(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final controller = context.read<ScheduleVisitController>();

      await controller.scheduleVisit(
        name: _nameController.text,
        mobileCode: '91',
        mobile: _phoneController.text,
        storeId: _selectedStore?.id ?? '',
        date: DateFormat('yyyy-MM-dd').format(_selectedDate!),
      );

      if (controller.isSuccess) {
        Fluttertoast.showToast(
          msg: 'Visit scheduled successfully!',
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green.withOpacity(.8),
        );
        Navigator.pop(context);
      } else if (controller.errorMessage.isNotEmpty) {
        Fluttertoast.showToast(
          msg: controller.errorMessage,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red.withOpacity(.8),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Schedule & Visit',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0.5,
        backgroundColor: Colors.amber.shade600,
        foregroundColor: Colors.white,
      ),

      body: Consumer<ScheduleVisitController>(
        builder: (context, controller, child) {
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name field
                      _buildFieldLabel('Name'),
                      TextFormField(
                        controller: _nameController,
                        decoration: _buildInputDecoration('Enter your name'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),

                      // Phone number section
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Country code field
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildFieldLabel('Country code'),
                                TextFormField(
                                  initialValue: '+91',
                                  readOnly: true,
                                  decoration: _buildInputDecoration(''),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),

                          // Mobile field
                          Expanded(
                            flex: 7,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildFieldLabel('Mobile'),
                                TextFormField(
                                  controller: _phoneController,
                                  keyboardType: TextInputType.phone,
                                  decoration: _buildInputDecoration(
                                    'Enter mobile number',
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your mobile number';
                                    }
                                    if (value.length != 10 ||
                                        int.tryParse(value) == null) {
                                      return 'Please enter a valid 10-digit number';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Store dropdown
                      _buildFieldLabel('Store'),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<StoreModel>(
                            isExpanded: true,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            hint: const Text('Select a store'),
                            value: _selectedStore,
                            items:
                                _storeListController.storeList.map((
                                  StoreModel store,
                                ) {
                                  return DropdownMenuItem<StoreModel>(
                                    value: store,
                                    child: Text(store.storeName),
                                  );
                                }).toList(),
                            onChanged: (StoreModel? newValue) {
                              setState(() {
                                _selectedStore = newValue;
                              });
                            },
                          ),
                        ),
                      ),
                      if (_selectedStore == null)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            'Please select a store',
                            style: TextStyle(
                              color: Colors.red.shade400,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      const SizedBox(height: 24),

                      // Date picker
                      _buildFieldLabel('Date'),
                      InkWell(
                        onTap: () => _selectDate(context),
                        child: IgnorePointer(
                          child: TextFormField(
                            decoration: _buildInputDecoration(
                              'Select a date',
                            ).copyWith(
                              suffixIcon: const Icon(
                                Icons.calendar_today,
                                size: 20,
                              ),
                            ),
                            controller: TextEditingController(
                              text:
                                  _selectedDate == null
                                      ? ''
                                      : DateFormat(
                                        'dd/MM/yyyy',
                                      ).format(_selectedDate!),
                            ),
                            validator: (value) {
                              if (_selectedDate == null) {
                                return 'Please select a date';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),

                      const Spacer(),

                      // Submit button
                      SizedBox(
                        width: double.infinity,
                        height: 40,
                        child: ElevatedButton(
                          onPressed:
                              controller.isLoading
                                  ? null
                                  : () => _handleSubmit(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber.shade400,
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
                              controller.isLoading
                                  ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white,
                                      ),
                                    ),
                                  )
                                  : const Text(
                                    'Book a Visit',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (controller.isLoading)
                Container(
                  color: Colors.black.withOpacity(0.1),
                  child: const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Color(0xFF6949FF),
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildFieldLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        '$label *',
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.black54,
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.black38),
      filled: true,
      fillColor: Colors.grey[50],
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.redAccent, width: 1),
      ),
    );
  }
}
