import 'package:flutter/material.dart';
import 'package:flutter_application_2/Model/worldstates_api_model.dart';
import 'package:flutter_application_2/Services/api_data_fetch.dart';
import 'package:flutter_application_2/contrieslist_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStateScreen extends StatefulWidget {
  const WorldStateScreen({super.key});

  @override
  State<WorldStateScreen> createState() => _WorldStateScreenState();
}

class _WorldStateScreenState extends State<WorldStateScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: const Duration(seconds: 3))
        ..repeat();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  final colorlist = [
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246)
  ];

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices =
        StatesServices(); //class where we fetched the api data into a variable
    return Scaffold(
        body: SafeArea(
      child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              FutureBuilder(
                //to show the api data
                future: statesServices
                    .fetchWorldStatesRecords(), //the function of the class for fetching the data
                builder: (context, AsyncSnapshot<WorldstatesModel> snapshot) {
                  if (!snapshot.hasData) {
                    return Expanded(
                      flex: 1,
                      child: SpinKitFadingCircle(
                        color: Colors.white,
                        size: 50.0,
                        controller: _controller,
                      ),
                    );
                  } else {
                    return Column(
                      children: [
                        PieChart(
                          dataMap: {
                            'Total':
                                double.parse(snapshot.data!.cases!.toString()),
                            'Recovered': double.parse(
                                snapshot.data!.recovered!.toString()),
                            'Deaths':
                                double.parse(snapshot.data!.deaths!.toString())
                          },
                          chartValuesOptions: const ChartValuesOptions(
                              //for showing the charts values in percentage
                              showChartValuesInPercentage: true),
                          animationDuration: const Duration(milliseconds: 1200),
                          chartType: ChartType.ring,
                          colorList: colorlist,
                          legendOptions: const LegendOptions(
                              legendPosition: LegendPosition.left),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical:
                                  MediaQuery.of(context).size.height * 0.06),
                          child: Card(
                            child: Column(children: [
                              reusableRow(
                                  title: 'Total',
                                  value: snapshot.data!.cases.toString()),
                              reusableRow(
                                  title: 'Deaths',
                                  value: snapshot.data!.deaths.toString()),
                              reusableRow(
                                  title: 'Recovered',
                                  value: snapshot.data!.recovered.toString()),
                              reusableRow(
                                  title: 'Active',
                                  value: snapshot.data!.active.toString()),
                              reusableRow(
                                  title: 'Critical',
                                  value: snapshot.data!.critical.toString()),
                              reusableRow(
                                  title: 'Today Deaths',
                                  value: snapshot.data!.todayDeaths.toString()),
                              reusableRow(
                                  title: 'Today Recovered',
                                  value:
                                      snapshot.data!.todayRecovered.toString()),
                            ]),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const contries_list_screen(),
                                ));
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                color: const Color(0xff1aa260),
                                borderRadius: BorderRadius.circular(10)),
                            child: const Center(child: Text('Track Countries')),
                          ),
                        )
                      ],
                    );
                  }
                },
              ),
            ],
          )),
    ));
  }
}

class reusableRow extends StatelessWidget {
  String title, value;
  reusableRow({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(title), Text(value)],
          ),
          const SizedBox(
            height: 5,
          ),
          const Divider()
        ],
      ),
    );
  }
}
