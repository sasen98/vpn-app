part of 'vpn_servers_bloc.dart';

sealed class VpnServersState extends Equatable {
  const VpnServersState({
    required this.vpnServers,
    required this.status,
    this.selectedVpnServer,
    this.failure,
  });
  final List<VpnModel> vpnServers;
  final VpnModel? selectedVpnServer;
  final StateStatus status;
  final Failure? failure;

  VpnServersState copyWith({
    List<VpnModel>? vpnServers,
    VpnModel? selectedVpnServer,
    StateStatus? status,
    Failure? failure,
  });

  @override
  List<Object?> get props => [
        vpnServers,
        status,
        selectedVpnServer,
        failure,
      ];
}

final class VpnServersImplState extends VpnServersState {
  const VpnServersImplState(
      {required super.vpnServers,
      required super.status,
      super.selectedVpnServer,
      super.failure});

  @override
  VpnServersState copyWith(
      {List<VpnModel>? vpnServers,
      VpnModel? selectedVpnServer,
      StateStatus? status,
      Failure? failure}) {
    return VpnServersImplState(
      selectedVpnServer: selectedVpnServer ?? this.selectedVpnServer,
      status: status ?? this.status,
      vpnServers: vpnServers ?? this.vpnServers,
      failure: failure ?? this.failure,
    );
  }
}

final class VpnServersInitialState extends VpnServersImplState {
  VpnServersInitialState()
      : super(
          vpnServers: [],
          status: StateStatus.initial,
          selectedVpnServer: null,
          failure: Failure(message: "", statusCode: 100),
        );
}
