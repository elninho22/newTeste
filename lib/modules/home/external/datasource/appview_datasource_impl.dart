import 'package:applocation/constants/application_url.dart';
import 'package:applocation/constants/const_strings.dart';
import 'package:applocation/core/network/network.dart';
import 'package:applocation/core/network/query_parameters.dart';
import 'package:applocation/lang/app_translation.dart';
import 'package:applocation/modules/home/infra/datasources/appview_datasource.dart';
import 'package:applocation/modules/home/infra/models/network/response_appview_impl.dart';

class AppViewDatasourceImpl implements AppViewDatasource {
  final Network _network;
  AppViewDatasourceImpl(this._network);

  @override
  Future<ResponseAppViewImpl> appViewDatasource({QueryParameters? parameters}) async {
    try {
      final response = await _network.get(ApplicationUrl.findAll());
      if (response.statusCode == null || response.statusCode == 503 || response.statusCode == 504) {
        return ResponseAppViewImpl.fromMap(
          pages: 0,
          count: 0,
          statusCode: ConstStrings.statusCode,
          data: const [],
          statusMessage: AppTranslationString.string(ConstStrings.statusMessage),
        );
      }
      return ResponseAppViewImpl.fromMap(
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
        data: response.data['results'],
        pages: response.data['info']['pages'],
        count: response.data['info']['count'],
      );
    } catch (e) {
      return ResponseAppViewImpl.fromMap(
        statusCode: ConstStrings.statusCode,
        data: const [],
        statusMessage: e.toString(),
        pages: 0,
        count: 0,
      );
    }
  }
}
