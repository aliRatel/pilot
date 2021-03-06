import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';

import 'package:pilot/app/data/repositories/user_repository_impl.dart';
import 'package:pilot/app/domain/entities/job_seeker.dart';
import 'package:pilot/app/domain/repositories/user_repository.dart';
import 'package:pilot/app/domain/usecases/AddNewJobUseCase.dart';
import 'package:pilot/app/domain/usecases/check_for_available_users_usecase.dart';
import 'package:pilot/app/domain/usecases/complete_company_profile_usecase.dart';
import 'package:pilot/app/domain/usecases/complete_user_profile_usecase.dart';
import 'package:pilot/app/domain/usecases/get_cities_by_country_usecase.dart';
import 'package:pilot/app/domain/usecases/get_countries_usecase.dart';
import 'package:pilot/app/domain/usecases/get_jobs_by_company_usecase.dart';
import 'package:pilot/app/domain/usecases/get_recent_jobs_usecase.dart';
import 'package:pilot/app/domain/usecases/search_jobs_usecase.dart';
import 'package:pilot/app/domain/usecases/user_login_usecase.dart';
import 'package:pilot/app/domain/usecases/user_signup_useCase.dart';
import 'package:pilot/app/presentation/providers/add_job_provider.dart';
import 'package:pilot/app/presentation/providers/company_dashBoard_provider.dart';
import 'package:pilot/app/presentation/providers/jobSeeker_dashBoardProvider.dart';
import 'package:pilot/app/presentation/providers/location_provider.dart';
import 'package:pilot/app/presentation/providers/search_page_provider.dart';
import 'package:pilot/app/presentation/providers/signup_provider.dart';
import 'package:pilot/app/presentation/providers/user_provider.dart';
import 'package:pilot/app/presentation/providers/login_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/data/data_sources/local/local_data_source.dart';
import 'app/data/data_sources/remote/remote_data_source.dart';
import 'app/data/data_sources/remote/services/user_remote_service.dart';
import 'app/presentation/providers/complete_JobSeeker_registration_provider.dart';
import 'app/presentation/providers/complete_company_registration_provider.dart';

GetIt sl = GetIt.instance;

Future<void> init() async {
  ///providers
  sl.registerFactory(() => UserProvider(checkForAvailableUsersUseCase: sl()));
  sl.registerFactory(() => LogInProvider(userLoginUseCase: sl()));
  sl.registerFactory(() => SignUpProvider(userSignUpUseCase: sl()));
  sl.registerFactory(() =>
      CompleteCompanyRegistrationProvider(completeCompanyProfileUseCase: sl()));
  sl.registerFactory(() => CompleteJobSeekerRegistrationProvider(
      completeJobSeekerProfileUseCase: sl()));
  sl.registerFactory(() => AddJobProvider(addNewJobUseCase: sl()));
  sl.registerFactory(
      () => CompanyDashBoardProvider(getJobsByCompanyUseCase: sl()));
  sl.registerFactory(
      () => JobSeekerDashBoardProvider(getRecentJobsUseCase: sl()));
  sl.registerFactory(() => LocationProvider(
      getCitiesByCountryUseCase: sl(), getCountriesUseCase: sl()));
  sl.registerFactory(() => SearchPageProvider(searchJobsUseCase: sl()));

  ///usecases
  sl.registerLazySingleton<CheckForAvailableUsersUseCase>(
      () => CheckForAvailableUsersUseCase(userRepository: sl()));
  sl.registerLazySingleton<CompleteJobSeekerProfileUseCase>(
      () => CompleteJobSeekerProfileUseCase(userRepository: sl()));
  sl.registerLazySingleton<CompleteCompanyProfileUseCase>(
      () => CompleteCompanyProfileUseCase(userRepository: sl()));
  sl.registerLazySingleton<UserLoginUseCase>(
      () => UserLoginUseCase(userRepository: sl()));
  sl.registerLazySingleton<UserSignUpUseCase>(
      () => UserSignUpUseCase(userRepository: sl()));
  sl.registerLazySingleton<GetCitiesByCountryUseCase>(
      () => GetCitiesByCountryUseCase(userRepository: sl()));
  sl.registerLazySingleton<GetCountriesUseCase>(
      () => GetCountriesUseCase(userRepository: sl()));
  sl.registerLazySingleton<GetJobsByCompanyUseCase>(
      () => GetJobsByCompanyUseCase(userRepository: sl()));
  sl.registerLazySingleton<GetRecentJobsUseCase>(
      () => GetRecentJobsUseCase(userRepository: sl()));
  sl.registerLazySingleton<SearchJobsUseCase>(
      () => SearchJobsUseCase(userRepository: sl()));
  sl.registerLazySingleton<AddNewJobUseCase>(() => AddNewJobUseCase(userRepository: sl()));

  ///repositories
  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(
      apiDataSource: sl(), sharedPreferencesDataSource: sl()));

  ///remote data sources
  final UserRemoteService userRemoteService = UserRemoteService.create();

  sl.registerLazySingleton<ApiDataSource>(
      () => ApiDataSourceImpl(userRemoteService: userRemoteService));

  ///remote services
  /// local data sources
  sl.registerLazySingleton<SharedPreferencesDataSource>(
      () => SharedPreferencesDataSourceImpl(sharedPreferences: sl()));
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  sl.registerLazySingleton<DataConnectionChecker>(
      () => DataConnectionChecker());
}
