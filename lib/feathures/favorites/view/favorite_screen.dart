import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:category_b/core/services/show_anekdot_bottom_sheet.dart';
import 'package:category_b/core/services/toggle_favorite_func.dart';
import 'package:category_b/feathures/favorites/bloc/favorite_anekdots_bloc.dart';
import 'package:category_b/feathures/favorites/widgets/anekdot_list_card.dart';
import 'package:category_b/feathures/favorites/widgets/custom_search_bar.dart';
import 'package:category_b/feathures/generate%20anekdot/bloc/generate_anekdot_bloc.dart';
import 'package:category_b/ui/widgets/add_or_update_anekdot_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    BlocProvider.of<FavoriteAnekdotsBloc>(context).add(LoadFavoriteAnekdots());
    super.initState();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 150), () {
      BlocProvider.of<FavoriteAnekdotsBloc>(
        context,
      ).add(SearchQueryChanged(query));
    });
  }

  void _clearSearch() {
    _searchController.clear();
    _onSearchChanged('');
    FocusScope.of(context).unfocus();
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
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: CustomScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          slivers: [
            SliverAppBar(
              snap: true,
              floating: true,
              pinned: true,
              scrolledUnderElevation: 0,
              backgroundColor: theme.cardColor,
              surfaceTintColor: Colors.transparent,
              title: const Text('Избранное'),
              centerTitle: true,
            ),

            SliverToBoxAdapter(
              child: CustomSearchBar(
                controller: _searchController,
                onChanged: _onSearchChanged,
                onClear: _clearSearch,
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 8)),

            BlocBuilder<FavoriteAnekdotsBloc, FavoriteAnekdotsState>(
              builder: (context, state) {
                if (state is FavoriteAnekdotsLoaded) {
                  final list = state.filteredAnekdots;

                  if (list.isEmpty) {
                    final message = state.searchQuery.isNotEmpty
                        ? 'Ничего не найдено'
                        : 'Избранных анекдотов нет';

                    return SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: Text(
                          message,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: theme.hintColor,
                          ),
                        ),
                      ),
                    );
                  }

                  return SliverList.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      final favoriteAnekdot = list[index];
                      return AnekdotListCard(
                        isFovorite: true,
                        anekdotText: favoriteAnekdot.anekdotText,
                        onTapCard: () {
                          FocusScope.of(context).unfocus();
                          showAnekdotBottomSheet(
                            context: context,
                            anekdot: favoriteAnekdot.toAnekdot(),
                            isFavorite: true,
                            dbId: favoriteAnekdot.id,
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
                  child: Center(child: CircularProgressIndicator()),
                );
              },
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 80)),
          ],
        ),
      ),
    );
  }
}

void _showAddDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (dialogContext) => AddOrUpdateAnekdotDialog(
      onAddOrUpdate: (text) =>
          _onPressedAddAnekdot(context, dialogContext, text),
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

    BlocProvider.of<GenerateAnekdotBloc>(context).add(FavoritesListDirty());

    Navigator.of(dialogContext).pop();

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Анекдот добавлен!')));
  }
}
