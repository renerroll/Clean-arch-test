import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/core/error/failure.dart';
import 'package:rick_and_morty/feature/domain/usecases/search_person.dart'
    hide SearchPerson;
import 'package:rick_and_morty/feature/presentation/bloc/search_bloc/search_event.dart';
import 'package:rick_and_morty/feature/presentation/bloc/search_bloc/search_state.dart';

import 'dart:async';

const SERVER_FAILURE_MESSAGE = 'Server Failure';
const CACHED_FAILURE_MESSAGE = 'Cache Failure';

class PersonSearchBloc extends Bloc<PersonSearchEvent, PersonSearchState> {
  final SearchPerson searchPerson;

  PersonSearchBloc({required this.searchPerson}) : super(PersonEmpty());

  Stream<PersonSearchState> mapEventToState(PersonSearchEvent, event) async* {
    if (event is SearchPerson) {
      yield* _mapFetchPersonToState(event.personQuery);
    }
  }

  Stream<PersonSearchState> _mapFetchPersonToState(String personQuery) async* {
    yield PersonSearchLoading();
    String _mapFailureToMessage(Failure failure) {
      switch (failure.runtimeType) {
        case ServerFailure:
          return 'Server Failure';
        case CacheFailure:
          return 'Cache Failure';
        default:
          return 'unexpected error';
      }
    }
  }
}
