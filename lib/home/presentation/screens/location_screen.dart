import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vpn_app/constants/app_constants.dart';
import 'package:vpn_app/features/vpn_connectivity/domain/model/network_data_model.dart';
import 'package:vpn_app/features/vpn_connectivity/presentation/vpn_server_bloc/vpn_servers_bloc.dart';
import 'package:vpn_app/widgets/location_card_widget.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Choose Location")),
      body: BlocBuilder<VpnServersBloc, VpnServersState>(
        builder: (context, state) {
          return (state.status == StateStatus.success)
              ? (state.vpnServers.isNotEmpty)
                  ? ListView.builder(
                      itemBuilder: (context, index) {
                        var _temp = state.vpnServers[index];
                        NetworkDataModel _data = NetworkDataModel(
                            icon: Image.asset(
                                'assets/flags/${_temp.countryShort.toLowerCase()}.png',
                                height: 40.h,
                                width: 40.w,
                                fit: BoxFit.cover),
                            subtitle: _temp.speed.toString(),
                            title: _temp.countryLong);
                        return NetworkCard(
                          data: _data,
                        );
                      },
                      itemCount: state.vpnServers.length,
                    )
                  : Text(state.failure?.message ??
                      "No Servers Avilable at the moment")
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}
