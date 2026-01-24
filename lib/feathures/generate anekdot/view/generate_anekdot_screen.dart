import 'package:auto_route/auto_route.dart';
import 'package:category_b/core/services/show_anekdot_bottom_sheet.dart';
import 'package:category_b/feathures/generate%20anekdot/widgets/generate_anekdot_button.dart';
import 'package:flutter/material.dart';

@RoutePage()
class GenerateAnekdotScreen extends StatelessWidget {
  const GenerateAnekdotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.cardColor,
        title: Text('Category B'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: GenerateAnekdotButton(
            text: 'Рандомный анек',
            onPressed: () => showAnekdotBottomSheet(
              context: context,
              anekdotText: 'походу с анекдотами',
            ),
            icon: Icons.auto_stories,
          ),
        ),
      ),
    );
  }
}
