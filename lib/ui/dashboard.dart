import 'package:coinedone/blocs/dataBloc/dataBloc.dart';
import 'package:coinedone/blocs/dataBloc/dataEvent.dart';
import 'package:coinedone/blocs/dataBloc/dataState.dart';
import 'package:coinedone/models/data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  DataBloc dataBloc;

  String durationToString(int minutes) {
    var d = Duration(minutes: minutes);
    List<String> parts = d.toString().split(':');
    if (parts[0] == '0') {
      return ' ${parts[1].padLeft(
        2,
      )}m';
    } else if (parts[1] == '00') {
      return '${parts[0].padLeft(
        2,
      )}hr';
    } else {
      return '${parts[0].padLeft(
        2,
      )}hr ${parts[1].padLeft(2, '0')}m';
    }
  }

  @override
  void initState() {
    super.initState();
    dataBloc = BlocProvider.of<DataBloc>(context);
    dataBloc.add(FetchDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              width: 30,
              height: 30,
              decoration:
                  BoxDecoration(color: Colors.red[100], shape: BoxShape.circle),
            ),
            Text(
              "Michael",
              style: TextStyle(color: Colors.black),
            ),
            Spacer(),
            Icon(
              Icons.settings_outlined,
              color: Colors.black,
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: BlocBuilder<DataBloc, DataState>(
            builder: (context, state) {
              if (state is DataInitialState) {
                return Center(child: Text("initial"));
              } else if (state is DataLoadingState) {
                return Center(child: CircularProgressIndicator());
              } else if (state is DataLoadedState) {
                return dashboard(height, width, state);
              } else if (state is DataErrorState) {
                return Center(child: Text(state.message));
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }

  Container dashboard(double height, double width, DataLoadedState state) {
    return Container(
                child: Column(
                  children: [
                    Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.all(20),
                        child: Text(
                          "Dashboard",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        )),
                    Container(
                      height: height / 4,
                      width: width,
                      color: Colors.white,
                      margin: EdgeInsets.only(bottom: 10),
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: height / 10),
                                alignment: Alignment.center,
                                child: Text(
                                  "Total",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ),
                              Text(
                                "${durationToString(int.parse(state.data.chartData.totalTime.total))}",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                          PieChart(
                            PieChartData(
                                borderData: FlBorderData(
                                  show: false,
                                ),
                                sectionsSpace: 0,
                                centerSpaceRadius: 80,
                                sections: List.generate(3, (i) {
                                  final fontSize = 16.0;
                                  final radius = 15.0;
                                  switch (i) {
                                    case 0:
                                      return PieChartSectionData(
                                        showTitle: false,
                                        color: const Color(0xff0293ee),
                                        value: double.parse(state
                                            .data.chartData.classTime.total),
                                        radius: radius,
                                      );
                                    case 1:
                                      return PieChartSectionData(
                                        showTitle: false,
                                        color: const Color(0xfff8b250),
                                        value: double.parse(state
                                            .data.chartData.studyTime.total),
                                        radius: radius,
                                      );
                                    case 2:
                                      return PieChartSectionData(
                                        showTitle: false,
                                        color: const Color(0xFF00E676),
                                        value: double.parse(state
                                            .data.chartData.freeTime.total),
                                        radius: radius,
                                      );
                                    default:
                                      throw Error();
                                  }
                                })),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Spacer(),
                        Container(
                          margin: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.all(5),
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                        color: Colors.blue,
                                        shape: BoxShape.circle),
                                  ),
                                  Text("class")
                                ],
                              ),
                              Container(
                                  margin: EdgeInsets.only(left: 30),
                                  child: Text(
                                    "${durationToString(int.parse(state.data.chartData.classTime.total))}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ))
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.all(5),
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                        color: Color(0xfff8b250),
                                        shape: BoxShape.circle),
                                  ),
                                  Text("Study")
                                ],
                              ),
                              Container(
                                  margin: EdgeInsets.only(left: 10),
                                  child: Text(
                                    "${durationToString(int.parse(state.data.chartData.studyTime.total))}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ))
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.all(5),
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                        color: Color(0xFF00E676),
                                        shape: BoxShape.circle),
                                  ),
                                  Text("Free time")
                                ],
                              ),
                              Container(
                                  margin: EdgeInsets.only(left: 20),
                                  child: Text(
                                    "${durationToString(int.parse(state.data.chartData.classTime.total))}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ))
                            ],
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                    DividerLine(),
                    Container(
                      margin: EdgeInsets.all(20),
                      alignment: Alignment.center,
                      child: Text(
                        "Free Time Usage",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                left: width / 5, right: width / 5, bottom: 5),
                            child: Row(
                              children: [Text("Used"), Spacer(), Text("Max")],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: width / 5, right: width / 5),
                            child: Row(
                              children: [
                                Text(
                                  "${state.data.chartData.freeTime.total}m",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green),
                                ),
                                Spacer(),
                                Text(
                                  "${durationToString(int.parse(state.data.freeTimeMaxUsage))}",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.only(left: width / 9, right: width / 9),
                      child: SliderTheme(
                        data: SliderThemeData(
                            disabledActiveTrackColor: Colors.green,
                            inactiveTrackColor: Colors.grey[300],
                            activeTrackColor: Colors.green,
                            thumbColor: Colors.green,
                            trackHeight: 20,
                            thumbShape: RoundSliderThumbShape(
                                enabledThumbRadius: 0.0)),
                        child: Slider(
                          min: 0,
                          max: double.parse(state.data.freeTimeMaxUsage),
                          value: double.parse(
                              state.data.chartData.freeTime.total),
                          onChanged: (double value) {},
                        ),
                      ),
                    ),
                    Container(
                      width: width,
                      margin: EdgeInsets.only(
                          left: width / 5, right: width / 5, bottom: 5),
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.zero,
                                      side: BorderSide(color: Colors.blue)))),
                          onPressed: () {},
                          child: Text(
                            "Extend free time",
                            style: TextStyle(color: Colors.blue),
                          )),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text("Change Time Restrictions",
                          style: TextStyle(color: Colors.blue)),
                    ),
                    DividerLine(),
                    Container(
                      margin: EdgeInsets.all(10),
                      alignment: Alignment.center,
                      child: Text("By Devices"),
                    ),
                    Container(
                      margin:
                          EdgeInsets.only(left: width / 4, right: width / 4),
                      child: Row(
                        children: [
                          Icon(
                            Icons.phone_android_outlined,
                            size: 40,
                          ),
                          Spacer(),
                          Column(
                            children: [
                              Text(
                                "Adi's Phone",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "${durationToString(int.parse(state.data.deviceUsage.totalTime.mobile))}",
                                style: TextStyle(color: Colors.blue),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: width / 4,
                          right: width / 4,
                          top: 10,
                          bottom: 10),
                      child: Row(
                        children: [
                          Icon(
                            Icons.laptop_outlined,
                            size: 40,
                          ),
                          Spacer(),
                          Column(
                            children: [
                              Text(
                                "Adi's laptop",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "${durationToString(int.parse(state.data.deviceUsage.totalTime.laptop))}",
                                style: TextStyle(color: Colors.blue),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    TextButton(
                        onPressed: () {}, child: Text("See All Devices"))
                  ],
                ),
              );
  }
}

class DividerLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.3,
      color: Colors.black,
      margin: EdgeInsets.only(top: 5, left: 20, right: 20),
    );
  }
}
