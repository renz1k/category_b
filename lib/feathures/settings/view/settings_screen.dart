import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:category_b/feathures/favorites/bloc/favorite_anekdots_bloc.dart';
import 'package:category_b/feathures/settings/widgets/settings_action__card.dart';
import 'package:category_b/feathures/settings/widgets/settings_toggle_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            snap: true,
            floating: true,
            scrolledUnderElevation: 0,
            backgroundColor: theme.cardColor,
            surfaceTintColor: Colors.transparent,
            title: const Text('Settings'),
            centerTitle: true,
            elevation: 0,
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 16)),

          SliverToBoxAdapter(
            child: SettingsToggleCard(
              title: 'Dark theme',
              value: false,
              onChanged: (value) {},
            ),
          ),

          SliverToBoxAdapter(
            child: SettingsToggleCard(
              title: 'Notifications',
              value: false,
              onChanged: (value) {},
            ),
          ),

          SliverToBoxAdapter(
            child: SettingsToggleCard(
              title: 'Allow analytics',
              value: true,
              onChanged: (value) {},
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 16)),

          SliverToBoxAdapter(
            child: SettingsActionCard(
              title: 'Clean favorites',
              iconData: Icons.delete_sweep_outlined,
              iconColor: theme.primaryColor,
              onTap: () => _clearFavorites(context),
            ),
          ),

          SliverToBoxAdapter(
            child: SettingsActionCard(
              title: 'Write to support',
              iconData: Icons.message_outlined,
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> _clearFavorites(BuildContext context) async {
  final bloc = BlocProvider.of<FavoriteAnekdotsBloc>(context);
  final completer = Completer();

  bloc.add(ClearFavoriteAnekdots(completer: completer));

  try {
    await completer.future;

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Избранное успешно очищено!'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.green,
        ),
      );
    }
  } catch (e) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Ошибка очистки: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
