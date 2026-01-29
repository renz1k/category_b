import 'dart:async';

import 'package:category_b/core/services/anekdot/models/anekdots.dart';
import 'package:category_b/feathures/favorites/bloc/favorite_anekdots_bloc.dart';
import 'package:category_b/feathures/generate%20anekdot/bloc/generate_anekdot_bloc.dart';
import 'package:category_b/feathures/generate%20anekdot/widgets/anekdot_bottom_shett.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> showAnekdotBottomSheet({
  required BuildContext context,
  required Anekdot anekdot,
  bool isFavorite = false,
}) async {
  await showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    context: context,
    builder: (context) => Padding(
      padding: const EdgeInsets.only(top: 100),
      child: AnekdotBottomSheet(
        anekdot: anekdot,
        initialIsFavorite: isFavorite,
        onTapFavorite: () => _toggleFavorite(context, anekdot),
      ),
    ),
  );
}

Future<void> _toggleFavorite(BuildContext context, Anekdot anekdot) async {
  final generateAnekdotBloc = BlocProvider.of<GenerateAnekdotBloc>(context);
  final favoriteAnekdotsBloc = BlocProvider.of<FavoriteAnekdotsBloc>(context);
  final completer = Completer();

  generateAnekdotBloc.add(
    ToggleFavoriteAnekdot(anekdot: anekdot, completer: completer),
  );
  await completer.future;
  favoriteAnekdotsBloc.add(LoadFavoriteAnekdots());
}
