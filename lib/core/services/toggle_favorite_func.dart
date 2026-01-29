import 'dart:async';

import 'package:category_b/core/services/anekdot/models/anekdots.dart';
import 'package:category_b/feathures/favorites/bloc/favorite_anekdots_bloc.dart';
import 'package:category_b/feathures/generate%20anekdot/bloc/generate_anekdot_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> toggleFavorite(BuildContext context, Anekdot anekdot) async {
  final generateAnekdotBloc = BlocProvider.of<GenerateAnekdotBloc>(context);
  final favoriteAnekdotsBloc = BlocProvider.of<FavoriteAnekdotsBloc>(context);
  final completer = Completer();

  generateAnekdotBloc.add(
    ToggleFavoriteAnekdot(anekdot: anekdot, completer: completer),
  );
  await completer.future;
  favoriteAnekdotsBloc.add(LoadFavoriteAnekdots());
}
