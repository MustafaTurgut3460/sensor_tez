import 'dart:async';
import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:sensor_tez/components/air_component.dart';
import 'package:sensor_tez/components/light_component.dart';
import 'package:sensor_tez/components/nem_component.dart';
import 'package:sensor_tez/components/temprature_component.dart';
import 'package:sensor_tez/components/volt_component.dart';
import 'package:sensor_tez/models/notification.dart';
import 'package:sensor_tez/models/sensor_data.dart';
import 'package:sensor_tez/services/storage_service.dart';
import 'package:tailwind_colors/tailwind_colors.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Timer _timer;
  bool isFullMode = false;
  dynamic data = {
    "temperature": 0,
    "air_quality": 0,
    "humidity": 0,
    "light": 0,
    "watt": 0,
  };

  final graphItems = [
    {
      "id": "1",
      "name": "sicaklik",
    },
    {
      "id": "2",
      "name": "nem",
    },
    {
      "id": "3",
      "name": "isik",
    },
    {
      "id": "4",
      "name": "hava",
    },
    {
      "id": "4",
      "name": "watt",
    }
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      getData();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  getData() {
    http.get(Uri.parse("http://172.20.10.3/get-data")).then((res) => {
          setState(() {
            data = jsonDecode(res.body);
          }),
          writeData(res.body),
        });
    // setState(() {
    //   data = {
    //     "temperature": 29,
    //     "air_quality": 345,
    //     "humidity": 65,
    //     "light": 500,
    //     "watt": 1.7,
    //   };
    // });

    // writeData({
    //   "temperature": 29,
    //   "air_quality": 345,
    //   "humidity": 65,
    //   "light": 500,
    //   "watt": 1.7,
    // });
  }

  void writeData(data) async {
    insertSensorData(
      SensorData(
        temperature: double.parse(data["temperature"].toString()),
        air_quality: double.parse(data["air_quality"].toString()),
        humidity: double.parse(data["humidity"].toString()),
        light: double.parse(data["light"].toString()),
        watt: double.parse(data["watt"].toString()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: 1 == 0
          ? Center(
              child: Lottie.asset('assets/animations/loading.json',
                  width: MediaQuery.of(context).size.width / 2,
                  height: MediaQuery.of(context).size.width / 2),
            )
          : Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Ana Sayfa",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () => {
                              setState(() {
                                isFullMode = true;
                              })
                            },
                            child: SvgPicture.asset(
                              'assets/icons/full.svg',
                              color: TW3Colors.gray.shade400,
                              width: 22,
                              height: 22,
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          InkWell(
                            onTap: () => {
                              setState(() {
                                isFullMode = false;
                              })
                            },
                            child: SvgPicture.asset(
                              'assets/icons/split.svg',
                              color: TW3Colors.gray.shade400,
                              width: 24,
                              height: 24,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  isFullMode
                      ? CarouselSlider(
                          options: CarouselOptions(height: 300.0),
                          items: graphItems.map((i) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Container(
                                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color: Colors.white,
                                  ),
                                  padding: EdgeInsets.all(12),
                                  child: getComponent(i["name"]!),
                                );
                              },
                            );
                          }).toList(),
                        )
                      : Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color: Colors.white,
                                  ),
                                  padding: EdgeInsets.all(6),
                                  width: MediaQuery.of(context).size.width / 2 -
                                      20,
                                  height:
                                      MediaQuery.of(context).size.width / 2 +
                                          10,
                                  child: AirComponent(
                                    data: data["temperature"],
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color: Colors.white,
                                  ),
                                  padding: EdgeInsets.all(6),
                                  width: MediaQuery.of(context).size.width / 2 -
                                      20,
                                  height:
                                      MediaQuery.of(context).size.width / 2 +
                                          10,
                                  child: NemComponent(
                                    data: data["humidity"],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color: Colors.white,
                                  ),
                                  padding: EdgeInsets.all(6),
                                  width: MediaQuery.of(context).size.width / 2 -
                                      20,
                                  height:
                                      MediaQuery.of(context).size.width / 2 +
                                          10,
                                  child: LightComponent(
                                    data: data["light"],
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color: Colors.white,
                                  ),
                                  padding: EdgeInsets.all(6),
                                  width: MediaQuery.of(context).size.width / 2 -
                                      20,
                                  height:
                                      MediaQuery.of(context).size.width / 2 +
                                          10,
                                  child: TempratureComponent(
                                    isCardView: !isFullMode,
                                    data: data["air_quality"],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color: Colors.white,
                                  ),
                                  padding: EdgeInsets.all(6),
                                  width: MediaQuery.of(context).size.width / 2 -
                                      20,
                                  height:
                                      MediaQuery.of(context).size.width / 2 +
                                          10,
                                  child: VoltComponent(
                                    data: data["watt"],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                ],
              ),
            ),
    );
  }

  Widget getComponent(String name) {
    switch (name) {
      case "sicaklik":
        return AirComponent(
          data: data["temperature"],
        );
      case "nem":
        return NemComponent(
          data: data["humidity"],
        );
      case "isik":
        return LightComponent(
          data: data["light"],
        );
      case "hava":
        return TempratureComponent(
          isCardView: !isFullMode,
          data: data["air_quality"],
        );

      case "watt":
        return VoltComponent(
          data: data["watt"],
        );
      default:
        return TempratureComponent(
          isCardView: !isFullMode,
          data: data["air_quality"],
        );
    }
  }
}
