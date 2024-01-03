import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vpn_app/constants/app_colors.dart';
import 'package:vpn_app/features/vpn_connectivity/services/connectivity_services.dart';
import 'package:vpn_app/route/routes.dart';
import 'package:vpn_app/services/vpn_engine.dart';
import 'package:vpn_app/features/vpn_connectivity/presentation/vpn_server_bloc/vpn_servers_bloc.dart';
import 'package:vpn_app/services/di/di_injectable.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  initState() {
    if (getIt<VpnServersBloc>().state.vpnServers.isEmpty) {
      getIt<VpnServersBloc>().add(FetchAllVpnServersEvent());
    }
    super.initState();
  }

  final ValueNotifier<bool> _isToConnect = ValueNotifier<bool>(false);
  final ConnectivityService _controller = ConnectivityService();

  @override
  Widget build(BuildContext context) {
    VpnEngine.vpnStageSnapshot().listen((event) {
      _controller.vpnState = event;
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Vpn App'),
      ),
      body: ValueListenableBuilder(
          valueListenable: _isToConnect,
          builder: (_, isToConnect, __) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    10.verticalSpace,
                    Visibility(
                      visible: isToConnect,
                      child: Flexible(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20.w, vertical: 20.h),
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.red),
                                  child: Icon(
                                    Icons.flag_circle_rounded,
                                    color: Colors.white,
                                    size: 37.w,
                                  ),
                                ),
                                5.verticalSpace,
                                Text(
                                  "Location",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14.sp),
                                ),
                                const Text("Free"),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20.w, vertical: 20.h),
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.grey),
                                  child: Icon(
                                    Icons.bar_chart_sharp,
                                    color: Colors.white,
                                    size: 37.w,
                                  ),
                                ),
                                5.verticalSpace,
                                Text(
                                  "60 ms",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14.sp),
                                ),
                                const Text("Ping"),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 3,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            isToConnect ? "Connected" : "Ready",
                            style: TextStyle(
                                color: isToConnect
                                    ? AppColors.green
                                    : AppColors.red,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w700),
                          ),
                          15.verticalSpace,
                          InkWell(
                            borderRadius: BorderRadius.circular(190.r),
                            onTap: () {
                              _isToConnect.value = !_isToConnect.value;
                            },
                            child: Container(
                                height: 180.h,
                                width: 180.w,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: isToConnect
                                        ? AppColors.green
                                        : AppColors.grey),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 13.w, vertical: 13.h),
                                child: Container(
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white),
                                  padding: EdgeInsets.all(2.w),
                                  alignment: Alignment.center,
                                  child: Text(
                                    isToConnect ? "Disconnect" : "Connect",
                                    style: TextStyle(
                                        color: AppColors.blue,
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w700),
                                  ),
                                )),
                          ),
                          50.verticalSpace,
                        ],
                      ),
                    ),
                    Visibility(
                      visible: isToConnect,
                      child: Flexible(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20.w, vertical: 20.h),
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.green),
                                  child: Icon(
                                    Icons.download_for_offline_sharp,
                                    color: Colors.white,
                                    size: 37.w,
                                  ),
                                ),
                                5.verticalSpace,
                                Text(
                                  "0 kbps",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14.sp),
                                ),
                                const Text("Download"),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20.w, vertical: 20.h),
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.blue),
                                  child: Icon(
                                    Icons.upload_sharp,
                                    color: Colors.white,
                                    size: 37.w,
                                  ),
                                ),
                                5.verticalSpace,
                                Text(
                                  "0 kbps",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14.sp),
                                ),
                                const Text("Upload"),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    20.verticalSpace,
                  ],
                ),
              ),
            );
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: ValueListenableBuilder(
          valueListenable: _isToConnect,
          builder: (_, isToConnect, __) {
            return Visibility(
              visible: !isToConnect,
              child: InkWell(
                onTap: () =>
                    Navigator.of(context).pushNamed(Routes.locationScreenRoute),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  color: Colors.red,
                  width: 1.sw,
                  height: 50.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.flag_circle_rounded,
                        color: Colors.white,
                        size: 37.w,
                      ),
                      BlocBuilder<VpnServersBloc, VpnServersState>(
                        builder: (context, state) {
                          return state.selectedVpnServer != null
                              ? Row(
                                  children: [
                                    Image.asset(
                                        'assets/flags/${state.selectedVpnServer?.countryShort.toLowerCase()}.png',
                                        height: 40.h,
                                        width: 40.w,
                                        fit: BoxFit.cover),
                                    20.horizontalSpace,
                                    Text(
                                      state.selectedVpnServer?.countryLong ??
                                          "",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14.sp),
                                    )
                                  ],
                                )
                              : Text(
                                  "Select Country / Location",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14.sp),
                                );
                        },
                      ),
                      Icon(
                        Icons.chevron_right_rounded,
                        color: Colors.white,
                        size: 37.w,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
