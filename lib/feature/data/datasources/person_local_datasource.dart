import 'dart:convert';

import 'package:rick_and_morty/core/error/exeption.dart';
import 'package:rick_and_morty/feature/data/models/person_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PersonLocalDataSource {
  Future<List<PersonModel>> getLastPersonsFromCache();
  Future<void> personToCache(List<PersonModel> persons);
}

const CACHED_PERSONS_LIST = 'CACHED_PERSONS_LIST';

class PersonLocalDataSourceImpl implements PersonLocalDataSource {
  final SharedPreferences sharedPreferences;

  PersonLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<PersonModel>> getLastPersonsFromCache() {
    final jsonPersonsList =
        sharedPreferences.getStringList(CACHED_PERSONS_LIST);
    if (jsonPersonsList!.isNotEmpty) {
      return Future.value(jsonPersonsList
          .map((person) => PersonModel.fromJson(jsonDecode(person)))
          .toList());
    } else {
      throw CacheExeption();
    }
  }

  @override
  Future<void> personToCache(List<PersonModel> persons) {
    final List<String> jsonPersonList =
        persons.map((person) => jsonEncode(person.toJson())).toList();
    sharedPreferences.setStringList(CACHED_PERSONS_LIST, jsonPersonList);
    print('Person write to the Cache: ${jsonPersonList.length}');
    return Future.value(jsonPersonList);
  }
}
