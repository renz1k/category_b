import 'package:auto_route/auto_route.dart';
import 'package:category_b/core/services/show_anekdot_bottom_sheet.dart';
import 'package:category_b/core/services/toggle_favorite_func.dart';
import 'package:category_b/feathures/favorites/bloc/favorite_anekdots_bloc.dart';
import 'package:category_b/feathures/favorites/widgets/add_anekdot_dialog.dart';
import 'package:category_b/feathures/favorites/widgets/anekdot_list_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    BlocProvider.of<FavoriteAnekdotsBloc>(context).add(LoadFavoriteAnekdots());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddDialog(context),
        tooltip: 'Добавить свой анекдот',
        backgroundColor: theme.primaryColor,
        child: const Icon(Icons.add),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            snap: true,
            floating: true,
            scrolledUnderElevation: 0,
            backgroundColor: theme.cardColor,
            surfaceTintColor: Colors.transparent,
            title: const Text('Избранное'),
            centerTitle: true,
            elevation: 0,
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 16)),

          BlocBuilder<FavoriteAnekdotsBloc, FavoriteAnekdotsState>(
            builder: (context, state) {
              if (state is FavoriteAnekdotsLoaded) {
                return SliverList.builder(
                  itemCount: state.anekdots.length,
                  itemBuilder: (context, index) {
                    final favoriteAnekdot = state.anekdots[index];
                    return AnekdotListCard(
                      isFovorite: true,
                      anekdotText: favoriteAnekdot.anekdotText,
                      onTapCard: () {
                        showAnekdotBottomSheet(
                          context: context,
                          anekdot: favoriteAnekdot.toAnekdot(),
                          isFavorite: true,
                        );
                      },
                      onTapFavorite: () {
                        toggleFavorite(context, favoriteAnekdot.toAnekdot());
                      },
                    );
                  },
                );
              }
              return const SliverFillRemaining(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ],
      ),
    );
  }
}

void _showAddDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (dialogContext) => AddAnekdotDialog(
      onAdd: (text) => _onPressedAddAnekdot(context, dialogContext, text),
    ),
  );
}

void _onPressedAddAnekdot(
  BuildContext context,
  BuildContext dialogContext,
  String rawText,
) {
  final text = rawText.trim();

  if (text.isNotEmpty) {
    BlocProvider.of<FavoriteAnekdotsBloc>(
      context,
    ).add(AddCustomAnekdot(text: text));

    Navigator.of(dialogContext).pop();

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Анекдот добавлен!')));
  }
}
