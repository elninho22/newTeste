
import 'package:applocation/core/failures/failure_generic.dart';
import 'package:applocation/core/failures/failures.dart';
import 'package:applocation/core/network/query_parameters.dart';
import 'package:applocation/modules/home/domain/entities/network/response_appview.dart';
import 'package:applocation/modules/home/domain/repositories/appview_repository.dart';
import 'package:dartz/dartz.dart';

import 'appview_usecase.dart';

class AppViewUsecaseImpl implements AppViewUsecase {
  final AppViewRepository repository;

  AppViewUsecaseImpl(this.repository);

  @override
  Future<Either<Failures, ResponseAppView>> findBy(QueryParameters?  queryParameters) async {
    try {
      return repository.findRepository(queryParameters);
    } catch (e) {
      return left(FailureGeneric(message: 'Paramêtros obrigatórios'));
    }
  }
}
