import 'package:tempo_template/services/location.dart';
import 'package:tempo_template/services/networking.dart';

class WeatherModel {

  Future<dynamic> getLocationWeather() async {

    const apiKey = 'a1ee7dd673ed4bb8bce021e5bccd552e';
    const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';

    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper('$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}'
        '&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();
    return weatherData;
  }
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'É tempo de 🍦';
    } else if (temp > 20) {
      return 'O tempo está bom para bermuda e 👕';
    } else if (temp < 10) {
      return 'Você precisará de 🧣 e 🧤';
    } else {
      return 'Leve um 🧥';
    }
  }
}