import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:vpn_app/features/vpn_connectivity/presentation/vpn_server_bloc/vpn_servers_bloc.dart';
import 'package:vpn_app/home/presentation/screens/home_screen.dart';
import 'package:vpn_app/route/route_generator.dart';
import 'package:vpn_app/route/routes.dart';
import 'package:vpn_app/services/di/di_injectable.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<VpnServersBloc>.value(
      value: getIt<VpnServersBloc>(),
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp(
            builder: BotToastInit(),
            debugShowCheckedModeBanner: false,
            title: 'Vpn App',
            onGenerateRoute: RouteGenerator.generateRoute,
            initialRoute: Routes.homeScreenRoute,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            navigatorObservers: [BotToastNavigatorObserver()],
            home: child,
          );
        },
        child: const HomeScreen(),
      ),
    );
  }
}
