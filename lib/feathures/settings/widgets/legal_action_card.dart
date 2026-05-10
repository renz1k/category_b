import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LegalActionCard extends StatelessWidget {
  const LegalActionCard({
    required this.title,
    required this.url,
    super.key,
  });

  final String title;
  final String url;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      trailing: const Icon(Icons.open_in_new),
      onTap: () async {
        final uri = Uri.parse(url);
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      },
    );
  }
}
