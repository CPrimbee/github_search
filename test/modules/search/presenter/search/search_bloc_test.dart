import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/modules/search/domain/entities/result_search.dart';
import 'package:github_search/modules/search/domain/errors/errors.dart';
import 'package:github_search/modules/search/domain/usecases/search_by_text.dart';
import 'package:github_search/modules/search/presenter/search/search_bloc.dart';
import 'package:github_search/modules/search/presenter/search/states/state.dart';
import 'package:mocktail/mocktail.dart';

class SearchByTextMock extends Mock implements SearchByText {}

void main() {
  final usecase = SearchByTextMock();

  final bloc = SearchBloc(usecase);

  test('deve retornar os estados na ordem correta', () async {
    when(() => usecase.call(any()))
        .thenAnswer((_) async => Right(<ResultSearch>[]));

    expectLater(bloc.stream,
        emitsInOrder([isA<SearchLoading>(), isA<SearchSuccess>()]));

    bloc.add("cristiano");
  });

  test('deve retornar erro', () async {
    when(() => usecase.call(any()))
        .thenAnswer((_) async => Left(InvalidTextError()));

    expectLater(
        bloc.stream, emitsInOrder([isA<SearchLoading>(), isA<SearchError>()]));

    bloc.add("cristiano");
  });
}
