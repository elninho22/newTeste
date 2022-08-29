
import 'package:applocation/core/services/location_app_service_imp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart' as goa;



class LocationAppService implements LocationAppServiceImp {
  Future<LocationData?> getLocationAppService() async {
    final Location location = Location();
    try {
      final LocationData _locationResult = await location.getLocation();
      if (_locationResult != null) {
        return _locationResult;
      }
      return null;
    } on PlatformException catch (e) {
      debugPrint('${e}');
      return null;
    }
  }
  Future<goa.Placemark?> getPlaceMark({required LocationData locationData}) async {
    final List<goa.Placemark>? placeMarks = await goa.placemarkFromCoordinates(locationData.latitude!, locationData.longitude!);
    if(placeMarks != null && placeMarks.isNotEmpty){
      return placeMarks[0];
    }

    return null;
  }

}
