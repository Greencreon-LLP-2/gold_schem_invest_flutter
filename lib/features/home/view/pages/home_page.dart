// ignore_for_file: deprecated_member_use

import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:rajakumari_scheme/core/controllers/store_list_controller.dart';
import 'package:rajakumari_scheme/core/models/coredata_model.dart';
import 'package:rajakumari_scheme/core/services/auth_state_service.dart';
import 'package:rajakumari_scheme/features/contact/view/pages/contact_page.dart';
import 'package:rajakumari_scheme/features/gold_scheme/view/pages/easygold_info_page.dart';
import 'package:rajakumari_scheme/features/home/view/pages/goldrate/gold_rate_page.dart';
import 'package:rajakumari_scheme/features/home/view/pages/storesPage/store_page.dart';
import 'package:rajakumari_scheme/features/home/view/widgets/banner_widget.dart';
import 'package:rajakumari_scheme/features/home/view/widgets/gold_card_widget.dart';
import 'package:rajakumari_scheme/features/home/view/widgets/notification_widget.dart';
import 'package:rajakumari_scheme/features/schedule_visit/view/pages/Schedule_visit_page.dart';

class HomePage extends StatelessWidget {
  final CoreData? coreData;

  const HomePage({super.key, this.coreData});

  // final VoidCallback? onStoresTap;

  @override
  Widget build(BuildContext context) {
    final AuthStateService authStateService = AuthStateService();
    final isCompact = MediaQuery.of(context).size.width < 320;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            if (coreData?.minLogo != null && coreData!.minLogo.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Image.network(
                  'https://rajakumarischeme.com/admin/${coreData!.minLogo}',
                  height: 32,
                  errorBuilder:
                      (context, error, stackTrace) =>
                          const SizedBox(width: 32, height: 32),
                ),
              ),
            Text(
              coreData?.siteTitle ?? 'Rajakumari',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: isCompact ? 14 : 16,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        actions: [
          authStateService.isLoggedIn && authStateService.userId.isNotEmpty
              ? IconButton(
                icon: const Icon(FeatherIcons.bell, color: Colors.black),
                onPressed: () {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      opaque: false,
                      pageBuilder:
                          (_, __, ___) => NotificationDrawer(
                            userId: authStateService.userId,
                          ),
                      transitionsBuilder: (_, animation, __, child) {
                        const begin = Offset(1.0, 0.0);
                        const end = Offset.zero;
                        const curve = Curves.easeInOut;

                        var tween = Tween(
                          begin: begin,
                          end: end,
                        ).chain(CurveTween(curve: curve));
                        return SlideTransition(
                          position: animation.drive(tween),
                          child: child,
                        );
                      },
                    ),
                  );
                },
              )
              : SizedBox(),
        ],
      ),
      body: ListView(
        children: [
          //!============ Banner  =================
          const BannerWidget(),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),

            child: Column(
              children: [
                //!============ Gold Rate Card  =================
                GoldCardWidget(),
                const SizedBox(height: 24),
                //!============ Services Grid  =================
                LayoutBuilder(
                  builder: (context, constraints) {
                    int crossAxisCount = constraints.maxWidth < 600 ? 3 : 4;

                    return GridView.count(
                      crossAxisCount: crossAxisCount,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      children: [
                        _ServiceIcon(
                          icon: FeatherIcons.trendingUp,
                          label: 'Gold Rate',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const GoldRatePage(),
                              ),
                            );
                          },
                        ),
                        _ServiceIcon(
                          icon: FeatherIcons.mapPin,
                          label: 'Stores',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const StoresPage(),
                              ),
                            );
                          },
                        ),
                        _ServiceIcon(
                          icon: FeatherIcons.star,
                          label: 'Schemes',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => EasygoldInfoPage(),
                              ),
                            );
                          },
                        ),
                        _ServiceIcon(
                          icon: FeatherIcons.phone,
                          label: 'Contact',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ContactPage(coreData: coreData),
                              ),
                            );
                          },
                        ),
                        _ServiceIcon(
                          icon: FeatherIcons.calendar,
                          label: 'Schedule Visit',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const ScheduleVisitPage(),
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ServiceIcon extends StatefulWidget {
  final IconData icon;
  final String label;
  final Function()? onTap;

  const _ServiceIcon({required this.icon, required this.label, this.onTap});

  @override
  State<_ServiceIcon> createState() => _ServiceIconState();
}

class _ServiceIconState extends State<_ServiceIcon> {
  double _elevation = 2;

  void _onTapDown(_) {
    setState(() {
      _elevation = 8;
    });
  }

  void _onTapUp(_) {
    setState(() {
      _elevation = 2;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isCompact = MediaQuery.of(context).size.width < 320;

    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: () => setState(() => _elevation = 2),
      child: AnimatedPhysicalModel(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        elevation: _elevation,
        color: Colors.white.withOpacity(0.6),
        shadowColor: Colors.amber.shade800,
        borderRadius: BorderRadius.circular(isCompact ? 12 : 16),
        shape: BoxShape.rectangle,
        child: Container(
          width: isCompact ? 40 : 90,
          height: isCompact ? 60 : 120,
          padding: EdgeInsets.symmetric(
            horizontal: isCompact ? 2 : 8,
            vertical: isCompact ? 2 : 4,
          ),

          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [Color(0xFFFFF8E1), Colors.amber.shade100],
            ),
            borderRadius: BorderRadius.circular(isCompact ? 12 : 16),
            border: Border.all(color: Colors.amber.withOpacity(0.5), width: 1),
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  padding: EdgeInsets.all(isCompact ? 8 : 10),
                  child: Icon(
                    widget.icon,
                    size: isCompact ? 12 : 18,
                    color: Colors.amber.shade800,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  widget.label,
                  style: TextStyle(
                    fontSize: isCompact ? 10 : 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.clip,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
