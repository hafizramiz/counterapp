import 'package:flutter/material.dart';
import 'counter_widget.dart';

/// Counter dialog widget
class CounterDialog extends StatelessWidget {
  final String? title;
  final int initialValue;
  final void Function(int value)? onValueChanged;
  final bool showAsyncButton;
  final Color? primaryColor;

  const CounterDialog({
    Key? key,
    this.title,
    this.initialValue = 0,
    this.onValueChanged,
    this.showAsyncButton = true,
    this.primaryColor,
  }) : super(key: key);

  /// Show counter dialog
  static Future<int?> show(
    BuildContext context, {
    String? title,
    int initialValue = 0,
    bool showAsyncButton = true,
    Color? primaryColor,
  }) async {
    int? result;
    
    await showDialog<int>(
      context: context,
      builder: (context) => CounterDialog(
        title: title ?? 'Counter',
        initialValue: initialValue,
        showAsyncButton: showAsyncButton,
        primaryColor: primaryColor,
        onValueChanged: (value) {
          result = value;
        },
      ),
    );
    
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = this.primaryColor ?? theme.primaryColor;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Dialog title
            if (title != null) ...[
              Text(
                title!,
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
            ],
            
            // Counter widget
            CounterWidget(
              title: title,
              initialValue: initialValue,
              onValueChanged: onValueChanged,
              showAsyncButton: showAsyncButton,
              primaryColor: primaryColor,
              backgroundColor: Colors.transparent,
              onCounterTen: (){},
            ),
            
            const SizedBox(height: 24),
            
            // Action buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('OK'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
