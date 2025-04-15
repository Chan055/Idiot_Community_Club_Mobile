import 'package:flutter/material.dart';

class TermsOfUse extends StatelessWidget {
  const TermsOfUse({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Terms of Use"),
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
                          "Welcome to Community Club! By accessing or using our app, you agree to be bound by these Terms of Use. If you do not agree, please do not use the app.\n"),
                      _SectionTitle("1. Use of the App"),
                      _BulletPoint(
                          "Community Club provides a platform to explore, join, and engage in events, workshops, and activities hosted by different clubs and organizations."),
                      _BulletPoint(
                          "Users agree to provide accurate information and not engage in any fraudulent or misleading activities.\n"),
                      _SectionTitle("2. User Accounts"),
                      _BulletPoint(
                          "You are responsible for maintaining the confidentiality of your account credentials."),
                      _BulletPoint(
                          "Community Club is not liable for any unauthorized access to your account.\n"),
                      _SectionTitle("3. Prohibited Activities"),
                      _BodyText("Users must not:"),
                      _BulletPoint(
                          "Post harmful, offensive, or illegal content."),
                      _BulletPoint(
                          "Harass, impersonate, or misuse the platform for unauthorized purposes."),
                      _BulletPoint(
                          "Attempt to interfere with the app’s security or functionality.\n"),
                      _SectionTitle("4. Event Participation & Liability"),
                      _BulletPoint(
                          "Community Club serves only as a platform for event discovery and participation. We do not directly host or manage events."),
                      _BulletPoint(
                          "Users are responsible for ensuring their safety when attending events. Community Club is not liable for any injuries, damages, or disputes arising from participation in events.\n"),
                      _SectionTitle("5. Content & Intellectual Property"),
                      _BulletPoint(
                          "Users may submit content (e.g., event posts, comments), but Community Club reserves the right to remove inappropriate or misleading content."),
                      _BulletPoint(
                          "All content provided within the app, including logos and designs, is the property of Community Club. Unauthorized use is prohibited.\n"),
                      _SectionTitle("6. Changes to the Terms"),
                      _BodyText(
                          "We may update these Terms of Use at any time. Continued use of the app after changes means you accept the updated terms.\n"),
                      _SectionTitle("7. Contact Us"),
                      _BodyText(
                          "For any questions regarding these Terms of Use, contact us at [your support email].\n"),
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
      padding: const EdgeInsets.only(top: 10, bottom: 4),
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
        decoration: TextDecoration.none, // Ensures no underline
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
        const Text(
          "• ",
          style: TextStyle(color: Colors.black87, fontSize: 14, height: 1.5),
        ),
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
