import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vpn_app/features/vpn_connectivity/domain/model/vpn_config_model.dart';
import 'package:vpn_app/features/vpn_connectivity/domain/model/vpn_model.dart';
import 'package:vpn_app/services/shared_prefs/get_shared_prefs_impl.dart';
import 'package:vpn_app/services/vpn_engine.dart';

class ConnectivityService {
  // final Rx<Vpn> vpn = Pref.vpn.obs;

  String vpnState = VpnEngine.vpnDisconnected;

  VpnModel? vpn = GetSharedPrefsDataImpl().getSelectedVpnServer;

  void connectToVpn() async {
    if (vpn?.openVPNConfigDataBase64.isEmpty ?? false) {}

    if (vpnState == VpnEngine.vpnDisconnected) {
      // log('\nBefore: ${vpn.value.openVPNConfigDataBase64}');

      if (vpn != null) {
        Uint8List data =
            const Base64Decoder().convert(vpn!.openVPNConfigDataBase64);
        String config = const Utf8Decoder().convert(data);
        VpnConfigModel vpnConfig = VpnConfigModel(
          country: vpn!.countryLong,
          username: 'vpn',
          password: 'vpn',
          config: config,
        );

        // log('\nAfter: $config');

        //code to show interstitial ad and then connect to vpn
        // AdHelper.showInterstitialAd(onComplete: () async {
        await VpnEngine.startVpn(vpnConfig);
      }
      // });
    } else {
      await VpnEngine.stopVpn();
    }
  }

  // vpn buttons color
  Color get getButtonColor {
    switch (vpnState) {
      case VpnEngine.vpnDisconnected:
        return Colors.blue;

      case VpnEngine.vpnConnected:
        return Colors.green;

      default:
        return Colors.orangeAccent;
    }
  }

  // vpn button text
  String get getButtonText {
    switch (vpnState) {
      case VpnEngine.vpnDisconnected:
        return 'Tap to Connect';

      case VpnEngine.vpnConnected:
        return 'Disconnect';

      default:
        return 'Connecting...';
    }
  }
}
