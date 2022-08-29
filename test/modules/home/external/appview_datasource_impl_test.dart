
import 'package:applocation/constants/const_endpoint.dart';
import 'package:applocation/core/network/network.dart';
import 'package:applocation/modules/home/external/datasource/appview_datasource_impl.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class NetworkMock extends Mock implements Network {}

main() {

  final _network = NetworkMock();
  final datasource = AppViewDatasourceImpl(_network);

  group('Teste de sucesso: ', () {
    final tResponse = Response(statusCode: 200, data: {"data": null, "message": "OK", "statusCode": 200}, requestOptions: RequestOptions(path: ENDPOINT));
    test('Deve retornar 200 se sucesso', () async {
      when(() => _network.get('router-test')).thenAnswer((_) async => tResponse);
      final result = datasource..appViewDatasource();
      expect(result, completes);
    });
  });
}