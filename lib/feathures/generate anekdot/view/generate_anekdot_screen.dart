import 'package:auto_route/auto_route.dart';
import 'package:category_b/core/services/show_anekdot_bottom_sheet.dart';
import 'package:category_b/feathures/generate%20anekdot/bloc/generate_anekdot_bloc.dart';
import 'package:category_b/feathures/generate%20anekdot/widgets/generate_anekdot_button.dart';
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

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.cardColor,
        title: Text('Category B'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: BlocListener<GenerateAnekdotBloc, GenerateAnekdotState>(
            listener: (context, state) {
              if (state is GenerateAnekdotLoaded) {
                showAnekdotBottomSheet(
                  context: context,
                  anekdotText: state.anekdotText,
                );
              }
            },
            child: BlocBuilder<GenerateAnekdotBloc, GenerateAnekdotState>(
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
      ),
    );
  }
}
