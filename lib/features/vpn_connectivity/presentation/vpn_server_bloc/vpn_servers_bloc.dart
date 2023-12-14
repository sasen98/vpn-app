import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:vpn_app/constants/app_constants.dart';
import 'package:vpn_app/features/vpn_connectivity/data/repo_impl/vpn_api_repo_impl.dart';
import 'package:vpn_app/features/vpn_connectivity/domain/model/vpn_model.dart';
import 'package:vpn_app/network/failure.dart';
import 'package:vpn_app/services/di/di_injectable.dart';

part 'vpn_servers_event.dart';
part 'vpn_servers_state.dart';

@lazySingleton
class VpnServersBloc extends Bloc<VpnServersEvent, VpnServersState> {
  VpnServersBloc() : super(VpnServersInitialState()) {
    on<VpnServersEvent>((event, emit) {});
    on<FetchAllVpnServersEvent>((event, emit) async {
      emit(
        state.copyWith(
            vpnServers: [],
            status: StateStatus.loading,
            selectedVpnServer: null),
      );
      Either<List<VpnModel>, Failure> _respo =
          await getIt<VpnApiRepoImpl>().getVPNServers();
      _respo.fold(
        (l) => emit(state.copyWith(status: StateStatus.success, vpnServers: l)),
        (r) => emit(
          state.copyWith(failure: r),
        ),
      );
    });
    on<SelectVpnServerEvent>((event, emit) {
      emit(state.copyWith(selectedVpnServer: event.selectedModel));
    });
  }
}
