import '../../domain/repositories/theme_mode_repo.dart';

class ThemeModeRepoImpl extends ThemeModeRepo {
  bool _isDarkMode = false;

  @override
  bool toggleThemeMode() {
    _isDarkMode = !_isDarkMode;
    return _isDarkMode;
  }

  @override
  bool getThemeMode() => _isDarkMode;
}
