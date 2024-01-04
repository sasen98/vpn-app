import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:vpn_app/utils/failure.dart';

enum StateStatus { initial, loading, success, fail }

@immutable
abstract class AbsState<T> extends Equatable {
  final T? data;
  final Failure? failure;
  final StateStatus stateStatus;

  const AbsState({
    this.failure,
    this.data,
    required this.stateStatus,
  });
}

@immutable
class AbsStateImpl<T> extends AbsState<T> {
  const AbsStateImpl({
    T? data,
    Failure? failure,
    required StateStatus stateStatus,
  }) : super(
          stateStatus: stateStatus,
          data: data,
          failure: failure,
        );

  AbsStateImpl<T> copyWith({
    T? data,
    Failure? failure,
    StateStatus? stateStatus,
  }) {
    return AbsStateImpl(
      failure: failure ?? this.failure,
      stateStatus: stateStatus ?? this.stateStatus,
      data: data ?? this.data,
    );
  }

  @override
  List<Object?> get props => [
        data,
        failure,
        stateStatus,
      ];

  Map<String, dynamic> toJson() => {
        "data": data,
        "failure": failure,
        "absNormalStatus": stateStatus.toString(),
      };
}

class AbsInitialState<T> extends AbsStateImpl<T> {
  const AbsInitialState()
      : super(
          stateStatus: StateStatus.initial,
          data: null,
        );
}
