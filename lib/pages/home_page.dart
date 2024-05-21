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
import 'package:sensor_tez/pages/main_page.dart';
import 'package:sensor_tez/services/notification_service.dart';
import 'package:tailwind_colors/tailwind_colors.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Timer? _timer;
  bool isFullMode = false;
  dynamic data = {
    "temperature": 0,
    "air_quality": 0,
    "humidity": 0,
    "light": 0,
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
    _timer?.cancel(); // Timer'ı iptal et
    super.dispose();
  }

  getData() {
    http.get(Uri.parse("http://192.168.12.144/get-data")).then((res) => {
          setState(() {
            data = jsonDecode(res.body);
          }),
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: data["light"] == 0
          ? Center(
            child: Lottie.asset('assets/animations/loading.json', width: MediaQuery.of(context).size.width/2, height: MediaQuery.of(context).size.width/2),
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
      default:
        return TempratureComponent(
          isCardView: !isFullMode,
          data: data["air_quality"],
        );
    }
  }
}
