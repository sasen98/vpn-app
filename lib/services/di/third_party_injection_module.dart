import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// created so that we dont need to await

@module
abstract class ThirdPartyInjectionModule {
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
}
