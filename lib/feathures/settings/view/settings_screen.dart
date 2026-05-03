import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:category_b/app/cubit/notifications/notifications_cubit.dart';
import 'package:category_b/app/cubit/theme/theme_cubit.dart';
import 'package:category_b/core/services/show_message_service.dart';
import 'package:category_b/core/texts/app_texts.dart';
import 'package:category_b/feathures/favorites/bloc/favorite_anekdots_bloc.dart';
import 'package:category_b/feathures/settings/widgets/confirmation_dialog.dart';
import 'package:category_b/feathures/settings/widgets/settings_action__card.dart';
import 'package:category_b/feathures/settings/widgets/settings_toggle_card.dart';
import 'package:category_b/feathures/settings/widgets/support_bottom_sheet.dart';
import 'package:category_b/ui/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkTheme = context.watch<ThemeCubit>().state.isDark;
    final isEnabled = context.watch<NotificationsCubit>().state.enabled;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            snap: true,
            floating: true,
            scrolledUnderElevation: 0,
            backgroundColor: theme.cardColor,
            surfaceTintColor: Colors.transparent,
            title: const Text(AppTexts.settingsScreenTitle),
            centerTitle: true,
            elevation: 0,
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 16)),

          SliverToBoxAdapter(
            child: SettingsToggleCard(
              title: AppTexts.settingsThemeToggleTitle,
              value: isDarkTheme,
              onChanged: (value) => _setThemeBrightness(context, value),
            ),
          ),

          SliverToBoxAdapter(
            child: SettingsToggleCard(
              title: AppTexts.settingsNotificationsToggleTitle,
              value: isEnabled,
              onChanged: (value) => _toggleNotifications(context, value),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 16)),

          SliverToBoxAdapter(
            child: SettingsActionCard(
              title: AppTexts.settingsClearFavoritesTitle,
              iconData: Icons.delete_outline,
              iconColor: theme.primaryColor.withValues(alpha: 0.9),
              onTap: () => _confirmClearFavorites(context),
            ),
          ),

          SliverToBoxAdapter(
            child: SettingsActionCard(
              title: AppTexts.settingsSupportTitle,
              iconData: Icons.message_outlined,
              onTap: () => _showSupportSheet(context),
            ),
          ),
        ],
      ),
    );
  }

  void _toggleNotifications(BuildContext context, bool value) {
    context.read<NotificationsCubit>().toggle(value: value);
  }
}

void _setThemeBrightness(BuildContext context, bool value) {
  context.read<ThemeCubit>().setThemeBrightness(
    value ? Brightness.dark : Brightness.light,
  );
}

void _showSupportSheet(BuildContext context) {
  final theme = Theme.of(context);

  if (theme.isAndroid) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: theme.cardColor,
      builder: (context) => const SupportBottomSheet(),
    );
    return;
  }
  showCupertinoModalPopup<void>(
    context: context,
    builder: (context) => const SupportBottomSheet(),
  );
}

void _confirmClearFavorites(BuildContext context) {
  final theme = Theme.of(context);

  if (theme.isAndroid) {
    showDialog<void>(
      context: context,
      builder: (context) =>
          ConfirmationDialog(onConfirm: () => clearFavorites(context)),
    );
    return;
  }
  showCupertinoDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (context) =>
        ConfirmationDialog(onConfirm: () => clearFavorites(context)),
  );
}

Future<void> clearFavorites(BuildContext context) async {
  final bloc = BlocProvider.of<FavoriteAnekdotsBloc>(context);
  final completer = Completer<void>();

  bloc.add(ClearFavoriteAnekdots(completer: completer));

  try {
    await completer.future;

    if (context.mounted) {
      showMessage(context, AppTexts.settingsClearFavoritesSuccess);
    }
  } on Object catch (e) {
    if (context.mounted) {
      showMessage(
        context,
        '${AppTexts.settingsClearFavoritesErrorPrefix}$e',
        isError: true,
      );
    }
  }
}
