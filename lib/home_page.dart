import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map(
          (MapEntry<String, String> e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}',
        )
        .join('&');
  }

  void showError(String message) {
    print(message);
  }

  Future<void> launchWebsite() async {
    final url = Uri.parse("https://flutter.dev");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      showError('Could not open the website.');
    }
  }

  Future<void> launchEmail() async {
    final emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'john@example.com',
      query: encodeQueryParameters({
        'subject': 'Hello From Flutter',
        'body': 'Hello, this is a test email from Flutter app.',
      }),
    );
    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    } else {
      showError('Could not open the email app.');
    }
  }

  Future<void> launchPhone() async {
    final phoneLaunchUri = Uri(
      scheme: 'tel',
      path: '+1234567890',
    );
    if (await canLaunchUrl(phoneLaunchUri)) {
      await launchUrl(phoneLaunchUri);
    } else {
      showError('Could not open the phone app.');
    }
  }

  Future<void> launchSms() async {
    final smsLaunchUri = Uri(
      scheme: 'sms',
      path: '+1234567890',
      query: encodeQueryParameters({
        'body': 'Hello, this is a test message from Flutter application',
      }),
    );
    if (await canLaunchUrl(smsLaunchUri)) {
      await launchUrl(smsLaunchUri);
    } else {
      showError('Could not open the SMS app.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Url Launcher"),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 20,
            children: [
              // YouTube Icon
              FilledButton(
                onPressed: launchWebsite,
                child: Text('Launch Website'),
              ),
              FilledButton(
                onPressed: launchEmail,
                child: Text('Launch Email App'),
              ),
              FilledButton(
                onPressed: launchPhone,
                child: Text('Launch Phone App'),
              ),
              FilledButton(
                onPressed: launchSms,
                child: Text('Launch SMS App'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
