import 'package:get_storage/get_storage.dart';

abstract class ThemeModeLocalDatasource {
  void saveThemeMode(bool isDarkMode);
  bool getThemeMode();
}

class ThemeModeLocalDatasourceImpl implements ThemeModeLocalDatasource {
  final box = GetStorage();

  @override
  void saveThemeMode(bool isDarkMode) {
    box.write('isDarkMode', isDarkMode);
  }

  @override
  bool getThemeMode() {
    return box.read<bool>('isDarkMode') ?? false;
  }
}
