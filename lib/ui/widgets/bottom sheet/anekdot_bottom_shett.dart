import 'package:category_b/core/services/anekdot/models/anekdots.dart';
import 'package:category_b/feathures/generate%20anekdot/bloc/generate_anekdot_bloc.dart';
import 'package:category_b/ui/theme/theme.dart';
import 'package:category_b/ui/widgets/bottom%20sheet/base_bottom_sheet.dart';
import 'package:category_b/ui/widgets/bottom%20sheet/bottom_sheet_android_buttons.dart';
import 'package:category_b/ui/widgets/bottom%20sheet/bottom_sheet_cupertino_buttons.dart';
import 'package:category_b/ui/widgets/bottom%20sheet/cupertino_handle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnekdotBottomSheet extends StatefulWidget {
  const AnekdotBottomSheet({
    super.key,
    required this.anekdot,
    this.onTapFavorite,
    this.onTapShare,
    this.onTapEdit,
    this.initialIsFavorite = false,
  });

  final Anekdot anekdot;
  final VoidCallback? onTapFavorite;
  final VoidCallback? onTapShare;
  final VoidCallback? onTapEdit;
  final bool initialIsFavorite;

  @override
  State<AnekdotBottomSheet> createState() => _AnekdotBottomSheetState();
}

class _AnekdotBottomSheetState extends State<AnekdotBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BaseBottomSheet(
      child: Padding(
        padding: theme.isAndroid
            ? EdgeInsets.symmetric(horizontal: 12, vertical: 16)
            : EdgeInsets.symmetric(horizontal: 12).copyWith(bottom: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: theme.isAndroid
                  ? const SizedBox(
                      height: 1,
                      width: double.infinity,
                      child: Divider(),
                    )
                  : const CupertinoHandle(),
            ),
            SizedBox(height: 8),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 24, right: 8, left: 8),
                  child: Text(
                    widget.anekdot.anekdotText,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                      height: 1.6,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            BlocBuilder<GenerateAnekdotBloc, GenerateAnekdotState>(
              builder: (context, state) {
                final isFavorite = state is GenerateAnekdotLoaded
                    ? state.isFavorite(widget.anekdot.anekdotText)
                    : widget.initialIsFavorite;
                if (theme.isAndroid) {
                  return BottomSheetAndroidButtons(
                    widget: widget,
                    isFavorite: isFavorite,
                  );
                }
                return BottomSheetCupertinoButtons(
                  widget: widget,
                  isFavorite: isFavorite,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
