import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            snap: true,
            floating: true,
            scrolledUnderElevation: 0,
            // backgroundColor: theme.cardColor,
            surfaceTintColor: Colors.transparent,
            title: Text('Favorite'),
            centerTitle: true,
            elevation: 0,
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
          SliverList.builder(
            itemCount: 100,
            itemBuilder: (context, index) => Text('anekdot $index'),
          ),
        ],
      ),
    );
  }
}
