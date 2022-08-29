
import 'package:applocation/modules/home/domain/entities/network/response_appview.dart';
import 'package:applocation/modules/home/infra/models/appview_impl.dart';

class ResponseAppViewImpl extends ResponseAppView {
   ResponseAppViewImpl({
    statusCode,
    statusMessage,
    errorMessage,
    count,
    pages,
    required model,
  }) : super(
          count: count,
          pages: pages,
          model: model,
          errorMessage: errorMessage,
          statusMessage: statusMessage,
          statusCode: statusCode,
        );

  factory ResponseAppViewImpl.fromMap({    List<dynamic>? data,
    int? statusCode,
    String? statusMessage,
    String? errorMessage,
    int? count,
    int? pages,}) {
    return ResponseAppViewImpl(
      count: count,
      pages: pages,
      model: data?.map<AppViewImpl>((data) => AppViewImpl.fromMap(data)).toList() ?? [],
      statusCode: statusCode,
      statusMessage: statusMessage,
      errorMessage: errorMessage,
    );
  }
  

}
