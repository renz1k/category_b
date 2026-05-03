import 'dart:async';

import 'package:category_b/core/di/setup_dependencies.dart';
import 'package:category_b/core/texts/app_texts.dart';
import 'package:category_b/ui/theme/app_theme_tokens.dart';
import 'package:category_b/ui/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:talker/talker.dart';
import 'package:url_launcher/url_launcher.dart';

const _supportEmail = 'mrdima_aysdehtyarenko@mail.ru';
const _supportTelegram = 'https://t.me/pbth34';
const _supportTelegramDeepLink = 'tg://resolve?domain=pbth34';
const _supportEmailSubject = 'по поводу приложения Anekdots B';

class SupportBottomSheet extends StatelessWidget {
  const SupportBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (theme.isAndroid) {
      return Padding(
        padding: AppThemeTokens.paddingSupportSheet.copyWith(
          top: AppThemeTokens.paddingTopSupportSheet.top,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Spacer(),
                IconButton(
                  onPressed: () => _close(context),
                  icon: Icon(Icons.close, color: theme.hintColor),
                ),
              ],
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton.icon(
                onPressed: () => unawaited(_openTelegram(context)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.primaryColor,
                  foregroundColor: Colors.white,
                ),
                label: const Text(AppTexts.settingsTelegramText),
                icon: const Icon(Icons.telegram, color: Colors.white),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: OutlinedButton.icon(
                onPressed: () => unawaited(_openEmail(context)),
                style: OutlinedButton.styleFrom(
                  foregroundColor: theme.brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                  side: BorderSide(color: theme.hintColor),
                ),
                label: const Text(AppTexts.settingsEmailText),
                icon: const Icon(Icons.email_outlined),
              ),
            ),
          ],
        ),
      );
    }
    return CupertinoActionSheet(
      title: const Text(AppTexts.settingsSupportTitle),
      message: const Text(AppTexts.settingsSupportText),
      actions: <CupertinoActionSheetAction>[
        CupertinoActionSheetAction(
          isDefaultAction: true,
          child: const Text(
            AppTexts.settingsTelegramText,
            style: TextStyle(color: CupertinoColors.activeBlue),
          ),
          onPressed: () => unawaited(_openTelegram(context)),
        ),
        CupertinoActionSheetAction(
          isDestructiveAction: true,
          child: const Text(
            AppTexts.settingsEmailText,
            style: TextStyle(color: CupertinoColors.activeBlue),
          ),
          onPressed: () => unawaited(_openEmail(context)),
        ),
      ],
    );
  }

  Future<void> _openEmail(BuildContext context) async {
    _close(context);

    final uri = Uri(
      scheme: 'mailto',
      path: _supportEmail,
      queryParameters: {
        'subject': _supportEmailSubject,
      },
    );

    getIt<Talker>().info('Opening email: $uri');
    try {
      final opened = await launchUrl(uri, mode: LaunchMode.externalApplication);
      getIt<Talker>().info('Email opened: $opened');

      if (!opened) {
        getIt<Talker>().info('Mail app not available, trying Gmail web');
        final gmailUri = Uri.https('mail.google.com', '/mail/u/0/', {
          'to': _supportEmail,
          'subject': _supportEmailSubject,
        });
        await launchUrl(gmailUri, mode: LaunchMode.externalApplication);
      }
    } on Exception catch (e) {
      getIt<Talker>().error('Error opening email: $e');
    }
  }

  Future<void> _openTelegram(BuildContext context) async {
    _close(context);

    final deepLinkUri = Uri.parse(_supportTelegramDeepLink);
    final opened = await launchUrl(
      deepLinkUri,
      mode: LaunchMode.externalApplication,
    );

    if (opened) {
      return;
    }

    final webUri = Uri.parse(_supportTelegram);
    await launchUrl(webUri, mode: LaunchMode.externalApplication);
  }

  void _close(BuildContext context) {
    Navigator.of(context).pop();
  }
}
