

import 'package:applocation/core/network/query_parameters.dart';
import 'package:applocation/modules/home/infra/models/network/response_appview_impl.dart';

abstract class AppViewDatasource {
  Future<ResponseAppViewImpl> appViewDatasource({QueryParameters? parameters});
}
