import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:vpn_app/features/vpn_connectivity/domain/model/vpn_config_model.dart';
import 'package:vpn_app/features/vpn_connectivity/domain/model/vpn_status_model.dart';

class VpnEngine {
  ///Channel to native
  static const String _eventChannelVpnStage = "vpnStage";
  static const String _eventChannelVpnStatus = "vpnStatus";
  static const String _methodChannelVpnControl = "vpnControl";

  ///Snapshot of VPN Connection Stage
  static Stream<String> vpnStageSnapshot() =>
      const EventChannel(_eventChannelVpnStage).receiveBroadcastStream().cast();

  ///Snapshot of VPN Connection Status
  static Stream<VpnStatusModel?> vpnStatusSnapshot() =>
      const EventChannel(_eventChannelVpnStatus)
          .receiveBroadcastStream()
          .map((event) => VpnStatusModel.fromJson(jsonDecode(event)))
          .cast();

  ///Start VPN easily
  static Future<void> startVpn(VpnConfigModel vpnConfig) async {
    // log(vpnConfig.config);
    return const MethodChannel(_methodChannelVpnControl).invokeMethod(
      "start",
      {
        "config": vpnConfig.config,
        "country": vpnConfig.country,
        "username": vpnConfig.username,
        "password": vpnConfig.password,
      },
    );
  }

  ///Stop vpn
  static Future<void> stopVpn() =>
      const MethodChannel(_methodChannelVpnControl).invokeMethod("stop");

  ///Open VPN Settings
  static Future<void> openKillSwitch() =>
      const MethodChannel(_methodChannelVpnControl).invokeMethod("kill_switch");

  ///Trigger native to get stage connection
  static Future<void> refreshStage() =>
      const MethodChannel(_methodChannelVpnControl).invokeMethod("refresh");

  ///Get latest stage
  static Future<String?> stage() =>
      const MethodChannel(_methodChannelVpnControl).invokeMethod("stage");

  ///Check if vpn is connected
  static Future<bool> isConnected() =>
      stage().then((value) => value?.toLowerCase() == "connected");

  ///All Stages of connection
  static const String vpnConnected = "connected";
  static const String vpnDisconnected = "disconnected";
  static const String vpnWaitConnection = "wait_connection";
  static const String vpnAuthenticating = "authenticating";
  static const String vpnReconnect = "reconnect";
  static const String vpnNoConnection = "no_connection";
  static const String vpnConnecting = "connecting";
  static const String vpnPrepare = "prepare";
  static const String vpnDenied = "denied";
}
