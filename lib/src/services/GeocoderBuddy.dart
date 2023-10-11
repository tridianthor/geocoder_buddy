import 'package:geocoder_buddy/geocoder_buddy.dart';
import 'package:geocoder_buddy/src/models/MapData.dart';
import 'package:geocoder_buddy/src/services/NetworkService.dart';

class GeocoderBuddy {
  static Future<List<GBSearchData>?> query(String address) async {
    var data = await NetworkService.searhAddress(address);
    if (data != null) {
      return bgSearchDataFromJson(mapDataToJson(data));
    } else {
      return null;
    }
  }

  static Future<GBData?> searchToGBData(GBSearchData data) async {
    if (data.lat != null && data.lon != null) {
      var pos = GBLatLng(
          lat: double.tryParse(data.lat!), lng: double.parse(data.lon!));
      var res = await NetworkService.getDetails(pos);
      return res;
    } else {
      return null;
    }
  }

  static Future<GBData?> findDetails(GBLatLng pos) async {
    var data = await NetworkService.getDetails(pos);
    return data;
  }
}
