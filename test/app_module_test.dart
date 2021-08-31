import 'dart:convert';

import 'package:dartz/dartz.dart' hide Bind;
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular_test/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/app_module.dart';
import 'package:github_search/modules/search/domain/entities/result_search.dart';
import 'package:github_search/modules/search/domain/usecases/search_by_text.dart';
import 'package:mocktail/mocktail.dart';

import 'modules/search/utils/github_response.dart';

class DioMock extends Mock implements Dio {}

void main() {
  final dio = DioMock();

  initModule(AppModule(), replaceBinds: [
    Bind.instance<Dio>(dio),
  ]);

  test('Deve recuperar o usecase sem erro', () {
    final usecase = Modular.get<SearchByText>();
    expect(usecase, isA<SearchByTextImpl>());
  });

  test('Deve trazer uma lista de ResultSearch', () async {
    when(() => dio.get(any())).thenAnswer((_) async => Response(
        requestOptions: RequestOptions(path: ''),
        data: jsonDecode(githubResult),
        statusCode: 200));

    final usecase = Modular.get<SearchByText>();
    final result = await usecase("cristiano");

    expect(result.fold(id, id), isA<List<ResultSearch>>());
  });
}
