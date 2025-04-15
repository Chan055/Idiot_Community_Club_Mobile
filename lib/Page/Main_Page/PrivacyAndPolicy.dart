import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Privacy and Policy"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            children: [
              const SizedBox(height: 10),
              const Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _BodyText("Last Updated: 01/04/2025\n"),
                      _BodyText(
                          "We value your privacy and are committed to protecting your personal information. This Privacy Policy explains how we collect, use, and protect your data when you use Community Club.\n"),
                      _SectionTitle("1. Information We Collect"),
                      _BulletPoint(
                          "Personal Information: Name, email, profile details (if provided)."),
                      _BulletPoint(
                          "Usage Data: App interactions, event preferences, and engagement statistics."),
                      _BulletPoint(
                          "Device Information: IP address, device type, and operating system.\n"),
                      _SectionTitle("2. How We Use Your Information"),
                      _BulletPoint(
                          "Provide and improve the Community Club experience."),
                      _BulletPoint("Allow you to discover and join events."),
                      _BulletPoint(
                          "Ensure app security and prevent fraudulent activities.\n"),
                      _SectionTitle("3. Data Sharing & Third Parties"),
                      _BulletPoint("We do not sell your personal data."),
                      _BulletPoint(
                          "We may share necessary information with event organizers to facilitate event participation."),
                      _BulletPoint(
                          "We use third-party services for analytics, cloud storage, and app performance monitoring.\n"),
                      _SectionTitle("4. Data Security"),
                      _BodyText(
                          "We implement measures to protect your personal data, but no method of transmission over the internet is 100% secure.\n"),
                      _SectionTitle("5. Your Rights"),
                      _BulletPoint(
                          "You can update or delete your profile information."),
                      _BulletPoint(
                          "You can opt out of marketing emails at any time.\n"),
                      _SectionTitle("6. Changes to This Policy"),
                      _BodyText(
                          "We may update this Privacy Policy periodically. Continued use of the app after updates constitutes acceptance of the revised policy.\n"),
                      _SectionTitle("7. Contact Us"),
                      _BodyText(
                          "For privacy-related inquiries, contact us at [your support email].\n"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 6),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }
}

class _BodyText extends StatelessWidget {
  final String text;
  const _BodyText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.black87,
        fontSize: 14,
        height: 1.5,
        decoration: TextDecoration.none,
      ),
    );
  }
}

class _BulletPoint extends StatelessWidget {
  final String text;
  const _BulletPoint(this.text);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("• ",
            style: TextStyle(color: Colors.black87, fontSize: 14, height: 1.5)),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 14,
              height: 1.5,
              decoration: TextDecoration.none,
            ),
          ),
        ),
      ],
    );
  }
}
