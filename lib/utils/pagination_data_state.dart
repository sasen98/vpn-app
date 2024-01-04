import 'package:vpn_app/utils/data_state.dart';
import 'package:vpn_app/utils/failure.dart';

abstract class AbsPaginationState<T> extends AbsState<T> {
  final int currentPage, lastPage, totalRecord;

  const AbsPaginationState({
    required super.data,
    required super.stateStatus,
    required super.failure,
    required this.currentPage,
    required this.lastPage,
    required this.totalRecord,
  });
}

class AbsPaginationStateImpl<T> extends AbsPaginationState<T> {
  const AbsPaginationStateImpl({
    required super.data,
    required super.stateStatus,
    required super.failure,
    required super.currentPage,
    required super.lastPage,
    required super.totalRecord,
  });

  AbsPaginationStateImpl<T> copyWith({
    T? data,
    Failure? failure,
    StateStatus? stateStatus,
    int? currentPage,
    lastPage,
    totalRecord,
  }) {
    return AbsPaginationStateImpl<T>(
      data: data ?? this.data,
      stateStatus: stateStatus ?? this.stateStatus,
      failure: failure ?? this.failure,
      currentPage: currentPage ?? this.currentPage,
      lastPage: lastPage ?? this.lastPage,
      totalRecord: totalRecord ?? this.totalRecord,
    );
  }

  Map<String, dynamic> toJsonWithDynamicData(
      {required List<Map<String, dynamic>> data}) {
    return {
      'data': data,
      'absNormalStatus': stateStatus.toString(),
      'failure': failure,
      'currentPage': currentPage,
      'lastPage': lastPage,
      'totalRecord': totalRecord,
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data,
      'absNormalStatus': stateStatus.toString(),
      'failure': failure,
      'currentPage': currentPage,
      'lastPage': lastPage,
      'totalRecord': totalRecord,
    };
  }

  @override
  List<Object?> get props => [
        data,
        failure,
        stateStatus,
        currentPage,
        lastPage,
        totalRecord,
      ];
}

class AbsPaginationStateRefImpl<T, R> extends AbsPaginationStateImpl<T> {
  const AbsPaginationStateRefImpl({
    T? data,
    Failure? failure,
    required StateStatus stateStatus,
    required int currentPage,
    lastPage,
    totalRecord,
  }) : super(
          stateStatus: stateStatus,
          failure: failure,
          data: data,
          lastPage: lastPage,
          currentPage: currentPage,
          totalRecord: totalRecord,
        );

  @override
  AbsPaginationStateRefImpl<T, R> copyWith({
    T? data,
    Failure? failure,
    StateStatus? stateStatus,
    int? currentPage,
    lastPage,
    totalRecord,
  }) {
    return AbsPaginationStateRefImpl(
      data: data ?? this.data,
      stateStatus: stateStatus ?? this.stateStatus,
      failure: failure ?? this.failure,
      currentPage: currentPage ?? this.currentPage,
      lastPage: lastPage ?? this.lastPage,
      totalRecord: totalRecord ?? this.totalRecord,
    );
  }

  factory AbsPaginationStateRefImpl.fromJson(
    Map<String, dynamic> json,
    Function fromJson,
  ) {
    return AbsPaginationStateRefImpl<T, R>(
      currentPage: json['currentPage'] ?? 1,
      stateStatus: StateStatus.success,
      data: json['data'] != null && json['data'] is List
          ? List.of(json['data']).isNotEmpty
              ? List.of(json['data'])
                  .where((e) => e != null)
                  .map<R>((e) => fromJson(e))
                  .toList()
              : <R>[]
          : json['data'],
      lastPage: json['lastPage'] ?? 1,
      totalRecord: json['totalRecord'] ?? 0,
      // failure: json['failure'],
    );
  }
}

class AbsPaginationInitialState<T> extends AbsPaginationStateImpl<T> {
  const AbsPaginationInitialState()
      : super(
          data: null,
          failure: null,
          stateStatus: StateStatus.initial,
          currentPage: 1,
          lastPage: 1,
          totalRecord: 0,
        );
}
