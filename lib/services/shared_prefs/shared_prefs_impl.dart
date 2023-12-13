import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:vpn_app/services/di/di_injectable.dart';
import 'package:vpn_app/services/shared_prefs/abs_shared_prefs_service.dart';

class SharedPrefsServiceImpl implements AbsSharedPrefsService {
  @override
  void clearSharedPrefsData() async {
    await getIt<SharedPreferences>().clear();
  }

  @override
  bool? getBool({required String key}) {
    try {
      return getIt<SharedPreferences>().getBool(key);
    } catch (error) {
      return null;
    }
  }

  @override
  double? getDouble({required String key}) {
    try {
      return getIt<SharedPreferences>().getDouble(key);
    } catch (error) {
      return null;
    }
  }

  @override
  T? getDynamicModel<T>(
      {required T, required String key, required Function fromJson}) {
    var sharedPreferences = getIt<SharedPreferences>();
    try {
      if (sharedPreferences.getString(key) != null) {
        Map<String, dynamic> dynamicData =
            json.decode(sharedPreferences.getString(key)!);
        return fromJson(dynamicData);
      } else {
        return null;
      }
    } catch (error) {
      return null;
    }
  }

  @override
  int? getInt({required String key}) {
    try {
      return getIt<SharedPreferences>().getInt(key);
    } catch (error) {
      return null;
    }
  }

  @override
  String? getString({required String key}) {
    try {
      return getIt<SharedPreferences>().getString(key);
    } catch (error) {
      return null;
    }
  }

  @override
  Future<void> saveDynamicModel<T>({required data, required String key}) async {
    try {
      String dynamicData = json.encode(data.toJson());
      await getIt<SharedPreferences>().setString(key, dynamicData);
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<void> setBool({required String key, required bool value}) async {
    try {
      await getIt<SharedPreferences>().setBool(key, value);
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<void> setDouble({required String key, required double value}) async {
    try {
      await getIt<SharedPreferences>().setDouble(key, value);
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<void> setInt({required String key, required int value}) async {
    try {
      await getIt<SharedPreferences>().setInt(key, value);
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<void> setString({required String key, required String value}) async {
    try {
      await getIt<SharedPreferences>().setString(key, value);
    } catch (error) {
      rethrow;
    }
  }

  @override
  void removeKey({required String key}) async {
    try {
      await getIt<SharedPreferences>().remove(key);
    } catch (error) {
      rethrow;
    }
  }

  @override
  List<T>? getDynamicModelList<T>(
      {required T, required String key, required Function fromJson}) {
    var sharedPreferences = getIt<SharedPreferences>();
    try {
      if (sharedPreferences.getStringList(key) != null) {
        List<T> temp = [];
        sharedPreferences.getStringList(key)?.map((e) {
          temp.add(fromJson(json.decode(e)));
        });
        return temp;
      } else {
        return null;
      }
    } catch (error) {
      return null;
    }
  }

  @override
  Future<void> saveDynamicModelList<T>(
      {required List<dynamic> data, required String key}) async {
    try {
      List<String> listData = [];

      data.map((e) => listData.add(json.encode(e.toJson())));
      await getIt<SharedPreferences>().setStringList(key, listData);
    } catch (error) {
      rethrow;
    }
  }
}
