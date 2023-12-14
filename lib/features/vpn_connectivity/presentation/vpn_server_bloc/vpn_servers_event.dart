part of 'vpn_servers_bloc.dart';

sealed class VpnServersEvent extends Equatable {
  const VpnServersEvent();

  @override
  List<Object> get props => [];
}

final class FetchAllVpnServersEvent extends VpnServersEvent {}

final class SelectVpnServerEvent extends VpnServersEvent {
  const SelectVpnServerEvent({required this.selectedModel});
  final VpnModel selectedModel;
}
