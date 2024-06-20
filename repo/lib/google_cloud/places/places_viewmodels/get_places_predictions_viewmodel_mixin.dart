import 'package:mytrotro/google_cloud/places/places_services/places_services.dart';
import 'package:stacked/stacked.dart';

mixin GetPlacesPredictionsViewModelMixin on BaseViewModel {
  //...

  List<String> _predictions = [];

  List<String> get predictions => _predictions;

  Future _getPlacesPredictions(String input, String location) async {
    _predictions = await PlacesService.placesPrediction(input, location);
    return _predictions;
  }

  Future getPlacesPredictions(String input, String location) {
    return runBusyFuture(_getPlacesPredictions(input, location));
  }

  Future getPlacesPredictionsQuietly(String input, String location) {
    return _getPlacesPredictions(input, location);
  }
}
