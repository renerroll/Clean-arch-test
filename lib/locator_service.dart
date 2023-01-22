import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:rick_and_morty/core/platform/network_info.dart';
import 'package:rick_and_morty/feature/data/datasources/person_local_datasource.dart';
import 'package:rick_and_morty/feature/data/datasources/person_remote_datasource.dart';
import 'package:rick_and_morty/feature/data/repositories/person_repository_impl.dart';
import 'package:rick_and_morty/feature/domain/repositories/person_repository.dart';
import 'package:rick_and_morty/feature/domain/usecases/get_all_persons.dart';
import 'package:rick_and_morty/feature/domain/usecases/search_person.dart';
import 'package:rick_and_morty/feature/presentation/bloc/person_list_cubit/person_list_cubit.dart';
import 'package:rick_and_morty/feature/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;
Future <void> init() async {
  //bloc cubit
  sl.registerFactory(() => PersonListCubit(getAllPersons: sl()),);
  sl.registerFactory(() => PersonSearchBloc(searchPerson: sl()),);
  //usecase
  sl.registerLazySingleton(() => GetAllPersons(sl()),);
  sl.registerLazySingleton(() => SearchPerson(sl()),);
  //Repository
  sl.registerLazySingleton<PersonRepository>(() => PersonRepositoryImpl(
      remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()),);

  sl.registerLazySingleton<PersonRemoteDataSource>(
      () => RemoteDataSource(client: http.Client()),);

  sl.registerLazySingleton<PersonLocalDataSource>(
      () => PersonLocalDataSourceImpl(sharedPreferences: sl()),);
  //Core

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoIml(sl()),);
  //External
  sl.registerLazySingleton(() => http.Client(),);
  sl.registerLazySingleton(() => InternetConnectionChecker(),);

    final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

}
