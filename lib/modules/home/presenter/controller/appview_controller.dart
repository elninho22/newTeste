import 'dart:async';
import 'dart:math';
import 'package:vector_math/vector_math.dart';
import 'package:applocation/core/enum/application_loading.dart';
import 'package:applocation/core/logger/application_print_logger.dart';
import 'package:applocation/core/network/check_connecting_network.dart';
import 'package:applocation/core/network/query_parameters.dart';
import 'package:applocation/core/services/location_app_service.dart';
import 'package:applocation/core/services/location_service.dart';
import 'package:applocation/lang/app_translation.dart';
import 'package:applocation/modules/debug_view/controllers/debug_view_controller.dart';
import 'package:applocation/modules/debug_view/models/debug_log_item.dart';
import 'package:applocation/modules/home/domain/entities/network/response_appview.dart';
import 'package:applocation/modules/home/external/datasource/appview_datasource_impl.dart';
import 'package:applocation/modules/home/infra/models/appview_impl.dart';
import 'package:applocation/modules/home/presenter/widgets/snack_bar_success.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';

class AppViewController extends GetxController {
  final AppViewDatasourceImpl request;
  final LocationAppService locationApp;
  final CheckConnectingNetwork connectivityStore;
  final DebugViewController? debugViewController;
  final LocationService? serviceLocation;

  AppViewController({required this.request, required this.connectivityStore, required this.locationApp, this.debugViewController, this.serviceLocation});

  final RxList<AppViewImpl> listAppViews = RxList<AppViewImpl>();
  final RxBool _pagination = RxBool(false);

  final Rx<ApplicationLoading> isLoading = Rx<ApplicationLoading>(ApplicationLoading.notLoading);

  //variables itens
  final RxBool _isLoadingPagination = RxBool(false);
  final RxInt _pageNext = RxInt(1);
  static const _loadMorePageConst = 0.9;
  final RxInt _page = RxInt(1);
  static const _index = 9999999;

  // final ValueNotifier<StatusLoading> isLoading = ValueNotifier(StatusLoading.notLoading);
  final RxList<AppViewImpl> listResult = RxList<AppViewImpl>([]);
  final RxInt isExpandedIndex = RxInt(_index);

  //variables location
  final RxDouble lat = RxDouble(0);
  final RxDouble lon = RxDouble(0);
  final RxString country = RxString('');
  final RxString adminArea = RxString('');
  final RxString street = RxString('');
  final RxString numberStreet = RxString('');
  final RxString setCountry = RxString('');
  final RxString setAdminArea = RxString('');
  final RxString setStreet = RxString('');
  final RxString setNumberStreet = RxString('');
  final RxDouble latLocation = RxDouble(0);
  final RxDouble lonLocation = RxDouble(0);
  final RxDouble distanceKm = RxDouble(0);
  final RxDouble updateKm = RxDouble(0);
  final RxString setCep = RxString('');

  @override
  void onInit() async {
    getLocaltionOperation();
    setLocationOperation();
    super.onInit();
  }

  void Function(int, bool)? expansionCallback(int index, bool isExpanded) {
    if (isExpanded) {
      isExpandedIndex.value = _index;
    } else {
      isExpandedIndex.value = index;
    }
    return null;
  }

  String dateFormat(String? dataLocal) {
    try {
      if (dataLocal == null) return "--";
      DateTime d = DateTime.parse(dataLocal.toString());
      return "${d.day}/${d.month}/${d.year} ás ${d.hour}:${d.minute}";
    } catch (e) {
      return "--";
    }
  }

  getFirst({isFirst = false}) async {
    if (isFirst) {
      isLoading.value = ApplicationLoading.shimmerLoading;
    } else {
      isLoading.value = ApplicationLoading.fullLoading;
    }
    _pageNext.value = _page.toInt();
    listResult.clear();
    await _getDataCharacter();
  }

  _getDataCharacter() async {
    try {
      bool isConnected = await connectivityStore.appCheckConnectivity();
      if (!isConnected) {
        isLoading.value = ApplicationLoading.notConnecting;
        snackBarWarning(text: 'failure_network');
        return;
      }

      QueryParameters parameters = QueryParameters(page: _pageNext.value);
      ResponseAppView resp = await request.appViewDatasource(parameters: parameters);
      bool status = resp.statusCode == 200;

      if (!status) {
        isLoading.value = ApplicationLoading.notLoading;
        snackBarWarning(text: '${AppTranslationString.string('message_problem_list_data_server')}. ${resp.statusCode} - ${resp.statusMessage}');
        return;
      }

      // Evita ficar enviando consulta no scroll
      if ((resp.model?.isEmpty ?? false) && listResult.value.isNotEmpty) {
        _isLoadingPagination.value = true;
        snackBarSuccess(text: 'message_list_all_items');
        return;
      }

      if (resp.model?.isNotEmpty ?? false) {
        List<AppViewImpl>? _data = resp.model as List<AppViewImpl>;
        if (_data.isNotEmpty) listResult.value.addAll(_data);
      }
      isLoading.value = ApplicationLoading.notLoading;
      _pageNext.value = _pageNext.value + 1;
    } catch (e) {
      isLoading.value = ApplicationLoading.notLoading;
      snackBarWarning(text: '${AppTranslationString.string('message_problem_list_data_server')} $e');
      debugPrint("Não foi possível listar os registros cadastrados, $e");
    }
  }

  onScroll(double scrollPosition, double scrollMax) async {
    if (_isLoadingPagination.value) return;
    if (scrollPosition > scrollMax * _loadMorePageConst) {
      _isLoadingPagination.value = false;
      await getNextPage();
    }
  }

  getNextPage() async {
    if (isLoading.value != ApplicationLoading.notLoading) return;
    isLoading.value = ApplicationLoading.nextPageLoading;
    await _getDataCharacter();
  }

  swipeRefresh() async {
    await getFirst(isFirst: true);
  }

  setLocationOperation() async {
    latLocation.value = -23.55302;
    lonLocation.value = -46.43135;

    final placeMarkSet = await serviceLocation?.getPlaceMarkSet(
      latData: latLocation.value,
      lonData: lonLocation.value,
    );

    setCep.value = placeMarkSet?.postalCode ?? '--';
    setCountry.value = placeMarkSet?.country ?? '--';
    setAdminArea.value = placeMarkSet?.administrativeArea ?? '--';
    setStreet.value = placeMarkSet?.street ?? '--';
    setNumberStreet.value = placeMarkSet?.subThoroughfare ?? '--';
  }

  double distanceBetweenSet(
    double startLatitude,
    double startLongitude,
    double endLatitude,
    double endLongitude,
  ) {
    var earthRadius = 6378137.0;
    var dLat = _toRadiansSet(endLatitude - startLatitude);
    var dLon = _toRadiansSet(endLongitude - startLongitude);

    var a = pow(sin(dLat / 2), 2) + pow(sin(dLon / 2), 2) * cos(_toRadiansSet(startLatitude)) * cos(_toRadiansSet(endLatitude));
    var c = 2 * asin(sqrt(a));

    var x = earthRadius * c;
    distanceKm.value = x;

    return x;
  }

  static _toRadiansSet(double degree) {
    return degree * pi / 180;
  }

  double bearingBetweenSet(
    double startLatitude,
    double startLongitude,
    double endLatitude,
    double endLongitude,
  ) {
    var startLongitudeRadians = radians(startLongitude);
    var startLatitudeRadians = radians(startLatitude);
    var endLongitudeRadians = radians(endLongitude);
    var endLatitudeRadians = radians(endLatitude);

    var y = sin(endLongitudeRadians - startLongitudeRadians) * cos(endLatitudeRadians);
    var x = cos(startLatitudeRadians) * sin(endLatitudeRadians) - sin(startLatitudeRadians) * cos(endLatitudeRadians) * cos(endLongitudeRadians - startLongitudeRadians);

    updateKm.value = degrees(atan2(y, x));

    return degrees(atan2(y, x));
  }

  getLocaltionOperation() async {
    LocationData? _locationOp = await locationApp.getLocationAppService();
    if (_locationOp != null) {
      ApplicationPrintLogger.i('Localizacao ===> LAT: ${_locationOp.latitude!} -- LON: ${_locationOp.longitude!}', name: 'getLocation');
      lat.value = _locationOp.latitude!;
      lon.value = _locationOp.longitude!;

      final placeMark = await serviceLocation?.getPlaceMark(locationData: _locationOp);

      country.value = placeMark?.country ?? '--';
      adminArea.value = placeMark?.administrativeArea ?? '--';
      street.value = placeMark?.thoroughfare ?? '--';
      numberStreet.value = placeMark?.subThoroughfare ?? '--';

      var item = DebugLogItem(dataPost: 'RetornoAPI', baseUrl: 'https://teste.com', path: '/consulta', method: 'GET', type: 'REQUISIÇÃO');

      await Future.delayed(const Duration(seconds: 1));
      item = item.copyWith(type: 'RESPONSE', statusCode: '200', body: 'Latitude: ${lat.value} Longitude: ${lon.value}');
      debugViewController!.addLog(item);
    }
  }
}
