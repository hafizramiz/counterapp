/// Counter state model
class CounterState {
  final int value;
  final String title;
  final bool isLoading;
  final String? errorMessage;

  const CounterState({
    required this.value,
    this.title = 'Counter',
    this.isLoading = false,
    this.errorMessage,
  });

  CounterState copyWith({
    int? value,
    String? title,
    bool? isLoading,
    String? errorMessage,
  }) {
    return CounterState(
      value: value ?? this.value,
      title: title ?? this.title,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  String toString() {
    return 'CounterState(value: $value, title: $title, isLoading: $isLoading, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CounterState &&
        other.value == value &&
        other.title == title &&
        other.isLoading == isLoading &&
        other.errorMessage == errorMessage;
  }

  @override
  int get hashCode {
    return value.hashCode ^
        title.hashCode ^
        isLoading.hashCode ^
        errorMessage.hashCode;
  }
}
