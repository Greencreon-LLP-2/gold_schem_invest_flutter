import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import '../models/user_details.dart';

class UserDetailsPrefService {
  static late Box _box;

  static Future<void> init() async {
    _box = await Hive.openBox('user_details');
  }

  static const String _userDetailsData = 'user_details_data';
  static const String _address1 = 'address_1';
  static const String _address2 = 'address_2';
  static const String _district = 'district';
  static const String _pincode = 'pincode';
  static const String _state = 'state';
  static const String _landmark = 'landmark';
  static const String _nomineeName = 'nominee_name';
  static const String _nomineeRelationship = 'nominee_relationship';
  static const String _nomineeAddress = 'nominee_address';

  static String getAddress1() => _box.get(_address1, defaultValue: '');
  static String getAddress2() => _box.get(_address2, defaultValue: '');
  static String getDistrict() => _box.get(_district, defaultValue: '');
  static String getPincode() => _box.get(_pincode, defaultValue: '');
  static String getState() => _box.get(_state, defaultValue: '');
  static String getLandmark() => _box.get(_landmark, defaultValue: '');
  static String getNomineeName() => _box.get(_nomineeName, defaultValue: '');
  static String getNomineeRelationship() =>
      _box.get(_nomineeRelationship, defaultValue: '');
  static String getNomineeAddress() =>
      _box.get(_nomineeAddress, defaultValue: '');

  static UserDetails? getUserDetails() {
    final String? data = _box.get(_userDetailsData);
    if (data == null || data.isEmpty) return null;

    try {
      final Map<String, dynamic> jsonData = json.decode(data);
      return UserDetails.fromJson(jsonData);
    } catch (e) {
      return null;
    }
  }

  static Future<bool> setAddress1(String value) async {
    try {
      await _box.put(_address1, value);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> setAddress2(String value) async {
    try {
      await _box.put(_address2, value);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> setDistrict(String value) async {
    try {
      await _box.put(_district, value);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> setPincode(String value) async {
    try {
      await _box.put(_pincode, value);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> setState(String value) async {
    try {
      await _box.put(_state, value);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> setLandmark(String value) async {
    try {
      await _box.put(_landmark, value);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> setNomineeName(String value) async {
    try {
      await _box.put(_nomineeName, value);
      return true;
    } catch (e) {
      debugPrint('Error setting nominee name: $e');
      return false;
    }
  }

  static Future<bool> setNomineeRelationship(String value) async {
    try {
      await _box.put(_nomineeRelationship, value);
      return true;
    } catch (e) {
      debugPrint('Error setting nominee relationship: $e');
      return false;
    }
  }

  static Future<bool> setNomineeAddress(String value) async {
    try {
      await _box.put(_nomineeAddress, value);
      return true;
    } catch (e) {
      debugPrint('Error setting nominee address: $e');
      return false;
    }
  }

  static Future<bool> saveUserDetails(UserDetails userDetails) async {
    try {
      await setAddress1(userDetails.address1);
      await setAddress2(userDetails.address2);
      await setDistrict(userDetails.district);
      await setPincode(userDetails.pincode);
      await setState(userDetails.state);
      await setLandmark(userDetails.landmark);
      await setNomineeName(userDetails.nomineeName);
      await setNomineeRelationship(userDetails.nomineeRelationship);
      await setNomineeAddress(userDetails.nomineeAddress);

      final Map<String, dynamic> jsonData = {
        'address_1': userDetails.address1,
        'address_2': userDetails.address2,
        'district': userDetails.district,
        'pincode': userDetails.pincode,
        'state': userDetails.state,
        'landmark': userDetails.landmark,
        'nominee_name': userDetails.nomineeName,
        'nominee_relationship': userDetails.nomineeRelationship,
        'nominee_address': userDetails.nomineeAddress,
      };

      await _box.put(_userDetailsData, json.encode(jsonData));
      return true;
    } catch (e) {
      debugPrint('Error saving user details: $e');
      return false;
    }
  }

  static Future<bool> updateUserDetails({
    String? address1,
    String? address2,
    String? district,
    String? pincode,
    String? state,
    String? landmark,
    String? nomineeName,
    String? nomineeRelationship,
    String? nomineeAddress,
  }) async {
    try {
      final userDetails = getUserDetails();
      if (userDetails == null) return false;

      final updatedDetails = UserDetails(
        address1: address1 ?? userDetails.address1,
        address2: address2 ?? userDetails.address2,
        district: district ?? userDetails.district,
        pincode: pincode ?? userDetails.pincode,
        state: state ?? userDetails.state,
        landmark: landmark ?? userDetails.landmark,
        nomineeName: nomineeName ?? userDetails.nomineeName,
        nomineeRelationship:
            nomineeRelationship ?? userDetails.nomineeRelationship,
        nomineeAddress: nomineeAddress ?? userDetails.nomineeAddress,
      );

      return await saveUserDetails(updatedDetails);
    } catch (e) {
      debugPrint('Error updating user details: $e');
      return false;
    }
  }

  static Future<bool> clearUserDetails() async {
    try {
      await _box.delete(_address1);
      await _box.delete(_address2);
      await _box.delete(_district);
      await _box.delete(_pincode);
      await _box.delete(_state);
      await _box.delete(_landmark);
      await _box.delete(_nomineeName);
      await _box.delete(_nomineeRelationship);
      await _box.delete(_nomineeAddress);
      await _box.delete(_userDetailsData);
      return true;
    } catch (e) {
      debugPrint('Error clearing user details: $e');
      return false;
    }
  }

  static bool hasUserDetails() {
    return getUserDetails() != null;
  }
}
