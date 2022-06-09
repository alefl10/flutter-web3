part of 'hello_bloc.dart';

enum HelloAsyncStatus { initial, loading, success, error }

@immutable
class HelloState extends Equatable {
  const HelloState({
    this.status = HelloAsyncStatus.initial,
    this.name,
    this.txHashes = const [],
  });

  final HelloAsyncStatus status;
  final String? name;
  final List<String> txHashes;

  bool get hasData =>
      status == HelloAsyncStatus.success || name != null || txHashes.isNotEmpty;

  bool get hasError => status == HelloAsyncStatus.error;

  bool get isLoading => status == HelloAsyncStatus.loading;

  @override
  List<Object?> get props => [status, name, txHashes];

  HelloState copyWith({
    HelloAsyncStatus? status,
    String? name,
    List<String>? txHashes,
  }) {
    return HelloState(
      status: status ?? this.status,
      name: name ?? this.name,
      txHashes: txHashes ?? this.txHashes,
    );
  }
}
