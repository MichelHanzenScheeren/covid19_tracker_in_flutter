import 'package:covid19_tracker_in_flutter/presentation/historic/presentation_historic.dart';
import 'package:covid19_tracker_in_flutter/presentation/home/widget/widget_home.dart';
import 'package:covid19_tracker_in_flutter/presentation/home/widget/widget_title.dart';
import 'package:covid19_tracker_in_flutter/presentation/information/presentation_information.dart';
import 'package:covid19_tracker_in_flutter/presentation/search/presentation_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/covid.jpeg"), fit: BoxFit.cover),
          ),
          child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: <
                    Widget>[
              TitleHome(
                title: 'Covid-19',
                subtitle: 'Tracker in Flutter',
              ),
              OptionsHome(
                title: 'Informações',
                left: 10.0,
                top: 70.0,
                right: 10.0,
                down: 10.0,
                onClick: () => Get.to(Information()),
              ),
              OptionsHome(
                title: 'Parâmetro Geral',
                left: 10.0,
                top: 15.0,
                right: 10.0,
                down: 10.0,
                onClick: () => Get.to(Search()),
              ),
              OptionsHome(
                title: 'Pesquisas Favoritas',
                left: 10.0,
                top: 15.0,
                right: 10.0,
                down: 70.0,
                onClick: () => Get.to(Favorites()),
              )
            ]),
          )),
    );
  }
}
