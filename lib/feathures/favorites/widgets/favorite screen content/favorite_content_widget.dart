import 'package:category_b/core/services/toggle_favorite_func.dart';
import 'package:category_b/feathures/favorites/widgets/anekdot_list_card.dart';
import 'package:category_b/repositories/favorites/model/favorite_anekdots.dart';
import 'package:category_b/ui/widgets/bottom%20sheet/show_anekdot_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';

class FavoriteContentWidget extends StatelessWidget {
  const FavoriteContentWidget({super.key, required this.list});

  final List<FavoriteAnekdots> list;

  @override
  Widget build(BuildContext context) {
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
}
