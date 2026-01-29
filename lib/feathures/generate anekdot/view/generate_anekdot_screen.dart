import 'package:auto_route/auto_route.dart';
import 'package:category_b/core/services/show_anekdot_bottom_sheet.dart';
import 'package:category_b/feathures/generate%20anekdot/bloc/generate_anekdot_bloc.dart';
import 'package:category_b/feathures/generate%20anekdot/widgets/generate_anekdot_button.dart';
import 'package:category_b/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class GenerateAnekdotScreen extends StatefulWidget {
  const GenerateAnekdotScreen({super.key});

  @override
  State<GenerateAnekdotScreen> createState() => _GenerateAnekdotScreenState();
}

class _GenerateAnekdotScreenState extends State<GenerateAnekdotScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bloc = BlocProvider.of<GenerateAnekdotBloc>(context);
    bool isBottomSheetOpen = false;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.cardColor,
        title: const Text('Category B'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: BlocConsumer<GenerateAnekdotBloc, GenerateAnekdotState>(
            listenWhen: (prev, curr) => _listenWhenGenerateAnekdot(
              context,
              isBottomSheetOpen,
              curr,
              prev,
            ),
            listener: (context, state) async {
              if (state is GenerateAnekdotLoaded) {
                isBottomSheetOpen = true;
                final anekdot = state.anekdot;
                await showAnekdotBottomSheet(
                  context: context,
                  anekdot: anekdot,
                  isFavorite: state.isFavorite(anekdot.anekdotText),
                );
                if (mounted) {
                  isBottomSheetOpen = false;
                }
              }
            },
            builder: (context, state) {
              if (state is GenerateAnekdotLoading) {
                return Center(child: CircularProgressIndicator());
              }
              return GenerateAnekdotButton(
                text: 'Рандомный анек',
                onPressed: () => bloc.add(GenerateRandomAnekdot()),
                icon: Icons.auto_stories,
              );
            },
          ),
        ),
      ),
    );
  }

  bool _listenWhenGenerateAnekdot(
    BuildContext context,
    bool isBottomSheetOpen,
    GenerateAnekdotState curr,
    GenerateAnekdotState prev,
  ) {
    final tabsRouter = AutoTabsRouter.of(context, watch: false);

    if (tabsRouter.current.name != GenerateAnekdotRoute.name) {
      return false;
    }

    if (isBottomSheetOpen) return false;

    if (curr is! GenerateAnekdotLoaded) return false;

    if (prev is GenerateAnekdotLoaded) {
      return prev.anekdot.anekdotText != curr.anekdot.anekdotText;
    }

    return true;
  }
}
