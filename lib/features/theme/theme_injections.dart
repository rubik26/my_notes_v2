import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'data/repo_impl/theme_mode_repo_impl.dart';
import 'domain/repositories/theme_mode_repo.dart';
import 'domain/usecases/theme_mode_usecase.dart';
import 'presentation/bloc/theme_mode_bloc.dart';

final sl = GetIt.instance;

void initTheme() {
  // Register GetStorage (если еще не зарегистрирован в notes_injections)
  if (!sl.isRegistered<GetStorage>()) {
    sl.registerLazySingleton(() => GetStorage());
  }

  // Register Repository
  sl.registerLazySingleton<ThemeModeRepo>(() => ThemeModeRepoImpl());

  // Register UseCase
  sl.registerLazySingleton(() => ThemeModeUsecase(sl<ThemeModeRepo>()));

  // Register Bloc
  sl.registerFactory(() => ThemeModeBloc(sl<ThemeModeUsecase>()));
}
