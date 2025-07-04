import 'package:flutter/foundation.dart';
import '../models/counter_state.dart';

/// Counter controller with state management
class CounterController extends ChangeNotifier {
  CounterState _state = const CounterState(value: 0);
  
  CounterState get state => _state;
  
  int get value => _state.value;
  String get title => _state.title;
  bool get isLoading => _state.isLoading;
  String? get errorMessage => _state.errorMessage;
  
  /// Increment counter by 1
  void increment() {
    _updateState(_state.copyWith(value: _state.value + 1));
  }
  
  /// Decrement counter by 1
  void decrement() {
    _updateState(_state.copyWith(value: _state.value - 1));
  }
  
  /// Reset counter to 0
  void reset() {
    _updateState(_state.copyWith(value: 0));
  }
  
  /// Set counter to specific value
  void setValue(int value) {
    _updateState(_state.copyWith(value: value));
  }
  
  /// Set counter title
  void setTitle(String title) {
    _updateState(_state.copyWith(title: title));
  }
  
  /// Simulate async operation
  Future<void> incrementAsync() async {
    _updateState(_state.copyWith(isLoading: true));
    
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      _updateState(_state.copyWith(
        value: _state.value + 1,
        isLoading: false,
      ));
    } catch (e) {
      _updateState(_state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to increment: $e',
      ));
    }
  }
  
  /// Clear error message
  void clearError() {
    _updateState(_state.copyWith(errorMessage: null));
  }
  
  void _updateState(CounterState newState) {
    _state = newState;
    notifyListeners();
  }
}
