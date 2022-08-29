import 'package:applocation/core/network/query_parameters.dart';

import '/core/failures/failures.dart';
import '../entities/network/response_appview.dart';
import 'package:dartz/dartz.dart';

abstract class AppViewRepository {
  Future<Either<Failures, ResponseAppView>> findRepository(QueryParameters? queryParameters);
}
