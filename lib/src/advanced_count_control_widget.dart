import 'package:flutter/material.dart';
import 'count_control_style.dart';

class AdvancedCountControl extends StatelessWidget {
  // ─── Data ───
  final int currentQuantity;
  final int maxQuantity;
  final bool isLoading;
  final bool isDisabled;

  // ─── Configuration ───
  final bool showAddButton;
  final String addButtonLabel;
  final String maxReachedLabel;
  final double height;
  final double? width;

  // ─── Custom Icons  ───
  final IconData? iconAdd;
  final IconData? iconRemove;
  final IconData? iconTrash;

  // ─── Actions ───
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;
  final VoidCallback? onAddTap;

  // ─── Styling ───
  final CountControlStyle style;
  final String Function(String)? numberFormatter;

  const AdvancedCountControl({
    super.key,
    required this.currentQuantity,
    required this.onIncrease,
    required this.onDecrease,
    this.maxQuantity = 999,
    this.isLoading = false,
    this.isDisabled = false,
    this.showAddButton = true,
    this.addButtonLabel = "افزودن به سبد خرید",
    this.maxReachedLabel = "حداکثر",
    this.height = 48,
    this.width = double.infinity,

    this.iconAdd,
    this.iconRemove,
    this.iconTrash,

    this.onAddTap,
    this.style = const CountControlStyle(),
    this.numberFormatter,
  }):  assert(maxQuantity >= currentQuantity, 'max quantity[$maxQuantity] must be equal or higher than current[$currentQuantity]');

  @override
  Widget build(BuildContext context) {
    final bool isAddMode = showAddButton && currentQuantity == 0;

    return SizedBox(
      height: height,
      width: width,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(opacity: animation, child: child);
        },
        child: isAddMode ? _buildAddButton() : _buildCounter(),
      ),
    );
  }

  Widget _buildAddButton() {
    return SizedBox(
      key: const ValueKey('addButton'),
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: (isDisabled || isLoading) ? null : (onAddTap ?? onIncrease),
        style: ElevatedButton.styleFrom(
          backgroundColor: isDisabled ? style.disabledColor : style.primaryColor,
          foregroundColor: Colors.white,
          disabledBackgroundColor: style.disabledColor,
          disabledForegroundColor: Colors.white,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(style.borderRadius),
          ),
          padding: EdgeInsets.zero,
        ),
        child: isLoading
            ? const SizedBox(
            width: 20, height: 20,
            child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
            : Text(addButtonLabel, style: style.btnTextStyle),
      ),
    );
  }

  Widget _buildCounter() {
    final bool isMaxReached = currentQuantity >= maxQuantity;
    final bool isTrashMode = currentQuantity == 1;

    return Container(
      key: const ValueKey('counterControl'),
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: style.backgroundColor,
        borderRadius: BorderRadius.circular(style.borderRadius),
        border: style.borderSide != null ? Border.fromBorderSide(style.borderSide!) : null,
        boxShadow: style.shadows,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          _CounterIconButton(
            key: const ValueKey('increaseButton'),
            icon: iconAdd ?? Icons.add,
            onTap: (isMaxReached || isDisabled) ? null : onIncrease,
            color: (isMaxReached || isDisabled) ? style.disabledColor : style.primaryColor,
          ),

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Text(
                      _formatNumber(currentQuantity),
                      style: style.textStyle.copyWith(
                        color: isDisabled ? style.disabledColor : style.contentColor,
                        height: 1.0,
                      ),
                      maxLines: 1,
                    ),
                  ),
                ),
                if (isMaxReached && !isDisabled)
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      maxReachedLabel,
                      style: style.textStyle.copyWith(fontSize: 10, color: Colors.grey),
                      maxLines: 1,
                    ),
                  ),
              ],
            ),
          ),

          _CounterIconButton(
            key: const ValueKey('decreaseButton'),
            icon: isTrashMode
                ? (iconTrash ?? Icons.delete_outline_rounded)
                : (iconRemove ?? Icons.remove),
            onTap: isDisabled ? null : onDecrease,
            color: isDisabled ? style.disabledColor : style.contentColor,
            iconSize: isTrashMode ? 20 : 24,
          ),
        ],
      ),
    );
  }

  String _formatNumber(int number) {
    if (numberFormatter != null) {
      return numberFormatter!(number.toString());
    }
    return number.toString();
  }
}

class _CounterIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final Color color;
  final double iconSize;

  const _CounterIconButton({
    super.key,
    required this.icon,
    required this.color,
    this.onTap,
    this.iconSize = 24,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: SizedBox(
          width: 48,
          height: double.infinity,
          child: Icon(icon, color: color, size: iconSize),
        ),
      ),
    );
  }
}