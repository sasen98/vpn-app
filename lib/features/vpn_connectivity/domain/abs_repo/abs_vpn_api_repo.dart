import 'package:dartz/dartz.dart';
import 'package:vpn_app/features/vpn_connectivity/domain/model/ip_detail_model.dart';
import 'package:vpn_app/features/vpn_connectivity/domain/model/vpn_model.dart';
import 'package:vpn_app/utils/failure.dart';

abstract class AbsVpnApiRepo {
  Future<Either<List<VpnModel>, Failure>> getVPNServers();
  Future<Either<IPDetailModel, Failure>> getIPDetails();
}
