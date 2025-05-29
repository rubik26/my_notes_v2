import '../repositories/theme_mode_repo.dart';

class ThemeModeUsecase {
  final ThemeModeRepo repository;
  ThemeModeUsecase(this.repository);

  bool toggleThemeMode() {
    return repository.toggleThemeMode();
  }

  bool getThemeMode() {
    return repository.getThemeMode();
  }
}
