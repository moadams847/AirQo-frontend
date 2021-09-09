import 'package:app/constants/app_constants.dart';
import 'package:app/utils/pm.dart';
import 'package:app/widgets/help/aqi_index.dart';
import 'package:app/widgets/help/pollutant.dart';
import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  final int initialIndex;

  const HelpPage({Key? key, required this.initialIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: getInitialIndex(),
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(
                  child: Text(
                'AQI',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17),
              )),
              Tab(
                  child: Text(
                'PM 2.5',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17),
              )),
              Tab(
                  child: Text(
                'PM 10',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17),
              )),
              Tab(
                  child: Text(
                'Humidity',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17),
              )),
              Tab(
                  child: Text(
                'Temperature',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17),
              )),
            ],
          ),
          title: const Text(
            'Help Guides',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        body: TabBarView(
          children: [
            AqiDialog(),
            PollutantDialog(pollutantDetails(PollutantConstant.pm2_5)),
            PollutantDialog(pollutantDetails(PollutantConstant.pm10)),
            PollutantDialogV2(pollutantDetails(PollutantConstant.humidity)),
            PollutantDialogV2(pollutantDetails(PollutantConstant.temperature)),
          ],
        ),
      ),
    );
  }

  int getInitialIndex() {
    if (initialIndex > 4 || initialIndex < 0) {
      return 0;
    }
    return initialIndex;
  }
}
