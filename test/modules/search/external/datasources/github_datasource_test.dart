import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/modules/search/domain/errors/errors.dart';
import 'package:github_search/modules/search/external/datasources/github_datasource.dart';
import 'package:mocktail/mocktail.dart';

import '../../utils/github_response.dart';

class DioMock extends Mock implements Dio {}

void main() {
  final dio = DioMock();
  final datasource = GithubDatasource(dio);

  test('deve retornar uma lista de ResultSearchModel', () async {
    when(() => dio.get(any())).thenAnswer((_) async => Response(
        requestOptions: RequestOptions(path: ''),
        data: jsonDecode(githubResult),
        statusCode: 200));

    final future = datasource.getSearch("cristiano");
    expect(future, completes);
  });

  test('deve retornar um DatasourceError se o codigo nao for 200', () async {
    when(() => dio.get(any())).thenAnswer((_) async => Response(
        requestOptions: RequestOptions(path: ''), data: null, statusCode: 401));

    final future = datasource.getSearch("cristiano");
    expect(future, throwsA(isA<DatasourceError>()));
  });
}
