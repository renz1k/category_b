import 'package:category_b/core/services/anekdot/models/anekdots.dart';
import 'package:category_b/feathures/generate%20anekdot/bloc/generate_anekdot_bloc.dart';
import 'package:category_b/ui/widgets/base_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnekdotBottomSheet extends StatefulWidget {
  const AnekdotBottomSheet({
    super.key,
    required this.anekdot,
    this.onTapFavorite,
    this.onTapCopy,
    this.onTapEdit,
    this.initialIsFavorite = false,
  });

  final Anekdot anekdot;
  final VoidCallback? onTapFavorite;
  final VoidCallback? onTapCopy;
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
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Divider(height: 1),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 24, right: 8, left: 8),
                  child: Text(
                    widget.anekdot.anekdotText,
                    style: theme.textTheme.bodyLarge?.copyWith(
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
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      onPressed: widget.onTapCopy,
                      icon: Icon(
                        Icons.ios_share,
                        size: 32,
                        color: theme.hintColor.withValues(alpha: 0.4),
                      ),
                      tooltip: 'Поделиться',
                    ),
                    if (widget.onTapEdit != null)
                      IconButton(
                        onPressed: widget.onTapEdit,
                        icon: Icon(
                          Icons.edit,
                          size: 32,
                          color: theme.hintColor.withValues(alpha: 0.4),
                        ),
                        tooltip: 'Редактировать',
                      ),
                    IconButton(
                      onPressed: widget.onTapFavorite,
                      icon: Icon(
                        Icons.favorite,
                        size: 32,
                        color: isFavorite
                            ? theme.primaryColor
                            : theme.hintColor.withValues(alpha: 0.4),
                      ),
                      tooltip: 'В избранное',
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
