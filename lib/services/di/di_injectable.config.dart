// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i9;

import '../../features/vpn_connectivity/data/repo_impl/vpn_api_repo_impl.dart'
    as _i8;
import '../../features/vpn_connectivity/domain/abs_repo/abs_vpn_api_repo.dart'
    as _i7;
import '../../features/vpn_connectivity/presentation/vpn_server_bloc/vpn_servers_bloc.dart'
    as _i10;
import '../shared_prefs/abs_get_shared_prefs.dart' as _i3;
import '../shared_prefs/abs_shared_prefs_service.dart' as _i5;
import '../shared_prefs/get_shared_prefs_impl.dart' as _i4;
import '../shared_prefs/shared_prefs_impl.dart' as _i6;
import 'third_party_injection_module.dart' as _i11;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final thirdPartyInjectionModule = _$ThirdPartyInjectionModule();
    gh.lazySingleton<_i3.AbsGetSharedPrefsData>(
        () => _i4.GetSharedPrefsDataImpl());
    gh.lazySingleton<_i5.AbsSharedPrefsService>(
        () => _i6.SharedPrefsServiceImpl());
    gh.lazySingleton<_i7.AbsVpnApiRepo>(() => _i8.VpnApiRepoImpl());
    await gh.factoryAsync<_i9.SharedPreferences>(
      () => thirdPartyInjectionModule.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i10.VpnServersBloc>(() => _i10.VpnServersBloc());
    return this;
  }
}

class _$ThirdPartyInjectionModule extends _i11.ThirdPartyInjectionModule {}
