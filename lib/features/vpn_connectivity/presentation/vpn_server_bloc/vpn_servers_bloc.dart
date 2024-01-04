import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vpn_app/constants/app_constants.dart';
import 'package:vpn_app/features/vpn_connectivity/domain/abs_repo/abs_vpn_api_repo.dart';
import 'package:vpn_app/features/vpn_connectivity/domain/model/vpn_model.dart';
import 'package:vpn_app/utils/data_state.dart';
import 'package:vpn_app/utils/failure.dart';
import 'package:vpn_app/services/di/di_injectable.dart';
import 'package:vpn_app/services/shared_prefs/abs_get_shared_prefs.dart';
import 'package:vpn_app/services/shared_prefs/abs_shared_prefs_service.dart';
import 'package:vpn_app/services/shared_prefs/get_shared_prefs_impl.dart';
import 'package:vpn_app/services/shared_prefs/shared_prefs_keys.dart';

part 'vpn_servers_event.dart';
part 'vpn_servers_state.dart';

@lazySingleton
class VpnServersBloc extends Bloc<VpnServersEvent, VpnServersState> {
  VpnServersBloc() : super(VpnServersInitialState()) {
    on<VpnServersEvent>((event, emit) {});

    on<FetchAllVpnServersEvent>((event, emit) async {
      emit(
        state.copyWith(
            vpnServers: [], status: APIStatus.loading, selectedVpnServer: null),
      );
      Either<List<VpnModel>, Failure> respo =
          await getIt<AbsVpnApiRepo>().getVPNServers();
      respo.fold(
        (l) {
          emit(state.copyWith(status: APIStatus.success, vpnServers: l));
          if (state.selectedVpnServer == null && l.isNotEmpty) {
            add(
              SelectVpnServerEvent(
                selectedModel: _selectFastestSever(vpnList: l),
              ),
            );
          }
        },
        (r) => emit(
          state.copyWith(failure: r),
        ),
      );
    });
    on<SelectVpnServerEvent>((event, emit) {
      getIt<AbsGetSharedPrefsData>().setSelectedVpnServer(event.selectedModel);
      emit(state.copyWith(selectedVpnServer: event.selectedModel));
    });
    on<ResetVpnServersEvent>((event, emit) {
      emit(VpnServersInitialState());
    });
  }
  VpnModel _selectFastestSever({required List<VpnModel> vpnList}) {
    VpnModel fastestServer = vpnList[0];
    for (int i = 1; i < vpnList.length; i++) {
      if (vpnList[i].speed > fastestServer.speed) {
        fastestServer = vpnList[i];
      }
    }
    return fastestServer;
  }
}
