import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('About Okwomi Connect', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Text('Okwomi Connect is a private platform for members of the Okwomi Family to stay connected, share news, and participate in family activities.\n\nThis app is designed to foster unity, preserve family history, and make communication easy for all members.'),
          ],
        ),
      ),
    );
  }
} 