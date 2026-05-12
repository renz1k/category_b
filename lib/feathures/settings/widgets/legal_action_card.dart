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
    final theme = Theme.of(context);

    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          color: theme.brightness == Brightness.dark
              ? Colors.white
              : Colors.black,
        ),
      ),
      trailing: Icon(
        Icons.open_in_new,
        color: theme.brightness == Brightness.dark
            ? Colors.white
            : Colors.black,
      ),
      onTap: () async {
        final uri = Uri.parse(url);
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      },
    );
  }
}
