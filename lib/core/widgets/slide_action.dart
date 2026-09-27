import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

/// Slide-to-confirm control for a ride's primary action (matches the
/// reference app's swipe button, restyled for this app's black & gold
/// theme). Dragging the handle past the threshold fires [onConfirmed].
class SlideAction extends StatefulWidget {
  const SlideAction({
    super.key,
    required this.label,
    required this.onConfirmed,
    this.isLoading = false,
  });

  final String label;
  final VoidCallback onConfirmed;
  final bool isLoading;

  @override
  State<SlideAction> createState() => _SlideActionState();
}

class _SlideActionState extends State<SlideAction> {
  static const _height = 56.0;
  static const _confirmThreshold = 0.78;

  double _dragX = 0;
  bool _completed = false;

  @override
  void didUpdateWidget(covariant SlideAction oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.label != widget.label) {
      setState(() {
        _dragX = 0;
        _completed = false;
      });
    }
  }

  void _onDragUpdate(DragUpdateDetails details, double maxDrag) {
    if (_completed || widget.isLoading || maxDrag <= 0) return;
    setState(() => _dragX = (_dragX + details.delta.dx).clamp(0, maxDrag));
  }

  void _onDragEnd(DragEndDetails details, double maxDrag) {
    if (_completed || widget.isLoading || maxDrag <= 0) return;
    if (_dragX >= maxDrag * _confirmThreshold) {
      setState(() {
        _dragX = maxDrag;
        _completed = true;
      });
      widget.onConfirmed();
    } else {
      setState(() => _dragX = 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxDrag = (constraints.maxWidth - _height).clamp(0, double.infinity);
        final progress = maxDrag <= 0 ? 0.0 : _dragX / maxDrag;

        return Container(
          height: _height,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(_height / 2),
            border: Border.all(color: AppColors.gold.withValues(alpha: 0.4)),
          ),
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                width: _dragX + _height,
                decoration: BoxDecoration(
                  color: AppColors.gold.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(_height / 2),
                ),
              ),
              Center(
                child: Opacity(
                  opacity: (1 - progress).clamp(0.0, 1.0),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: _height),
                    child: Text(
                      widget.label,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.title.copyWith(color: AppColors.gold, fontWeight: FontWeight.w700),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 150),
                curve: Curves.easeOut,
                left: _dragX,
                child: GestureDetector(
                  onHorizontalDragUpdate: (d) => _onDragUpdate(d, maxDrag.toDouble()),
                  onHorizontalDragEnd: (d) => _onDragEnd(d, maxDrag.toDouble()),
                  child: Container(
                    width: _height,
                    height: _height,
                    decoration: const BoxDecoration(color: AppColors.gold, shape: BoxShape.circle),
                    child: widget.isLoading
                        ? const Padding(
                            padding: EdgeInsets.all(16),
                            child: CircularProgressIndicator(strokeWidth: 2.4, color: AppColors.background),
                          )
                        : const Icon(Icons.arrow_forward, color: AppColors.background),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
