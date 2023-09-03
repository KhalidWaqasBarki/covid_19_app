import 'package:covid_19_app/services/utilities/worldStatusApi.dart';
import 'package:covid_19_app/view/contries_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:pie_chart/pie_chart.dart';

import '../model/WorldStatusMdl.dart';
import '../services/utilities/worldStatusApi.dart';
import '../services/utilities/worldStatusApi.dart';
import '../services/utilities/worldStatusApi.dart';
import '../services/utilities/worldStatusApi.dart';

class WorldStatus extends StatefulWidget {
  const WorldStatus({super.key});

  @override
  State<WorldStatus> createState() => _WorldStatusState();
}

class _WorldStatusState extends State<WorldStatus>
     {
  @override
  Widget build(BuildContext context) {
    WorldStatusApi();
    final dim = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
          future: WorldStatusApi.WorldStatus(),
          builder: (context, AsyncSnapshot<WorldStatusModel?> snapshot) {
            if (!snapshot.hasData) {
              return const SafeArea(
                child: Expanded(

                  child: SpinKitFadingCircle(
                    color: Colors.white,
                    size: 50,
                  ),
                ),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: SingleChildScrollView(
                  child: Column(children: [
                    SizedBox(
                      height: dim.height * .01,
                    ),
                    Column(
                      children: [
                        PieChart(
                          chartValuesOptions:  ChartValuesOptions(
                            showChartValuesInPercentage: true,
                          ),
                          chartType: ChartType.ring,
                          chartRadius: dim.width / 3,
                          legendOptions: LegendOptions(
                            legendPosition: LegendPosition.left,
                          ),
                          animationDuration: Duration(seconds: 2),
                          dataMap: {
                            "Total":
                                double.parse(snapshot.data!.cases.toString()),
                            "Recovered": double.parse(
                                snapshot.data!.recovered.toString()),
                            "Deaths":
                                double.parse(snapshot.data!.deaths.toString())
                          },
                          colorList: const [
                            Colors.cyan,
                            Colors.green,
                            Colors.redAccent
                          ],
                        ),
                        SizedBox(
                          height: dim.height * 0.07,
                        ),
                        Card(
                          color: Colors.grey[600],
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                ReRow(
                                    text1: 'Total:',
                                    text2: snapshot.data!.cases!.toString()),
                                ReRow(
                                    text1: 'deaths:',
                                    text2: snapshot.data!.deaths!.toString()),
                                ReRow(
                                    text1: 'Recovered:',
                                    text2:
                                        snapshot.data!.recovered!.toString()),
                                ReRow(
                                    text1: 'Active:',
                                    text2: snapshot.data!.active!.toString()),
                                ReRow(
                                    text1: 'Critical:',
                                    text2: snapshot.data!.critical!.toString()),
                                ReRow(
                                    text1: 'Today Deaths:',
                                    text2:
                                        snapshot.data!.todayDeaths!.toString()),
                                ReRow(
                                    text1: 'Today Recovered:',
                                    text2: snapshot.data!.todayRecovered!
                                        .toString()),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: dim.height * 0.02),
                        InkWell(
                          onTap: () {
Navigator.push(context, MaterialPageRoute(builder: (c) => const CountriesList()
));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.lightGreenAccent,
                                borderRadius: BorderRadius.circular(15)),
                            width: dim.width * .8,
                            height: dim.height * 0.07,
                            child: const Center(
                                child: Text(
                              'Track Countries',
                              style: TextStyle(color: Colors.black),
                            )),
                          ),
                        )
                      ],
                    )
                  ]),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class ReRow extends StatelessWidget {
  final String text1;
  final String text2;
  ReRow({super.key, required this.text1, required this.text2});

  @override
  Widget build(BuildContext context) {
    final dim = MediaQuery.of(context).size;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text1,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                text2,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: dim.height * 0.01),
        Divider(
          thickness: 0.5,
        ),
      ],
    );
  }
}

/*



 */
