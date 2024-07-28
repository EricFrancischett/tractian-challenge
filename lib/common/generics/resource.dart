import 'package:tractian_challenge/common/generics/status.dart';

class Resource<T, E> {
  T? data;
  E? error;
  Status? status;

  Resource({
    this.data,
    this.error,
    this.status,
  });

  bool get hasError => error != null;
  bool get isLoading => status == Status.loading;

  Resource.success({this.data, this.error, this.status = Status.success});

  Resource.failed({this.data, this.error, this.status = Status.failed});

  Resource.loading({this.data, this.error, this.status = Status.loading});

  Resource<T, E> copyWith({
    T? data,
    E? error,
    Status? status,
    int? code,
  }) {
    return Resource<T, E>(
      data: data ?? this.data,
      error: error ?? this.error,
      status: status ?? this.status,
    );
  }
}
