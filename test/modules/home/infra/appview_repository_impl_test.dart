
import 'package:applocation/core/failures/datasource_error.dart';
import 'package:applocation/modules/home/infra/datasources/appview_datasource.dart';
import 'package:applocation/modules/home/infra/models/network/response_appview_impl.dart';
import 'package:applocation/modules/home/infra/repository/appview_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class AppViewDatasourceMock extends Mock implements AppViewDatasource {}

main() {
  final datasource = AppViewDatasourceMock();
  final repository = AppViewRepositoryImpl(datasource);

  group('Teste de sucesso repository: ', () {
    test('Retornar ResponseAppViewImpl como sucesso', () async {
      when(() => datasource.appViewDatasource(1)).thenAnswer((_) async =>  ResponseAppViewImpl(model: null, statusCode: 000, statusMessage: 'sucesso'));
      final _result = await repository.findRepository();
      expect(_result.fold(id, id), isA<ResponseAppViewImpl>());
    });
  });

  group('Teste de falha do repository: ', () {
    test('Retornar DatasourceError em caso de falha', () async {
      when(() => datasource.appViewDatasource()).thenThrow(Exception());
      final _result = await repository.findRepository();
      expect(_result.fold(id, id), isA<DatasourceError>());
    });
  });
}
