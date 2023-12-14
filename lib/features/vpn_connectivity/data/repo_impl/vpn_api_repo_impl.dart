import 'dart:convert';
import 'dart:developer';

import 'package:injectable/injectable.dart';
import 'package:vpn_app/network/failure.dart';
import 'package:vpn_app/services/di/di_injectable.dart';
import 'package:vpn_app/services/shared_prefs/abs_get_shared_prefs.dart';
import 'package:vpn_app/features/vpn_connectivity/domain/abs_repo/abs_vpn_api_repo.dart';
import 'package:vpn_app/features/vpn_connectivity/domain/model/ip_detail_model.dart';
import 'package:vpn_app/features/vpn_connectivity/domain/model/vpn_model.dart';
import 'package:dio/dio.dart';
import 'package:csv/csv.dart';
import 'package:vpn_app/widgets/custom_toast.dart';
import 'package:dartz/dartz.dart';

@LazySingleton(as: AbsVpnApiRepo)
class VpnApiRepoImpl implements AbsVpnApiRepo {
  final Dio _dio = Dio();
  @override
  Future<Either<List<VpnModel>, Failure>> getVPNServers() async {
    final List<VpnModel> vpnList = [];
    try {
      final res = await _dio.get('http://www.vpngate.net/api/iphone/');
      final csvString = res.data.split("#")[1].replaceAll('*', '');

      List<List<dynamic>> list = const CsvToListConverter().convert(csvString);

      final header = list[0];

      for (int i = 1; i < list.length - 1; ++i) {
        Map<String, dynamic> tempJson = {};

        for (int j = 0; j < header.length; ++j) {
          tempJson.addAll({header[j].toString(): list[i][j]});
        }
        vpnList.add(VpnModel.fromJson(tempJson));
      }
      if (vpnList.isNotEmpty) {
        getIt<AbsGetSharedPrefsData>().setVpnServerList(vpnList);
      }
      vpnList.shuffle();

      return left(vpnList);
    } catch (e) {
      return right(
        Failure(message: e.toString(), statusCode: 500),
      );
    }
  }

  @override
  Future<void> getIPDetails({required IPDetailModel ipData}) async {
    try {
      final res = await _dio.get('http://ip-api.com/json/');
      final data = jsonDecode(res.data);
      log(data.toString());
      ipData = IPDetailModel.fromJson(data);
    } catch (e) {
      CustomToast.showToast(message: e.toString());
      log('\ngetIPDetailsE: $e');
    }
  }
}
