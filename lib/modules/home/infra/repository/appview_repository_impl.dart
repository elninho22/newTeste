
import 'package:applocation/core/failures/datasource_error.dart';
import 'package:applocation/core/failures/failures.dart';
import 'package:applocation/core/network/query_parameters.dart';
import 'package:applocation/modules/home/domain/entities/network/response_appview.dart';
import 'package:applocation/modules/home/domain/repositories/appview_repository.dart';
import 'package:applocation/modules/home/infra/datasources/appview_datasource.dart';
import 'package:dartz/dartz.dart';

class AppViewRepositoryImpl implements AppViewRepository {
  final AppViewDatasource datasource;

  AppViewRepositoryImpl(this.datasource);

  @override
  Future<Either<Failures, ResponseAppView>> findRepository(QueryParameters? queryParameters)async {
    try {
      final result = await datasource.appViewDatasource(parameters:queryParameters );
      return right(result);
    } on DatasourceError catch (e) {
      return left(e);
    } catch (e) {
      return left(DatasourceError(message: 'Não foi possível solicitar os dados para o servidor'));
    }
  }
  

}
