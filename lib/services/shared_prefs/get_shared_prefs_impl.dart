import 'package:vpn_app/services/di/di_injectable.dart';
import 'package:vpn_app/services/shared_prefs/abs_get_shared_prefs.dart';
import 'package:vpn_app/services/shared_prefs/abs_shared_prefs_service.dart';
import 'package:vpn_app/services/shared_prefs/shared_prefs_keys.dart';
import 'package:vpn_app/features/vpn_connectivity/domain/model/vpn_model.dart';

class GetSharedPrefsDataImpl implements AbsGetSharedPrefsData {
  @override
  Future<void> setSelectedVpnServer(VpnModel vpnModel) async {
    getIt<AbsSharedPrefsService>().saveDynamicModel(
        data: vpnModel, key: SharedPrefsKeys.selectedVpnServerKey);
  }

  @override
  VpnModel? get getSelectedVpnServer =>
      getIt<AbsSharedPrefsService>().getDynamicModel<VpnModel>(
        T: VpnModel,
        key: SharedPrefsKeys.selectedVpnServerKey,
        fromJson: VpnModel.fromJson,
      );

  @override
  List<VpnModel>? get getVpnServerList =>
      getIt<AbsSharedPrefsService>().getDynamicModelList<VpnModel>(
        T: VpnModel,
        key: SharedPrefsKeys.vpnServerListKey,
        fromJson: VpnModel.fromJson,
      );

  @override
  Future<void> setVpnServerList(List<VpnModel> vpnModelList) async {
    getIt<AbsSharedPrefsService>().saveDynamicModelList(
        data: vpnModelList, key: SharedPrefsKeys.vpnServerListKey);
  }
}
