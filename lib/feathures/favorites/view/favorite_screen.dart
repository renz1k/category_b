import 'package:auto_route/auto_route.dart';
import 'package:category_b/core/services/show_anekdot_bottom_sheet.dart';
import 'package:category_b/feathures/favorites/bloc/favorite_anekdots_bloc.dart';
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
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            snap: true,
            floating: true,
            scrolledUnderElevation: 0,
            backgroundColor: theme.cardColor,
            surfaceTintColor: Colors.transparent,
            title: Text('Favorite'),
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
                      onTap: () {
                        showAnekdotBottomSheet(
                          context: context,
                          anekdot: favoriteAnekdot.toAnekdot(),
                          isFavorite: true,
                        );
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
