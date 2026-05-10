import 'package:anekdots_b/repositories/favorites/model/favorite_anekdots.dart';
import 'package:anekdots_b/repositories/local_anekdots/model/local_anekdot.dart';
import 'package:hive_ce/hive_ce.dart';

@GenerateAdapters([
  AdapterSpec<FavoriteAnekdots>(),
  AdapterSpec<LocalAnekdot>(),
])
part 'hive_adapters.g.dart';
