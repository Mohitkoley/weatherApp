import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather/services/weather_api_client.dart';
import 'package:weather/views/additional_information.dart';
import 'package:weather/model/weather_model.dart';
import 'views/current_weather.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static const TextStyle bodyText5 = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w300,
    color: Color.fromRGBO(170, 174, 180, 1.0),
  );

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: bodyText5,
            ),
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        textTheme: ThemeData.dark().textTheme.copyWith(
              bodyText2: const TextStyle(
                color: Colors.cyanAccent,
              ),
              bodyText1: bodyText5,
            ),
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          color: Colors.cyanAccent,
        ),
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WeatherApiClient client = WeatherApiClient();
  Weather? data;
  Future<void> getData() async {
    data = await client.getCurrentWeather("London");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Weather App",
          style: GoogleFonts.dosis(
              color: Colors.black,
              textStyle: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w900,
              )),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(EvaIcons.menu2),
        ),
      ),
      body: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                const SizedBox(
                  height: 10,
                ),
                currentWeather(Icons.wb_sunny_rounded, "${data?.temp ?? 0}",
                    "${data?.cityName ?? 0}"),
                const SizedBox(
                  height: 60.0,
                ),
                const Text(
                  "Additional Informantion",
                  style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.lightBlueAccent,
                      fontWeight: FontWeight.bold),
                ),
                const Divider(),
                const SizedBox(
                  height: 20.0,
                ),
                additionalInformation(
                    "${data?.wind ?? 0}",
                    "${data?.humidity ?? 0}",
                    "${data?.pressure ?? 0}",
                    "${data?.feels_like ?? 0}"),
              ]);
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.connectionState == ConnectionState.none) {
              return const Center(
                child: Text("No Internet Connection"),
              );
            }
            return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  currentWeather(Icons.wb_sunny_rounded, "${data?.temp ?? 0}",
                      "${data?.cityName ?? 0}"),
                  const SizedBox(
                    height: 60.0,
                  ),
                  const Text(
                    "Additional Informantion",
                    style: TextStyle(
                        fontSize: 24.0,
                        color: Colors.lightBlueAccent,
                        fontWeight: FontWeight.bold),
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 20.0,
                  ),
                  additionalInformation(
                      "${data?.wind ?? 0}",
                      "${data?.humidity ?? 0}",
                      "${data?.pressure ?? 0}",
                      "${data?.feels_like ?? 0}"),
                ]);
          }),
    );
  }
}
