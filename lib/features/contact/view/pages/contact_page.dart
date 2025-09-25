import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:rajakumari_scheme/core/models/coredata_model.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatelessWidget {
  final CoreData? coreData;

  const ContactPage({super.key, required this.coreData});

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: const Text(
          'Contact Us',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0.5,
        backgroundColor: Colors.amber.shade600,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Get in touch with us',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Choose one of the options below to reach our team',
            style: TextStyle(fontSize: 16, color: Colors.black54),
          ),
          const SizedBox(height: 30),

          _ContactOption(
            icon: FeatherIcons.phone,
            title: 'Call Us',
            subtitle: 'Speak directly with our customer service',
            color: Colors.blue,
            onTap: () => _launchUrl('tel:${coreData?.whatsappNo}'),
          ),

          _ContactOption(
            icon: FeatherIcons.messageCircle,
            title: 'WhatsApp',
            subtitle: 'Chat with us on WhatsApp',
            color: Colors.green,
            onTap: () => _launchUrl('https://wa.me/${coreData?.whatsappNo}'),
          ),

          _ContactOption(
            icon: FeatherIcons.mail,
            title: 'Email',
            subtitle: 'Send us an email at support@rajakumari.com',
            color: Colors.red,
            onTap: () => _launchUrl('mailto:${coreData?.siteEmail}'),
          ),

          // _ContactOption(
          //   icon: FeatherIcons.mapPin,
          //   title: 'Visit Store',
          //   subtitle: 'Find the nearest store location',
          //   color: Colors.orange,
          //   onTap: () {
          //     Navigator.pop(context);
          //     // Navigate to the stores page through home page
          //   },
          // ),
          const SizedBox(height: 30),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Business Hours',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 12),
                Text('Monday - Saturday: 10:00 AM - 8:00 PM'),
                SizedBox(height: 6),
                Text('Sunday: 11:00 AM - 6:00 PM'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ContactOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _ContactOption({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 255, 244, 202),
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, size: 28, color: color),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[400]),
            ],
          ),
        ),
      ),
    );
  }
}
