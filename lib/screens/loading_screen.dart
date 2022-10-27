import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tempo_template/services/location.dart';

const apiKey = 'dc3ad9b62b4a017e9610e8fcdccaa692';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  void getData() async {
    var url = Uri.parse('https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric');
    http.Response response = await http.get(url);

    if (response.statusCode == 200) { // se a requisição foi feita com sucesso
      var data = response.body;
      var jsonData = jsonDecode(data);

      var city = jsonData['name'];
      var temperature = jsonData['main']['temp'];
      var weather = jsonData['weather'][0]['id'];
      print('--------------------------------------------------------------');
      print('cidade: $city, temperatura: $temperature, condição: $weather');

    } else {
      print(response.statusCode);  // senão, imprima o código de erro
    }
  }

  late double latitude;
  late double longitude;

  Future<void> getLocation() async {
    var location = Location();
    await location.getCurrentLocation();

    latitude = location.latitude;
    longitude = location.longitude;

    getData();
  }

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  Widget build(BuildContext context) {
    getData();
    return Scaffold();
  }
}
