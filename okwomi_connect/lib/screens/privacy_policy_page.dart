import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Privacy Policy for Okwomi Connect',
                style: textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Last Updated: June 6, 2025',
                style: textTheme.bodyMedium?.copyWith(fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 24),
              Text(
                'Welcome to Okwomi Connect, a mobile and web platform created for members of the Okwomi Family. Your privacy is important to us. This Privacy Policy explains how we collect, use, and protect your information when you use our services.',
                style: textTheme.bodyLarge,
              ),
              const SizedBox(height: 32),
              _sectionTitle('1. Information We Collect', textTheme),
              const SizedBox(height: 12),
              _subSectionTitle('a) Personal Information', textTheme),
              _bulletedList([
                'Full name',
                'Phone number',
                'Email address',
                'Relationship/family branch',
                'Profile photo',
              ], textTheme),
              const SizedBox(height: 12),
              _subSectionTitle('b) Contribution Data', textTheme),
              Text('We collect and store information related to financial contributions for family events and causes.', style: textTheme.bodyMedium),
              const SizedBox(height: 12),
              _subSectionTitle('c) Usage Data', textTheme),
              Text('We collect anonymous usage data to improve the app, including:', style: textTheme.bodyMedium),
              _bulletedList([
                'App features used',
                'Device type',
                'Interaction timestamps',
              ], textTheme),
              const SizedBox(height: 32),
              _sectionTitle('2. How We Use Your Information', textTheme),
              _bulletedList([
                'Maintain accurate member records',
                'Notify members of events, contributions, and messages',
                'Enable role-based access for authorized family members',
                'Preserve family history through shared stories and tributes',
              ], textTheme),
              const SizedBox(height: 32),
              _sectionTitle('3. Who Can Access Your Data', textTheme),
              Text('Your personal data is accessible only by authorized users (Chairman, Secretary, Treasurer, Organizing Secretary) within the Okwomi family group. Public stories and tributes may be visible to all members and the public if marked as such.', style: textTheme.bodyLarge),
              const SizedBox(height: 32),
              _sectionTitle('4. Data Sharing', textTheme),
              Text('We do NOT sell or share your data with third parties. Messaging is sent directly from administrators\' personal phones and is not routed through external SMS/WhatsApp APIs.', style: textTheme.bodyLarge),
              const SizedBox(height: 32),
              _sectionTitle('5. Data Storage and Security', textTheme),
              _bulletedList([
                'All data is securely stored in Firebase (Google Cloud infrastructure).',
                'We implement role-based authentication and restricted database rules.',
                'Profile and file uploads are secured and only accessible to verified users.',
              ], textTheme),
              const SizedBox(height: 32),
              _sectionTitle('6. Your Rights', textTheme),
              Text('You may:', style: textTheme.bodyLarge),
              _bulletedList([
                'Request to view or correct your data',
                'Request account deletion',
                'Withdraw your participation at any time',
              ], textTheme),
              Text('To exercise these rights, contact the administrator at ', style: textTheme.bodyLarge),
              InkWell(
                child: Text('hello@mwando.co.ke', style: textTheme.bodyLarge?.copyWith(color: Colors.blue, decoration: TextDecoration.underline)),
                onTap: () => _launchEmail(),
              ),
              const SizedBox(height: 32),
              _sectionTitle("7. Children's Privacy", textTheme),
              Text('This app is intended for use by family members. Children under 13 must have consent from a parent or guardian to participate.', style: textTheme.bodyLarge),
              const SizedBox(height: 32),
              _sectionTitle('8. Changes to This Privacy Policy', textTheme),
              Text('We may update this policy from time to time. All changes will be posted within the app and on the official family portal.', style: textTheme.bodyLarge),
              const SizedBox(height: 32),
              _sectionTitle('9. Contact Information', textTheme),
              Text('For any questions or concerns:', style: textTheme.bodyLarge),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.phone, size: 20),
                  const SizedBox(width: 8),
                  Text('+254 116 001122', style: textTheme.bodyLarge),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.email, size: 20),
                  const SizedBox(width: 8),
                  InkWell(
                    child: Text('hello@mwando.co.ke', style: textTheme.bodyLarge?.copyWith(color: Colors.blue, decoration: TextDecoration.underline)),
                    onTap: () => _launchEmail(),
                  ),
                ],
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _sectionTitle(String text, TextTheme textTheme) =>
      Text(text, style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold));

  static Widget _subSectionTitle(String text, TextTheme textTheme) =>
      Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
        child: Text(text, style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
      );

  static Widget _bulletedList(List<String> items, TextTheme textTheme) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: items
            .map((item) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('• ', style: TextStyle(fontSize: 18)),
                      Expanded(child: Text(item, style: textTheme.bodyMedium)),
                    ],
                  ),
                ))
            .toList(),
      );

  static void _launchEmail() {
    // This is a placeholder for launching email. In a real app, use url_launcher.
    // launchUrl(Uri.parse('mailto:hello@mwando.co.ke'));
  }
} 