import 'package:dartz/dartz.dart';
import 'package:vpn_app/features/vpn_connectivity/domain/model/ip_detail_model.dart';
import 'package:vpn_app/features/vpn_connectivity/domain/model/vpn_model.dart';
import 'package:vpn_app/network/failure.dart';

abstract class AbsVpnApiRepo {
  Future<Either<List<VpnModel>, Failure>> getVPNServers();
  Future<void> getIPDetails({required IPDetailModel ipData});
}
