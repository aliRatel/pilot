import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:pilot/app/data/repositories/user_repository_impl.dart';
import 'package:pilot/app/domain/repositories/user_repository.dart';
import 'package:pilot/app/domain/usecases/check_for_available_users_usecase.dart';
import 'package:pilot/app/domain/usecases/user_login_usecase.dart';
import 'package:pilot/app/presentation/providers/basic_user_provider.dart';
import 'package:pilot/app/presentation/providers/company_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite_dev.dart';

GetIt sl = GetIt.instance;

Future<void> init() async {
  ///providers
  sl.registerFactory(() => UserProvider(checkForAvailableUsersUseCase: sl()));
  sl.registerFactory(() => LogInProvider(userLoginUseCase: sl()));

  ///usecases
  sl.registerLazySingleton<CheckForAvailableUsersUseCase>(() => CheckForAvailableUsersUseCase());
  sl.registerLazySingleton<UserLoginUseCase>(() => UserLoginUseCase(userRepository: sl()));


  ///repositories
  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl());








  /// local data sources
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  sl.registerLazySingleton<DataConnectionChecker>(
          () => DataConnectionChecker());

}

