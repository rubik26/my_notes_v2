import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/datasources/local/theme_mode_local_datasource.dart';
import '../../domain/usecases/theme_mode_usecase.dart';

sealed class ThemeModeEvent {}

class ToggleThemeMode extends ThemeModeEvent {}

class ThemeModeBloc extends Bloc<ThemeModeEvent, bool> {
  final ThemeModeUsecase themeModeUsecase;

  ThemeModeBloc(this.themeModeUsecase)
      : super(ThemeModeLocalDatasourceImpl().getThemeMode()) {
    on<ToggleThemeMode>((event, emit) {
      final newThemeMode = themeModeUsecase.toggleThemeMode();
      emit(newThemeMode);
      ThemeModeLocalDatasourceImpl().saveThemeMode(newThemeMode);
    });
  }
}
