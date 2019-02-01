import 'package:flutter/material.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:shared_preferences/shared_preferences.dart';

//this is the pie class

void _saveData(String pref, String data) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(pref, data);
}

Future<String> _loadData(String pref) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString(pref);
}

class Stats extends StatefulWidget {

  Function percentageToday;
  Key key;

  Stats(this.percentageToday, this.key) : super(key: key);

  @override
  _StatsState createState() => new _StatsState(this.percentageToday, this.key);
}

class _StatsState extends State<Stats> {
  int totalCalories = 2500;
  Function percentageToday;
  Key key;
  _StatsState(this.percentageToday, this.key);

  final GlobalKey<AnimatedCircularChartState> _chartKey =
      GlobalKey<AnimatedCircularChartState>();
  final GlobalKey<AnimatedCircularChartState> _chartKey2 =
      GlobalKey<AnimatedCircularChartState>();
  final GlobalKey<AnimatedCircularChartState> _chartKey3 =
      GlobalKey<AnimatedCircularChartState>();
  final _chartSize = const Size(280.0, 280.0);
  int sampleIndex = 0;

  // void _cycleSamples() {
  //   setState(() {
  //     sampleIndex++;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Padding(
          padding: EdgeInsets.all(20),
        ),
        Center(
          child: AnimatedCircularChart(
            key: _chartKey,
            size: _chartSize,
            initialChartData: <CircularStackEntry>[
              new CircularStackEntry(
                <CircularSegmentEntry>[
                  new CircularSegmentEntry(
                    percentageToday()/25,
                    Colors.lightGreen,
                    rankKey: 'completed',
                  ),
                  new CircularSegmentEntry(
                    100-(percentageToday()/25),
                    Colors.grey,
                    rankKey: 'remaining',
                  ),
                ],
                rankKey: 'progress',
              ),
            ],
            chartType: CircularChartType.Radial,
            percentageValues: true,
            holeLabel: 'Calories\n  ${(percentageToday())}',
            labelStyle: TextStyle(
              color: Colors.blueGrey[600],
              fontWeight: FontWeight.bold,
              fontSize: 24.0,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(3),
        ),
        Text("Today", style: TextStyle(fontSize: 29)),
        Padding(
          padding: EdgeInsets.all(5),
        ),
        // ListView(
          // children: <Widget>[
            
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => setState(() {
                    widget.percentageToday();
                    // _chartKey.currentWidget();
                  }),
                  child: AnimatedCircularChart(
                  key: _chartKey2,
                  size: _chartSize / 2,
                  initialChartData: <CircularStackEntry>[
                    new CircularStackEntry(
                      <CircularSegmentEntry>[
                        new CircularSegmentEntry(
                          95,
                          Colors.green,
                          rankKey: 'completed',
                        ),
                        new CircularSegmentEntry(
                          5,
                          Colors.grey,
                          rankKey: 'remaining',
                        ),
                      ],
                      rankKey: 'progress',
                    ),
                  ],
                  chartType: CircularChartType.Radial,
                  percentageValues: true,
                  
                  holeLabel:
                      'Calories\n  ${(totalCalories * 90 / 100).round()}',
                  labelStyle: new TextStyle(
                    color: Colors.blueGrey[600],
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                ),
                Text("26 January 2019", style: TextStyle(fontSize: 20)),
              ],
        ),
        Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AnimatedCircularChart(
                  key: _chartKey3,
                  size: _chartSize / 2,
                  initialChartData: <CircularStackEntry>[
                    new CircularStackEntry(
                      <CircularSegmentEntry>[
                        new CircularSegmentEntry(
                          105,
                          Colors.red,
                          rankKey: 'completed',
                        ),
                        new CircularSegmentEntry(
                          -5,
                          Colors.grey,
                          rankKey: 'remaining',
                        ),
                      ],
                      rankKey: 'progress',
                    ),
                  ],
                  chartType: CircularChartType.Radial,
                  percentageValues: true,
                  holeLabel:
                      'Calories\n  ${(totalCalories * 110 / 100).round()}',
                  labelStyle: new TextStyle(
                    color: Colors.blueGrey[600],
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                ),
                Text("25 January 2019", style: TextStyle(fontSize: 20)),
              ],
        )

        //   ],
        // ),
      ],

      // floatingActionButton: new FloatingActionButton(
      //   child: new Icon(Icons.refresh),
      //   onPressed: _cycleSamples,
      // ),
    )
    );
  }
}

// //THIS IS THE CARD CLASS

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Code Sample for material.Card',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyStatelessWidget(),
//     );
//   }
// }

// class MyStatelessWidget extends StatelessWidget {
//   MyStatelessWidget({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Card(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             const ListTile(
//               leading: Icon(Icons.album),
//               title: Text('The Enchanted Nightingale'),
//               subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
//             ),
//             ButtonTheme.bar(
//               // make buttons use the appropriate styles for cards
//               child: ButtonBar(
//                 children: <Widget>[
//                   FlatButton(
//                     child: const Text('BUY TICKETS'),
//                     onPressed: () {/* ... */},
//                   ),
//                   FlatButton(
//                     child: const Text('LISTEN'),
//                     onPressed: () {/* ... */},
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
