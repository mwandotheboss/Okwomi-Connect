import 'package:flutter/material.dart';

class TermsOfServicePage extends StatelessWidget {
  const TermsOfServicePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms of Service'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Terms of Service for Okwomi Connect',
                style: textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Last Updated: June 6, 2025',
                style: textTheme.bodyMedium?.copyWith(fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 24),
              _sectionTitle('1. Purpose of the App', textTheme),
              _bulletedList([
                'Foster communication among Okwomi family members',
                'Track and manage family contributions and events',
                'Preserve family history, stories, and meeting records',
                'Strengthen connection, transparency, and unity within the family',
              ], textTheme),
              const SizedBox(height: 24),
              _sectionTitle('2. Eligibility', textTheme),
              _bulletedList([
                'Only verified members of the Okwomi Family may use this platform.',
                'Each member must be approved by an administrator (Chairman, Secretary, Treasurer, or Organizing Secretary).',
                'The app is not intended for public or commercial use.',
              ], textTheme),
              const SizedBox(height: 24),
              _sectionTitle('3. User Responsibilities', textTheme),
              _bulletedList([
                'Provide truthful and accurate information during registration',
                'Use the app in a respectful and constructive manner',
                'Keep your login credentials confidential',
                'Avoid impersonating other members or administrators',
                'Not upload or share any harmful, offensive, or misleading content',
              ], textTheme),
              const SizedBox(height: 24),
              _sectionTitle('4. Roles and Permissions', textTheme),
              Text('Each user is assigned one of the following roles:', style: textTheme.bodyLarge),
              _bulletedList([
                'Chairman: Oversees all operations, approvals, and member management',
                'Secretary: Manages stories, minutes, profiles',
                'Treasurer: Records contributions and tracks monthly payments',
                'Organizing Secretary: Manages events, RSVPs, and notifications',
                'Member: General access to view and participate in family activities',
              ], textTheme),
              Text('Roles are granted only by administrators and may be changed or revoked as necessary.', style: textTheme.bodyMedium),
              const SizedBox(height: 24),
              _sectionTitle('5. Content Ownership', textTheme),
              Text('All content uploaded (stories, tributes, images, meeting minutes) remains the property of the contributor.', style: textTheme.bodyLarge),
              Text('By submitting content, you grant the family group a non-exclusive right to store, display, and preserve it for internal purposes.', style: textTheme.bodyMedium),
              Text('Public tributes may be shown outside the app if marked as public.', style: textTheme.bodyMedium),
              const SizedBox(height: 24),
              _sectionTitle('6. Contributions and Transactions', textTheme),
              _bulletedList([
                'All financial contributions logged in the app are for family use (e.g., funerals, weddings, emergencies).',
                'The app is not linked to any payment system — contributions are tracked only after confirmation from the treasurer or administrators.',
              ], textTheme),
              const SizedBox(height: 24),
              _sectionTitle('7. Account Suspension or Removal', textTheme),
              Text('Admins may suspend or remove a user account for:', style: textTheme.bodyLarge),
              _bulletedList([
                'Misuse of the platform',
                'Inappropriate behavior',
                'Sharing false information',
                'Breaching family unity or respect',
              ], textTheme),
              Text('Affected members will be notified of such action and may appeal to the Chairman.', style: textTheme.bodyMedium),
              const SizedBox(height: 24),
              _sectionTitle('8. Privacy and Data', textTheme),
              Text('Use of the app is also governed by the Privacy Policy which outlines how your data is handled and protected. By using the app, you agree to those terms.', style: textTheme.bodyLarge),
              const SizedBox(height: 24),
              _sectionTitle('9. Modifications to the Service', textTheme),
              Text('Okwomi Connect may update, enhance, or discontinue features at any time without notice. These changes are made in good faith to benefit all family members.', style: textTheme.bodyLarge),
              const SizedBox(height: 24),
              _sectionTitle('10. Governing Principles', textTheme),
              Text('This platform is guided by the values of the Okwomi family:', style: textTheme.bodyLarge),
              _bulletedList([
                'Respect',
                'Unity',
                'Transparency',
                'Legacy',
              ], textTheme),
              Text('Every user agrees to uphold these values while using the app.', style: textTheme.bodyMedium),
              const SizedBox(height: 24),
              _sectionTitle('11. Contact Information', textTheme),
              Text('For questions or assistance:', style: textTheme.bodyLarge),
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
                  Text('hello@mwando.co.ke', style: textTheme.bodyLarge?.copyWith(color: Colors.blue, decoration: TextDecoration.underline)),
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
} 