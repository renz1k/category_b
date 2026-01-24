import 'package:auto_route/auto_route.dart';
import 'package:category_b/core/services/show_anekdot_bottom_sheet.dart';
import 'package:category_b/feathures/favorite/widgets/anekdot_list_card.dart';
import 'package:flutter/material.dart';

@RoutePage()
class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

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

          SliverList.builder(
            itemCount: 100,
            itemBuilder: (context, index) {
              final anekdotText =
                  'анекдот №$index — тут будет реальный текст реально бля ууу сука да давай дри меня сучка по бошке тапориком ману на топор';
              return AnekdotListCard(
                anekdot: anekdotText,
                isFovorite: true,
                onTap: () {
                  showAnekdotBottomSheet(
                    context: context,
                    anekdotText: anekdotText,
                    isFavorite: true,
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
