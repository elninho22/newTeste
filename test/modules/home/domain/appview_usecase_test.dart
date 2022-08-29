
import 'package:applocation/core/failures/failure_generic.dart';
import 'package:applocation/modules/home/domain/entities/network/response_appview.dart';
import 'package:applocation/modules/home/domain/repositories/appview_repository.dart';
import 'package:applocation/modules/home/domain/usecases/appview_usecase_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class AppViewRepositoryMock extends Mock implements AppViewRepository {}

main() {
  final repositoryMock = AppViewRepositoryMock();
  final usecases = AppViewUsecaseImpl(repositoryMock);

  group('Teste com sucesso', () {
    test('Retorno ResponseAppView como sucesso', () async {
      when(() => repositoryMock.findRepository()).thenAnswer((_) async => right(ResponseAppView()));
      final _result = await usecases.findBy();
      expect(_result.fold(id, id), isA<ResponseAppView>());
    });
  });

  group('Teste de falha: ', () {
    test('Retorar FailureGeneric', () async {
      when(() => repositoryMock.findRepository()).thenAnswer((_) async => left(FailureGeneric(message: 'Falha')));
      final _result = await usecases.findBy();
      expect(_result.fold(id, id), isA<FailureGeneric>());
    });
  });
}
