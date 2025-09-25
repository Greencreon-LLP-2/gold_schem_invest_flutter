// ignore_for_file: deprecated_member_use

import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../core/services/shared_pref_service.dart';
import '../../../../core/services/user_details_service.dart';

class NomineeRelationshipOption {
  final String value;
  final String displayText;

  const NomineeRelationshipOption({
    required this.value,
    required this.displayText,
  });
}

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  // Text controllers
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _countryCodeController = TextEditingController();
  final _mobileController = TextEditingController();
  final _passwordController = TextEditingController();
  final _address1Controller = TextEditingController();
  final _address2Controller = TextEditingController();
  final _districtController = TextEditingController();
  final _pincodeController = TextEditingController();
  final _stateController = TextEditingController();
  final _landmarkController = TextEditingController();
  final _aadharController = TextEditingController();
  final _pancardController = TextEditingController();
  final _nomineeNameController = TextEditingController();
  final _nomineeRelationshipController = TextEditingController();
  final _nomineeAddressController = TextEditingController();

  final List<NomineeRelationshipOption> _nomineeRelationshipOptions = const [
    NomineeRelationshipOption(
      value: 'parent',
      displayText: 'Parent (Father or Mother)',
    ),
    NomineeRelationshipOption(
      value: 'spouse',
      displayText: 'Spouse (Husband or Wife)',
    ),
    NomineeRelationshipOption(
      value: 'child',
      displayText: 'Child (Son or Daughter)',
    ),
    NomineeRelationshipOption(
      value: 'sibling',
      displayText: 'Sibling (Brother or Sister)',
    ),
    NomineeRelationshipOption(value: 'guardian', displayText: 'Legal Guardian'),
    NomineeRelationshipOption(value: 'other', displayText: 'Other'),
  ];

  NomineeRelationshipOption? _selectedNomineeRelationship;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final userData = SharedPrefService.getUserData();
      if (userData != null) {
        // Load basic user data
        _nameController.text = SharedPrefService.getUserName();
        _emailController.text = SharedPrefService.getUserEmail();
        _mobileController.text = SharedPrefService.getUserMobile();
        _countryCodeController.text = SharedPrefService.getUserMobileCode();

        // Fetch and load detailed user data
        final userDetails = await UserDetailsService().getUserDetails(
          userData['user_id'],
        );

        // Assign address details
        _address1Controller.text = userDetails.address1;
        _address2Controller.text = userDetails.address2;
        _districtController.text = userDetails.district;
        _pincodeController.text = userDetails.pincode;
        _stateController.text = userDetails.state;
        _landmarkController.text = userDetails.landmark;

        // Assign nominee details
        _nomineeNameController.text = userDetails.nomineeName;
        _nomineeAddressController.text = userDetails.nomineeAddress;

        // Set the selected nominee relationship
        _selectedNomineeRelationship = _nomineeRelationshipOptions.firstWhere(
          (option) => option.value == userDetails.nomineeRelationship,
          orElse: () => _nomineeRelationshipOptions.first,
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Failed to load user details',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red.withOpacity(.7),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _countryCodeController.dispose();
    _mobileController.dispose();
    _passwordController.dispose();
    _address1Controller.dispose();
    _address2Controller.dispose();
    _districtController.dispose();
    _pincodeController.dispose();
    _stateController.dispose();
    _landmarkController.dispose();
    _aadharController.dispose();
    _pancardController.dispose();
    _nomineeNameController.dispose();
    _nomineeRelationshipController.dispose();
    _nomineeAddressController.dispose();
    super.dispose();
  }

  void _handleUpdate() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Simulate network delay
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });

          // Show success message
          Fluttertoast.showToast(
            msg: 'Profile updated successfully',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green.withOpacity(.7),
          );

          Navigator.pop(
            context,
            true,
          ); // Return true to indicate successful update
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0.5,
        backgroundColor: Colors.amber.shade600,
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              children: [
                const SizedBox(height: 8),
                // Avatar and user name display
                Center(
                  child: Column(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: Image.network(
                            'https://ui-avatars.com/api/?name=Unnikrishnan+A&background=random&color=fff&size=80',
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Center(
                                child: Icon(
                                  FeatherIcons.user,
                                  color: Colors.indigo.shade300,
                                  size: 40,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'User ID: RK-3',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Form sections
                _buildSectionHeader('Personal Information'),
                const SizedBox(height: 8),
                _buildTextField(
                  label: 'Name',
                  controller: _nameController,
                  isRequired: true,
                  prefixIcon: Icons.person_outline,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  label: 'Email',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icons.email_outlined,
                ),
                const SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: _buildTextField(
                        label: 'Country code',
                        controller: _countryCodeController,
                        isReadOnly: true,
                        isRequired: true,
                        keyboardType: TextInputType.number,
                        prefixIcon: Icons.flag_outlined,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 5,
                      child: _buildTextField(
                        label: 'Mobile',
                        controller: _mobileController,
                        isReadOnly: true,
                        isRequired: true,
                        keyboardType: TextInputType.phone,
                        prefixIcon: Icons.phone_outlined,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  label: 'Password',
                  controller: _passwordController,
                  obscureText: true,
                  hintText: '6-20 characters',
                  prefixIcon: Icons.lock_outline,
                ),

                const SizedBox(height: 24),
                _buildSectionHeader('Address Information'),
                const SizedBox(height: 8),
                _buildTextField(
                  label: 'Address 1',
                  controller: _address1Controller,
                  isRequired: true,
                  maxLines: 2,
                  prefixIcon: Icons.home_outlined,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  label: 'Address 2',
                  controller: _address2Controller,
                  maxLines: 2,
                  prefixIcon: Icons.location_on_outlined,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  label: 'District',
                  controller: _districtController,
                  isRequired: true,
                  prefixIcon: Icons.location_city_outlined,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  label: 'Pincode',
                  controller: _pincodeController,
                  isRequired: true,
                  keyboardType: TextInputType.number,
                  prefixIcon: Icons.pin_drop_outlined,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  label: 'State',
                  controller: _stateController,
                  isRequired: true,
                  prefixIcon: Icons.map_outlined,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  label: 'Landmark',
                  controller: _landmarkController,
                  prefixIcon: Icons.place_outlined,
                ),

                const SizedBox(height: 24),
                _buildSectionHeader('Identity Information'),
                const SizedBox(height: 8),
                _buildTextField(
                  label: 'Aadhar No',
                  controller: _aadharController,
                  isRequired: true,
                  keyboardType: TextInputType.number,
                  prefixIcon: Icons.badge_outlined,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  label: 'Pancard No',
                  controller: _pancardController,
                  prefixIcon: Icons.card_membership_outlined,
                ),

                const SizedBox(height: 24),
                _buildSectionHeader('Nominee Details'),
                const SizedBox(height: 8),
                _buildTextField(
                  label: 'Nominee Name',
                  controller: _nomineeNameController,
                  isRequired: true,
                  prefixIcon: Icons.person_outline,
                ),
                const SizedBox(height: 16),
                _buildNomineeRelationshipField(),
                const SizedBox(height: 16),
                _buildTextField(
                  label: 'Nominee Address',
                  controller: _nomineeAddressController,
                  isRequired: true,
                  maxLines: 2,
                  prefixIcon: Icons.home_outlined,
                ),
                const SizedBox(height: 32),
                _buildUpdateButton(),
                const SizedBox(height: 32),
              ],
            ),
          ),

          // Loading overlay
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.3),
              child: const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.amber.shade800,
      ),
    );
  }

  Widget _buildTextField({
    bool isReadOnly = false,
    required String label,
    required TextEditingController controller,
    bool isRequired = false,
    TextInputType? keyboardType,
    bool obscureText = false,
    String? hintText,
    int maxLines = 1,
    IconData? prefixIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: label,
            style: const TextStyle(
              color: Colors.black54,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            children:
                isRequired
                    ? const [
                      TextSpan(text: ' *', style: TextStyle(color: Colors.red)),
                    ]
                    : null,
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          enabled: !isReadOnly,
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.black26),
            filled: true,
            fillColor: Colors.grey.shade50,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.indigo.shade300, width: 1.5),
            ),
            prefixIcon:
                prefixIcon != null
                    ? Icon(prefixIcon, color: Colors.grey.shade500, size: 20)
                    : null,
          ),
          validator:
              isRequired
                  ? (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }
                    return null;
                  }
                  : null,
        ),
      ],
    );
  }

  Widget _buildNomineeRelationshipField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: 'Nominee Relationship',
            style: const TextStyle(
              color: Colors.black54,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            children: const [
              TextSpan(text: ' *', style: TextStyle(color: Colors.red)),
            ],
          ),
        ),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<NomineeRelationshipOption>(
              isExpanded: true,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              value: _selectedNomineeRelationship,
              items:
                  _nomineeRelationshipOptions.map((option) {
                    return DropdownMenuItem<NomineeRelationshipOption>(
                      value: option,
                      child: Text(option.displayText),
                    );
                  }).toList(),
              onChanged: (NomineeRelationshipOption? newValue) {
                if (newValue != null) {
                  setState(() {
                    _selectedNomineeRelationship = newValue;
                    _nomineeRelationshipController.text = newValue.value;
                  });
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUpdateButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _handleUpdate,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.amber,
          foregroundColor: Colors.black, // Ensures good contrast on amber
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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        ),

        child:
            _isLoading
                ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
                : const Text(
                  'Update',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
      ),
    );
  }
}
