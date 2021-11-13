//call http request in flutter
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather/model/weather_model.dart';

class WeatherApiClient {
  Future<Weather>? getCurrentWeather(String? location) async {
    var endpoint = Uri.parse(
        "api.openweathermap.org/data/2.5/weather?q=$location&appid=1b354bd7cee77ffe0315911d722601ea&units=metric");
    var response = await http.get(endpoint);
    var body = jsonDecode(response.body);
    return Weather.fromJson(body);
  }
}
