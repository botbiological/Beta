import 'package:flutter/material.dart';
import 'package:provide/view/settings/account_security_screen.dart';

class PrivacySecurityScreen extends StatefulWidget {
  const PrivacySecurityScreen({super.key});

  @override
  State<PrivacySecurityScreen> createState() => _PrivacySecurityScreenState();
}

class _PrivacySecurityScreenState extends State<PrivacySecurityScreen> {
  bool isPublic = true;
  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF000000);
    const Color cardColor = Color(0xFF1C1C1E);
    const Color accentColor = Color(0xFFFF453A);
    const Color textColor = Colors.white;
    const Color subtitleColor = Colors.white54;

    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: textColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Privacy & Security',
          style: TextStyle(
            color: textColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          children: [
            const SizedBox(height: 8),

            // Profile Visibility Toggle
            _buildSettingCard(
              title: 'Profile Visibility',
              trailing: Transform.scale(
                scale: 0.75, // Reduces the switch size
                child: Switch(
                  value: isPublic,
                  onChanged: (val) {
                    setState(() => isPublic = val);
                  },
                  activeThumbColor: Colors.red,
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Account Security
            _buildSettingCard(
              title: 'Account Security',
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white54,
                size: 16,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AccountSecurityScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 12),

            // Track Visibility
            _buildSettingCard(
              title: 'Track Visibility',
              subtitle: 'Show tracks to all users',
              trailing: const Icon(
                Icons.keyboard_arrow_down,
                color: Colors.white54,
              ),
              onTap: () {},
            ),
            const SizedBox(height: 12),

            // Collab Requests
            _buildSettingCard(
              title: 'Collab Requests',
              subtitle: 'Allow from all',
              trailing: const Icon(
                Icons.keyboard_arrow_down,
                color: Colors.white54,
              ),
              onTap: () {},
            ),
            const SizedBox(height: 12),

            // Messaging Control
            _buildSettingCard(
              title: 'Messaging Control',
              subtitle: 'Allow from all',
              trailing: const Icon(
                Icons.keyboard_arrow_down,
                color: Colors.white54,
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingCard({
    required String title,
    String? subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    const Color cardColor = Color(0xFF1C1C1E);
    const Color textColor = Colors.white;
    const Color subtitleColor = Colors.white54;

    return Material(
      color: cardColor,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          height: 70, // ✅ fixed uniform height for all cards
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left section (title + optional subtitle)
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (subtitle != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Text(
                          subtitle,
                          style: const TextStyle(
                            color: subtitleColor,
                            fontSize: 13,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                  ],
                ),
              ),
              if (trailing != null) trailing,
            ],
          ),
        ),
      ),
    );
  }
}
