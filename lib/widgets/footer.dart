import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomFooter extends StatelessWidget {
  const CustomFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32.0),
      decoration: const BoxDecoration(
        color: Color(0xFF1E2A38),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _FooterLink(
                icon: Icons.email_outlined,
                label: '联系�?,
                onTap: () => _launchUrl('mailto:your-email@example.com'),
              ),
              const SizedBox(width: 32),
              _FooterLink(
                icon: Icons.code,
                label: 'GitHub',
                onTap: () => _launchUrl('https://github.com/yourusername'),
              ),
              const SizedBox(width: 32),
              _FooterLink(
                icon: Icons.radio,
                label: '小宇�?,
                onTap: () => _launchUrl('https://xiaoyuzhou.fm/'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Divider(
            color: Colors.white24,
            thickness: 1,
          ),
          const SizedBox(height: 16),
          const Text(
            '© 2024 重拾 · 小宇�?| 用心记录每一次成�?,
            style: TextStyle(
              color: Colors.white54,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            '探索欲与创造力的星系笔�?,
            style: TextStyle(
              color: Colors.white38,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  void _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}

class _FooterLink extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _FooterLink({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Icon(
              icon,
              color: const Color(0xFFA29BFE),
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
