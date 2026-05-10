import 'package:anekdots_b/core/services/anekdot/models/anekdots.dart';
import 'package:anekdots_b/feathures/generate%20anekdot/bloc/generate_anekdot_bloc.dart';
import 'package:anekdots_b/ui/theme/app_theme_tokens.dart';
import 'package:anekdots_b/ui/theme/theme.dart';
import 'package:anekdots_b/ui/widgets/bottom%20sheet/base_bottom_sheet.dart';
import 'package:anekdots_b/ui/widgets/bottom%20sheet/bottom_sheet_android_buttons.dart';
import 'package:anekdots_b/ui/widgets/bottom%20sheet/bottom_sheet_cupertino_buttons.dart';
import 'package:anekdots_b/ui/widgets/bottom%20sheet/cupertino_handle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnekdotBottomSheet extends StatefulWidget {
  const AnekdotBottomSheet({
    required this.anekdot,
    super.key,
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
  bool? _favoriteOverride;

  void _onTapFavorite(bool currentIsFavorite) {
    setState(() {
      _favoriteOverride = !currentIsFavorite;
    });

    widget.onTapFavorite?.call();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BaseBottomSheet(
      child: Padding(
        padding: theme.isAndroid
            ? EdgeInsets.symmetric(
                horizontal: AppThemeTokens.paddingMedium.left,
                vertical: 16,
              )
            : EdgeInsets.symmetric(
                horizontal: AppThemeTokens.paddingMedium.left,
              ).copyWith(bottom: 16),
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
            SizedBox(height: AppThemeTokens.marginBottomSmall.bottom),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: AppThemeTokens.marginBottomLarge.bottom,
                    right: AppThemeTokens.paddingSmall.right,
                    left: AppThemeTokens.paddingSmall.left,
                  ),
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
            if (widget.anekdot.isError)
              const SizedBox.shrink()
            else
              BlocBuilder<GenerateAnekdotBloc, GenerateAnekdotState>(
                builder: (context, state) {
                  final isFavoriteFromGenerateState =
                      state is GenerateAnekdotLoaded &&
                      state.isFavorite(widget.anekdot.anekdotText);
                  final baseIsFavorite =
                      widget.initialIsFavorite || isFavoriteFromGenerateState;
                  final isFavorite = _favoriteOverride ?? baseIsFavorite;
                  final shouldShowActions = !widget.anekdot.isError;
                  if (theme.isAndroid) {
                    return BottomSheetAndroidButtons(
                      onTapFavorite: shouldShowActions
                          ? () => _onTapFavorite(isFavorite)
                          : null,
                      onTapShare: shouldShowActions ? widget.onTapShare : null,
                      onTapEdit: widget.onTapEdit,
                      isFavorite: isFavorite,
                    );
                  }
                  return BottomSheetCupertinoButtons(
                    onTapFavorite: shouldShowActions
                        ? () => _onTapFavorite(isFavorite)
                        : null,
                    onTapShare: shouldShowActions ? widget.onTapShare : null,
                    onTapEdit: widget.onTapEdit,
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
