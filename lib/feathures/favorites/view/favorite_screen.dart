import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:category_b/feathures/favorites/bloc/favorite_anekdots_bloc.dart';
import 'package:category_b/feathures/favorites/widgets/add%20anekdot%20buttons/add_anekdot_android_button.dart';
import 'package:category_b/feathures/favorites/widgets/add%20anekdot%20buttons/add_anekdot_cupertino_button.dart';
import 'package:category_b/feathures/favorites/widgets/custom_search_bar.dart';
import 'package:category_b/feathures/favorites/widgets/favorite%20screen%20content/empty_favorites_widget.dart';
import 'package:category_b/feathures/favorites/widgets/favorite%20screen%20content/favorite_content_widget.dart';
import 'package:category_b/ui/theme/theme.dart';
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

  void _unfocus(BuildContext context) {
    FocusScope.of(context).unfocus();
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
    _unfocus(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      floatingActionButton: theme.isAndroid ? AddAnekdotAndroidButton() : null,
      body: GestureDetector(
        onTap: () => _unfocus(context),
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
              actions: [
                if (!theme.isAndroid) const AddAnekdotCupertinoButton(),
              ],
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
                    return EmptyFavoritesWidget(message: message);
                  }

                  return FavoriteContentWidget(list: list);
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
