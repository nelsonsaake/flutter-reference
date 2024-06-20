import 'package:dio/dio.dart';
import 'package:mytrotro/google_cloud/places/models/autocomplete_response.dart';
import 'package:retrofit/retrofit.dart';

part 'places_client.g.dart';

const placesApiBaseUrl = "https://maps.googleapis.com/maps/api/place";

@RestApi(baseUrl: placesApiBaseUrl)
abstract class PlacesClient {
  //...

  factory PlacesClient(Dio dio, {String baseUrl}) = _PlacesClient;

  @GET("/autocomplete/json")
  Future<AutocompleteResponse> autocomplete({
    @Query("key") String key = "",
    @Query("input") String input = "",
    @Query("types") String types = "",
  });
}
