import 'dart:convert';
import 'package:rick_and_morty/core/error/exeption.dart';
import 'package:rick_and_morty/feature/data/models/person_model.dart';
import 'package:http/http.dart' as http;

abstract class PersonRemoteDataSource {
  Future<List<PersonModel>> GetAllPersons(int page);
  Future<List<PersonModel>> SearchPerson(String query);
}

class RemoteDataSource implements PersonRemoteDataSource {
  final http.Client client;
  RemoteDataSource({required this.client});

  @override
  Future<List<PersonModel>> GetAllPersons(int page) => _getPersonFromUrl(
      'https://rickandmortyapi.com/api/character/?page=$page'); /*async {
    final response = await client.get(
        Uri.parse('https://rickandmortyapi.com/api/characters/?page=$page'),
        headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      final person = json.decode(response.body);
      return (person['results'] as List)
          .map((person) => PersonModel.fromJson(person))
          .toList();
    } else {
      throw ServerExeption();
    }
  }*/

  @override
  Future<List<PersonModel>> SearchPerson(String query) => _getPersonFromUrl(
      'https://rickandmortyapi.com/api/character/?name=$query'); /*async {
    final response = await client.get(
        Uri.parse('https://rickandmortyapi.com/api/characters/?name=$query'),
        headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      final person = json.decode(response.body);
      return (person['results'] as List)
          .map((person) => PersonModel.fromJson(person))
          .toList();
    } else {
      throw ServerExeption();
    }
  }*/

  Future<List<PersonModel>> _getPersonFromUrl(String url) async {
    print(url);
    final response = await client
        .get(Uri.parse(url), headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      final person = json.decode(response.body);
      return (person['results'] as List)
          .map((person) => PersonModel.fromJson(person))
          .toList();
    } else {
      throw ServerExeption();
    }
  }
}
