import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rajakumari_scheme/core/api_secrets/api_secrets.dart';
import 'package:rajakumari_scheme/features/home/controllers/banner_controller.dart';
import 'package:rajakumari_scheme/features/home/models/banner_model.dart';

class BannerCarouselWidget extends StatefulWidget {
  const BannerCarouselWidget({super.key});

  @override
  State<BannerCarouselWidget> createState() => _BannerCarouselWidgetState();
}

class _BannerCarouselWidgetState extends State<BannerCarouselWidget>
    with WidgetsBindingObserver {
  final PageController _pageController = PageController(keepPage: true);

  BannerController get _controller =>
      Provider.of<BannerController>(context, listen: false);

  @override
  void initState() {
    super.initState();
    // Register for lifecycle events
    WidgetsBinding.instance.addObserver(this);

    // Load banners when widget initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.loadBanners();
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Forward lifecycle events to controller
    _controller.handleLifecycleChange(state);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BannerController>(
      builder: (context, bannerController, child) {
        if (bannerController.isLoading && bannerController.banners.isEmpty) {
          return _buildLoadingIndicator();
        } else if (bannerController.error.isNotEmpty &&
            bannerController.banners.isEmpty) {
          return _buildErrorWidget(bannerController);
        } else if (bannerController.banners.isEmpty) {
          return const SizedBox(); // No banners available
        } else {
          return _buildCarousel(bannerController);
        }
      },
    );
  }

  Widget _buildLoadingIndicator() {
    return Container(
      height: 180,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(child: Image.asset('assets/images/loading.gif')),
    );
  }

  Widget _buildErrorWidget(BannerController controller) {
    return Container(
      height: 180,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, color: Colors.red, size: 40),
          const SizedBox(height: 8),
          const Text('Failed to load banners'),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => controller.refreshBanners(),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildCarousel(BannerController controller) {
    final banners = controller.banners;

    // Listen for index changes from the controller
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_pageController.hasClients &&
          _pageController.page?.round() != controller.currentIndex) {
        _pageController.animateToPage(
          controller.currentIndex,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });

    return Column(
      children: [
        SizedBox(
          height: 180,
          child: PageView.builder(
            controller: _pageController,
            itemCount: banners.length,
            onPageChanged: (index) {
              controller.setCurrentIndex(index);
            },
            itemBuilder: (context, index) {
              return _buildCarouselItem(banners[index], controller, context);
            },
          ),
        ),
        const SizedBox(height: 8),
        _buildIndicators(banners, controller),

        // Optional control buttons
        // if (banners.length > 1)
        //   Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       IconButton(
        //         icon: Icon(
        //           controller.isAutoPlayEnabled
        //               ? Icons.pause_circle_outline
        //               : Icons.play_circle_outline,
        //         ),
        //         onPressed: () => controller.toggleAutoPlay(),
        //         tooltip:
        //             controller.isAutoPlayEnabled
        //                 ? 'Pause autoplay'
        //                 : 'Start autoplay',
        //       ),
        //     ],
        //   ),
      ],
    );
  }

  Widget _buildCarouselItem(
    BannerItem banner,
    BannerController controller,
    BuildContext context,
  ) {
    final screenWidth = MediaQuery.of(context).size.width;

    log('Banner image URL: ${ApiSecrets.imageBaseUrl}${banner.image}');

    return GestureDetector(
      onTap: () {
        // Handle banner tap - navigate to product or external link
        if (banner.ifProduct == '1') {
          // Navigate to product detail
          // Navigator.push(...);
          debugPrint('Navigate to product ID: ${banner.link}');
        } else {
          // Handle external link if needed
          debugPrint('Open link: ${banner.link}');
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            children: [
              // Banner image with caching
              CachedNetworkImage(
                imageUrl: "${ApiSecrets.imageBaseUrl}${banner.image}",
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                // Memory optimizations
                memCacheWidth: screenWidth.toInt(),
                // Loading placeholder
                placeholder:
                    (context, url) => Container(
                      color: Colors.grey[200],
                      child: Center(
                        child: Image.asset('assets/images/loading.gif'),
                      ),
                    ),
                // Error placeholder
                errorWidget:
                    (context, url, error) => Container(
                      color: Colors.grey[200],
                      child: const Center(
                        child: Icon(
                          Icons.broken_image_outlined,
                          color: Colors.grey,
                          size: 40,
                        ),
                      ),
                    ),
              ),

              // Optional: Title overlay at the bottom
              // if (banner.title.isNotEmpty)
              //   Positioned(
              //     bottom: 0,
              //     left: 0,
              //     right: 0,
              //     child: Container(
              //       padding: const EdgeInsets.symmetric(
              //         vertical: 8,
              //         horizontal: 12,
              //       ),
              //       decoration: BoxDecoration(
              //         gradient: LinearGradient(
              //           begin: Alignment.bottomCenter,
              //           end: Alignment.topCenter,
              //           colors: [
              //             Colors.black.withOpacity(0.7),
              //             Colors.transparent,
              //           ],
              //         ),
              //       ),
              //       child: Text(
              //         banner.title,
              //         style: const TextStyle(
              //           color: Colors.white,
              //           fontSize: 16,
              //           fontWeight: FontWeight.w600,
              //         ),
              //       ),
              //     ),
              //   ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIndicators(
    List<BannerItem> banners,
    BannerController controller,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:
          banners.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () {
                controller.setCurrentIndex(entry.key);
                _pageController.animateToPage(
                  entry.key,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              child: Container(
                width: 8.0,
                height: 8.0,
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      controller.currentIndex == entry.key
                          ? Theme.of(context).primaryColor
                          : Colors.grey[300],
                ),
              ),
            );
          }).toList(),
    );
  }
}
