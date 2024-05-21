import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sensor_tez/components/light_component.dart';
import 'package:sensor_tez/components/nem_component.dart';
import 'package:sensor_tez/components/temprature_component.dart';
import 'package:sensor_tez/pages/main_page.dart';
import 'package:sensor_tez/services/notification_service.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isFullMode = false;

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
      "name": "nem",
    }
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
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
                            width: MediaQuery.of(context).size.width / 2 - 20,
                            height: MediaQuery.of(context).size.width / 2 + 10,
                            child: TempratureComponent(),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Colors.white,
                            ),
                            padding: EdgeInsets.all(6),
                            width: MediaQuery.of(context).size.width / 2 - 20,
                            height: MediaQuery.of(context).size.width / 2 + 10,
                            child: NemComponent(),
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
                            width: MediaQuery.of(context).size.width / 2 - 20,
                            height: MediaQuery.of(context).size.width / 2 + 10,
                            child: LightComponent(),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Colors.white,
                            ),
                            padding: EdgeInsets.all(6),
                            width: MediaQuery.of(context).size.width / 2 - 20,
                            height: MediaQuery.of(context).size.width / 2 + 10,
                            child: NemComponent(),
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
        return TempratureComponent();
      case "nem":
        return NemComponent();
      case "isik":
        return LightComponent();
      default:
        return TempratureComponent();
    }
  }
}
