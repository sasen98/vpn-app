abstract class AbsSharedPrefsService {
  Future<void> saveDynamicModel<T>({
    required data,
    required String key,
  });

  T? getDynamicModel<T>({
    required dynamic T,
    required String key,
    required Function fromJson,
  });

  Future<void> saveDynamicModelList<T>({
    required List<dynamic> data,
    required String key,
  });

  List<T>? getDynamicModelList<T>({
    required dynamic T,
    required String key,
    required Function fromJson,
  });

  Future<void> setString({
    required String key,
    required String value,
  });

  String? getString({
    required String key,
  });

  Future<void> setBool({
    required String key,
    required bool value,
  });

  bool? getBool({
    required String key,
  });

  Future<void> setInt({
    required String key,
    required int value,
  });

  int? getInt({
    required String key,
  });

  Future<void> setDouble({
    required String key,
    required double value,
  });

  double? getDouble({
    required String key,
  });

  void removeKey({required String key});

  void clearSharedPrefsData();
}
