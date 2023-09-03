import 'package:covid_19_app/view/worldstatus.dart';
import 'package:flutter/material.dart';

class CountryDetail extends StatelessWidget {
  late String image, name;
  late int totalcase, totaldeaths, recovered;

  CountryDetail({
    required this.image,
    required this.name,
    required this.totalcase,
    required this.totaldeaths,
    required this.recovered,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Padding(
                  padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.070),
                  child: Card(
                      color: Colors.grey[600],
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(

                          children: [
                            ReRow(text1: 'Total:', text2: totalcase.toString()),
                            ReRow(text1: 'deaths:', text2: totaldeaths.toString()),
                            ReRow(text1: 'Recovered:', text2: recovered.toString()),
                          ],
                        ),
                      )),
                ),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(image),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
