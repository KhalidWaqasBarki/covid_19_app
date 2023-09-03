import 'package:covid_19_app/services/utilities/worldStatusApi.dart';
import 'package:covid_19_app/view/contries_detail.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesList extends StatefulWidget {
  const CountriesList({super.key});

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  TextEditingController SearchCon = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: SearchCon,
                onChanged: (v) {
                  setState(() {});
                },
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    hintText: 'Search a Country',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0))),
              ),
            ),
            Expanded(
                child: FutureBuilder(
                    future: WorldStatusApi.CountriesListApi(),
                    builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                      if (!snapshot.hasData) {
                        return ListView.builder(
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return Shimmer.fromColors(
                                  baseColor: Colors.white12,
                                  highlightColor: Colors.white,
                                  child: Column(
                                    children: [
                                      ListTile(
                                        title: Container(
                                          height: 10,
                                          width: 90,
                                          color: Colors.white,
                                        ),
                                        subtitle: Container(
                                          height: 10,
                                          width: 90,
                                          color: Colors.white,
                                        ),
                                        leading: Container(
                                          height: 70,
                                          width: 70,
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ));
                            });
                      } else {
                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              final snap = snapshot.data![index];
                              String name = snapshot.data![index]['country'];
                              if (SearchCon.text.isEmpty) {
                                return Column(
                                  children: [
                                    Card(
                                      color: Colors.grey[600],
                                      child: InkWell(
                                        splashColor: Colors.grey,
                                        onTap: () {
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=> CountryDetail(

                                            name: snap['country'],
                                            image: snap['countryInfo']['flag'],
                                            totalcase: snap['cases'],
                                              totaldeaths: snap['deaths'],
                                            recovered: snap['recovered'],

                                            

                                          )));

                                        },
                                        child: ListTile(
                                            title: Text(
                                              snapshot.data![index]['country'],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            subtitle: Text("Cases: " +
                                                snapshot.data![index]['cases']
                                                    .toString()),
                                            leading: Image(
                                                height: 70,
                                                width: 70,
                                                image: NetworkImage(snapshot
                                                        .data![index]
                                                    ['countryInfo']['flag']))),
                                      ),
                                    )
                                  ],
                                );
                              } else if (name
                                  .toLowerCase()
                                  .contains(SearchCon.text.toLowerCase())) {
                                return Column(
                                  children: [
                                    Card(
                                      color: Colors.grey[600],
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      CountryDetail(
                                                        name: snap['country'],
                                                        image: snap['countryInfo']['flag'],
                                                        totalcase: snap['cases'],
                                                        totaldeaths: snap['deaths'],
                                                        recovered: snap['recovered'],

                                                      )));
                                        },
                                        child: ListTile(
                                            title: Text(snapshot.data![index]
                                                ['country']),
                                            subtitle: Text("Cases: " +
                                                snapshot.data![index]['cases']
                                                    .toString()),
                                            leading: Image(
                                                height: 70,
                                                width: 70,
                                                image: NetworkImage(snapshot
                                                        .data![index]
                                                    ['countryInfo']['flag']))),
                                      ),
                                    )
                                  ],
                                );
                              } else
                                return Container();
                            });
                      }
                    }))
          ],
        ),
      ),
    );
  }
}
