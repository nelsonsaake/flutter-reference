import 'package:dio/dio.dart';
import 'package:mytrotro/google_cloud/places/models/autocomplete_response.dart';
import 'package:mytrotro/google_cloud/places/places_client/places_client.dart';

class PlacesService {
  //...

  static const _key = "";

  static const _scope = ["locality", "address", "sublocality"];

  static const _minAllowableResults = 4;

  static String _latestInput = "";

  static final Map<String, List<String>> _responses = {};

  static Future<List<String>?> _placesPrediction(String input) async {
    // results
    final res = <String>[];

    // search accross all scopes
    for (final types in _scope) {
      // seaching accross all scopes can take time,
      // so if the input changes stop searching, and throw away the result
      if (input != _latestInput) {
        return null;
      }

      // make client
      final client = PlacesClient(Dio());

      // hit the server
      final response = await client.autocomplete(
        input: _latestInput,
        key: _key,
        types: types,
      );

      // extract the useful part of the response
      for (Predictions v in response.predictions ?? []) {
        final description = v.description;
        if (description != null) {
          res.add(description);
        }
      }

      // if we have a minimum allowable, break
      if (res.length >= _minAllowableResults) {
        break;
      }
    }

    return res;
  }

  static Future<List<String>> placesPrediction(
    String input,
    String location,
  ) async {
    //...

    // if the input is empty, do nothin
    if (input.trim().isEmpty) {
      return [];
    }

    // final touch ups to the input
    if (!input.toLowerCase().endsWith(", ghana")) {
      input += ", ghana";
    }

    // update the latest input
    // this will stop all background searches, with stale input
    _latestInput = input;

    // see if we already search for this input
    List<String>? res = _responses[input];

    // if we have some existing result, return them
    if (res != null) {
      return res;
    } else {
      res = <String>[];
    }

    // run get actual predictions, in the background
    res = await _placesPrediction(input);

    // save result for reuse
    if (res != null) {
      _responses[input] = res;
    }

    return res ?? [];
  }
}
