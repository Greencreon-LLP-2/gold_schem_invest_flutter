import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rajakumari_scheme/features/home/models/notification_model.dart';
import 'package:rajakumari_scheme/features/home/services/notification_service.dart';


class NotificationDrawer extends StatefulWidget {
  final String userId;
  const NotificationDrawer({super.key, required this.userId});

  @override
  State<NotificationDrawer> createState() => _NotificationDrawerState();
}

class _NotificationDrawerState extends State<NotificationDrawer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  final NotificationService _notificationService = NotificationService();

  List<NotificationData> notifications = [];
  bool loading = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _loadNotifications();
    _controller.forward();
  }

  Future<void> _loadNotifications() async {
    setState(() => loading = true);
    try {
      final data = await _notificationService.fetchNotifications(widget.userId);
      setState(() => notifications = data);
    } catch (e) {
      debugPrint("Error: $e");
    } finally {
      setState(() => loading = false);
    }
  }

  void closeDrawer() {
    _controller.reverse().then((_) => Navigator.pop(context));
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          title: const Text(
            "Notifications",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.amberAccent,
          elevation: 1,
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh, color: Colors.black),
              onPressed: _loadNotifications,
            ),
            IconButton(
              icon: const Icon(Icons.close, color: Colors.black),
              onPressed: closeDrawer,
            ),
          ],
        ),
        body: loading
            ? const Center(
                child: CircularProgressIndicator(color: Colors.amber),
              )
            : notifications.isEmpty
                ? const Center(
                    child: Text(
                      "No notifications found",
                      style: TextStyle(color: Colors.black54, fontSize: 16),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: notifications.length,
                    itemBuilder: (context, index) {
                      final notif = notifications[index];
                      return _notificationCard(notif);
                    },
                  ),
      ),
    );
  }

  Widget _notificationCard(NotificationData notif) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 1),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 6,
          shadowColor: Colors.black26,
          child: ExpansionTile(
            tilePadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            leading: CircleAvatar(
              backgroundColor: Colors.amber.shade100,
              child: const Icon(Icons.notifications_active, color: Colors.amber),
            ),
            title: Text(
              notif.title.isNotEmpty ? notif.title : 'Notification',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            subtitle: Text(
              notif.msg.isNotEmpty ? notif.msg : '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.black54),
            ),
            iconColor: Colors.amber,
            collapsedIconColor: Colors.amber,
            childrenPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            children: [
              _detailTile(Icons.info, "ID", notif.id),
              _detailTile(Icons.title, "Title", notif.title),
              _detailTile(Icons.message, "Message", notif.msg),
              if (notif.link.isNotEmpty)
                _detailTile(Icons.link, "Link", notif.link, isLink: true),
              _detailTile(
                Icons.access_time,
                "Created At",
                DateFormat("dd MMM yyyy, hh:mm a").format(notif.createdOn),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _detailTile(IconData icon, String label, String value,
      {bool isLink = false}) {
    return Column(
      children: [
        ListTile(
          dense: true,
          contentPadding: EdgeInsets.zero,
          leading: Icon(icon, color: Colors.amber, size: 22),
          title: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
              fontSize: 14,
            ),
          ),
          subtitle: isLink
              ? InkWell(
                  onTap: () => debugPrint("Open link: $value"),
                  child: Text(
                    value,
                    style: const TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                )
              : Text(
                  value,
                  style: const TextStyle(color: Colors.black87, fontSize: 13),
                ),
        ),
        const Divider(height: 1, color: Colors.black12),
      ],
    );
  }
}
