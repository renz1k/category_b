import 'package:auto_route/auto_route.dart';
import 'package:category_b/router/router.dart';
import 'package:flutter/material.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: [GenerateAnekdotRoute(), FavoriteRoute(), SettingsRoute()],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          body: child,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: tabsRouter.activeIndex,
            onTap: (index) => _onTap(index, tabsRouter),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'main.html',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_rounded),
                label: 'ОЧ нраица',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Настроики',
              ),
            ],
          ),
        );
      },
    );
  }
}

void _onTap(int index, TabsRouter tabsRouter) {
  tabsRouter.setActiveIndex(index);
}
