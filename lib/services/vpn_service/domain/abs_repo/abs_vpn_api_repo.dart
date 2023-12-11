import 'package:vpn_app/services/vpn_service/domain/model/ip_detail_model.dart';
import 'package:vpn_app/services/vpn_service/domain/model/vpn_model.dart';

abstract class AbsVpnApiRepo {
  Future<List<VpnModel>> getVPNServers();
  Future<void> getIPDetails({required IPDetailModel ipData});
}
