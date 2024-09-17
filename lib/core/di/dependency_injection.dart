import 'package:dio/dio.dart';
import 'package:base_flutter/core/services/local/app_prefs.dart';
import 'package:base_flutter/data/data_source/local_data_sourece.dart';
import 'package:base_flutter/data/data_source/remote_data_source.dart';
import 'package:base_flutter/core/services/remote/api_service.dart';
import 'package:base_flutter/core/services/remote/dio_factory.dart';
import 'package:base_flutter/core/services/remote/network_info.dart';
import 'package:base_flutter/data/repository/repository_imp.dart';
import 'package:base_flutter/domain/usecase/home_usecase.dart';
import 'package:base_flutter/domain/usecase/login_usecase.dart';
import 'package:base_flutter/presentation/views/login/login_viewmodel.dart';
import 'package:base_flutter/presentation/views/home/home_viewmodel.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/repository/repository.dart';

final dIinstance = GetIt.instance;

Future<void> initAppModule() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  //app prefs
  dIinstance.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  dIinstance.registerLazySingleton<AppPreferences>(
      () => AppPreferences(dIinstance<SharedPreferences>()));

  //network info
  dIinstance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(InternetConnectionChecker()));

  //dio factory
  dIinstance.registerLazySingleton<DioFactory>(
      () => DioFactory(dIinstance<AppPreferences>()));

  Dio dio = await dIinstance<DioFactory>().getDio();
  //app service client
  dIinstance
      .registerLazySingleton<ApiServiceClient>(() => ApiServiceClient(dio));

  //remote data source
  dIinstance.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImp(dIinstance<ApiServiceClient>()));

  //local data Source
  dIinstance.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImp());

  //repository
  dIinstance.registerLazySingleton<Repository>(
      () => RepositoryImp(dIinstance(), dIinstance(), dIinstance()));
}

initLoginModule() {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    dIinstance.registerFactory<LoginUseCase>(() => LoginUseCase(dIinstance()));
    dIinstance
        .registerFactory<LoginViewModel>(() => LoginViewModel(dIinstance()));
  }
}

initHomeModule() {
  if (!GetIt.I.isRegistered<HomeUseCase>()) {
    dIinstance.registerFactory<HomeUseCase>(() => HomeUseCase(dIinstance()));
    dIinstance
        .registerFactory<HomeViewModel>(() => HomeViewModel(dIinstance()));
  }
}

