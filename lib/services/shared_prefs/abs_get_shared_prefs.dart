import 'package:vpn_app/features/vpn_connectivity/domain/model/vpn_model.dart';

abstract class AbsGetSharedPrefsData {
  Future<void> setSelectedVpnServer(VpnModel vpnModel);

  VpnModel? get getSelectedVpnServer;

  Future<void> setVpnServerList(List<VpnModel> vpnModelList);

  List<VpnModel>? get getVpnServerList;
}
