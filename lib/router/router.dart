import 'package:auto_route/auto_route.dart';
import 'package:category_b/feathures/favorite/view/favorite_screen.dart';
import 'package:category_b/feathures/generate%20anekdot/view/generate_anekdot_screen.dart';
import 'package:category_b/feathures/home/view/home_screen.dart';
import 'package:category_b/feathures/settings/view/settings_screen.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: HomeRoute.page,
      path: '/',
      children: [
        AutoRoute(page: GenerateAnekdotRoute.page, path: 'generate anek'),
        AutoRoute(page: FavoriteRoute.page, path: 'favorite'),
        AutoRoute(page: SettingsRoute.page, path: 'settings'),
      ],
    ),
  ];
}
