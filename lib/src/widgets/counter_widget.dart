import 'package:flutter/material.dart';
import '../controllers/counter_controller.dart';

/// Main counter widget
class CounterWidget extends StatefulWidget {
  final String? title;
  final int initialValue;
  final void Function(int value)? onValueChanged;
  final void Function()? onCounterTen; // New callback for when counter reaches 10
  final bool showAsyncButton;
  final Color? primaryColor;
  final Color? backgroundColor;

  const CounterWidget({
    Key? key,
    this.title,
    this.initialValue = 0,
    this.onValueChanged,
    this.onCounterTen, // Added to constructor
    this.showAsyncButton = false,
    this.primaryColor,
    this.backgroundColor,
  }) : super(key: key);

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  late CounterController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CounterController();
    _controller.setValue(widget.initialValue);
    if (widget.title != null) {
      _controller.setTitle(widget.title!);
    }
    _controller.addListener(_onCounterChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_onCounterChanged);
    _controller.dispose();
    super.dispose();
  }

  void _onCounterChanged() {
    if (widget.onValueChanged != null) {
      widget.onValueChanged!(_controller.value);
    }
    // Trigger callback when counter reaches 10
    if (_controller.value == 10 && widget.onCounterTen != null) {
      widget.onCounterTen!();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = widget.primaryColor ?? theme.primaryColor;
    final backgroundColor = widget.backgroundColor ?? theme.scaffoldBackgroundColor;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: primaryColor.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Title
          Text(
            _controller.title,
            style: theme.textTheme.headlineSmall?.copyWith(
              color: primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          // Counter display
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              if (_controller.isLoading) {
                return const CircularProgressIndicator();
              }

              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '${_controller.value}',
                  style: theme.textTheme.displayMedium?.copyWith(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 16),

          // Error message
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              if (_controller.errorMessage != null) {
                return Container(
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.error, color: Colors.red, size: 16),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _controller.errorMessage!,
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, size: 16),
                        onPressed: _controller.clearError,
                        color: Colors.red,
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),

          // Control buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FloatingActionButton(
                heroTag: 'reset',
                onPressed: _controller.reset,
                backgroundColor: Colors.grey,
                child: const Icon(Icons.refresh),
              ),
              FloatingActionButton(
                heroTag: 'increment',
                onPressed: _controller.increment,
                backgroundColor: primaryColor,
                child: const Icon(Icons.add),
              ),
            ],
          ),

          // Async button
          if (widget.showAsyncButton) ...[
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _controller.incrementAsync,
              icon: const Icon(Icons.sync),
              label: const Text('Cok yeni bir commit attim'),
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ],
      ),
    );
  }
}