import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rajakumari_scheme/core/api_secrets/api_secrets.dart';
import 'package:rajakumari_scheme/features/home/models/banner_model.dart';
import 'package:rajakumari_scheme/features/home/services/banner_service.dart';

class BannerController extends ChangeNotifier {
  final BannerService _bannerService = BannerService();

  List<BannerItem> _banners = [];
  bool _isLoading = false;
  String _error = '';
  int _currentIndex = 0;
  Timer? _autoPlayTimer;
  bool _isAutoPlayEnabled = true;
  DateTime? _lastFetchTime;

  // Cache duration in minutes
  static const int _cacheDurationMinutes = 10;

  // Retry mechanism
  int _retryCount = 0;
  static const int _maxRetries = 3;

  // Getters
  List<BannerItem> get banners => _banners;
  bool get isLoading => _isLoading;
  String get error => _error;
  int get currentIndex => _currentIndex;
  bool get isAutoPlayEnabled => _isAutoPlayEnabled;

  // Set current index
  void setCurrentIndex(int index) {
    if (index >= 0 && index < _banners.length) {
      _currentIndex = index;
      notifyListeners();
    }
  }

  // Toggle autoplay
  void toggleAutoPlay() {
    _isAutoPlayEnabled = !_isAutoPlayEnabled;

    if (_isAutoPlayEnabled) {
      _startAutoPlay();
    } else {
      _stopAutoPlay();
    }

    notifyListeners();
  }

  // Start autoplay
  void _startAutoPlay() {
    _stopAutoPlay(); // Cancel any existing timer

    _autoPlayTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_banners.isNotEmpty && _isAutoPlayEnabled) {
        setCurrentIndex((_currentIndex + 1) % _banners.length);
      }
    });
  }

  // Stop autoplay
  void _stopAutoPlay() {
    _autoPlayTimer?.cancel();
    _autoPlayTimer = null;
  }

  // Handle app lifecycle changes
  void handleLifecycleChange(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      if (_isAutoPlayEnabled) {
        _startAutoPlay();
      }
    } else if (state == AppLifecycleState.paused) {
      _stopAutoPlay();
    }
  }

  // Load banners from API with caching logic
  Future<void> loadBanners({bool forceRefresh = false}) async {
    // Check if we need to fetch new data
    if (!forceRefresh &&
        _banners.isNotEmpty &&
        _lastFetchTime != null &&
        DateTime.now().difference(_lastFetchTime!).inMinutes <
            _cacheDurationMinutes) {
      // Use cached data if available and still valid
      return;
    }

    _setLoading(true);
    _error = '';

    try {
      final response = await _bannerService.getBanners();

      if (response.status == 'true') {
        _banners = response.data;
        _lastFetchTime = DateTime.now();
        _retryCount = 0; // Reset retry count on success

        // Start autoplay if enabled
        if (_isAutoPlayEnabled) {
          _startAutoPlay();
        }
      } else {
        _handleError('Failed to load banners: ${response.code}');
      }
    } catch (e) {
      _handleError('Error loading banners: $e');
    } finally {
      _setLoading(false);
    }
  }

  // Handle error with retry logic
  void _handleError(String errorMessage) {
    _error = errorMessage;
    _showErrorToast(_error);

    // Implement retry with exponential backoff
    if (_retryCount < _maxRetries) {
      _retryCount++;

      // Calculate delay with exponential backoff (1s, 2s, 4s, etc.)
      final delay = Duration(seconds: (1 << (_retryCount - 1)));

      // Schedule retry
      Timer(delay, () {
        if (_banners.isEmpty) {
          // Only retry if we don't have any data
          loadBanners();
        }
      });
    }
  }

  // Get full image URL
  String getFullImageUrl(String imagePath) {
    if (imagePath.startsWith('http')) {
      return imagePath;
    }

    // Assuming the image path is relative to the API base URL
    // Remove the leading slash if present
    final path = imagePath.startsWith('/') ? imagePath.substring(1) : imagePath;

    // Construct the full URL
    final baseUrlWithoutTrailingSlash =
        ApiSecrets.baseUrl.endsWith('/')
            ? ApiSecrets.baseUrl.substring(0, ApiSecrets.baseUrl.length - 1)
            : ApiSecrets.baseUrl;

    return '$baseUrlWithoutTrailingSlash/$path';
  }

  // Helper methods
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _showErrorToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red.withOpacity(0.7),
    );
  }

  // Refresh banners - force refresh from API
  Future<void> refreshBanners() async {
    await loadBanners(forceRefresh: true);
  }

  @override
  void dispose() {
    _stopAutoPlay();
    super.dispose();
  }
}
