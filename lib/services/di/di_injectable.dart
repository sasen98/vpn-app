import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:vpn_app/services/di/di_injectable.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
)
Future<void> configureDependencies() => getIt.init();

/// flutter packages pub run build_runner build — delete-conflicting-outputs
/// flutter packages pub run build_runner watch — delete-conflicting-outputs