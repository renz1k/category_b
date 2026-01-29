import 'package:auto_route/auto_route.dart';
import 'package:category_b/feathures/settings/widgets/settings_action__card.dart';
import 'package:category_b/feathures/settings/widgets/settings_toggle_card.dart';
import 'package:flutter/material.dart';

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
              onTap: () {},
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
