import 'package:murakube/src/models/workload/deployment.dart';
import 'package:murakube/src/models/workload/statfulset.dart';
import 'package:murakube/src/murakube_app_theme.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:murakube/src/service/service_manager.dart';

class _PieChartState extends State<ChartView> {
  int touchedIndex;
  final int count = 9;
  Future<Deployment> _futureDeployment;
  Future<Statefulset> _futureStatefulset;

  @override
  void initState() {
    _futureDeployment = ServiceManager().getDeployment();
    _futureStatefulset = ServiceManager().getStatefulset();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: widget.animation,
          child: new Transform(
            transform: new Matrix4.translationValues(
                0.0, 30 * (1.0 - widget.animation.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 0, bottom: 18),
              // This is the parent Card
              child: Container(
                decoration: BoxDecoration(
                  color: MurakubeAppTheme.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      bottomLeft: Radius.circular(8.0),
                      bottomRight: Radius.circular(8.0),
                      topRight: Radius.circular(8.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: MurakubeAppTheme.grey.withOpacity(0.2),
                        offset: Offset(1.1, 1.1),
                        blurRadius: 10.0),
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 16, left: 16, right: 16, bottom: 0),
                      child: Text(
                        "Kubernetes Resources",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: MurakubeAppTheme.fontName,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          letterSpacing: 0.5,
                          color: MurakubeAppTheme.lightText,
                        ),
                      ),
                    ),
                    // Border
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 24, right: 24, top: 8, bottom: 0),
                      child: Container(
                        height: 2,
                        decoration: BoxDecoration(
                          color: MurakubeAppTheme.background,
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        ),
                      ),
                    ),
                    // End of Border
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 0, left: 16, right: 16, bottom: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                              child: Column(children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(0),
                              child: Container(
                                height: 200,
                                child: Transform.scale(
                                  scale: 0.75,
                                  child: FutureBuilder(
                                    future: _futureDeployment,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return PieChart(
                                          PieChartData(
                                              pieTouchData: PieTouchData(
                                                  touchCallback:
                                                      (pieTouchResponse) {
                                                setState(() {
                                                  if (pieTouchResponse
                                                              .touchInput
                                                          is FlLongPressEnd ||
                                                      pieTouchResponse
                                                              .touchInput
                                                          is FlPanEnd) {
                                                    touchedIndex = -1;
                                                  } else {
                                                    touchedIndex =
                                                        pieTouchResponse
                                                            .touchedSectionIndex;
                                                  }
                                                });
                                              }),
                                              startDegreeOffset: 270,
                                              borderData: FlBorderData(
                                                show: false,
                                              ),
                                              sectionsSpace: 0,
                                              centerSpaceRadius: 0,
                                              sections:
                                                  showingSectionsDeployment(
                                                      snapshot.data)),
                                        );
                                      } else {
                                        return Center(
                                            child: CircularProgressIndicator());
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: Text(
                                "Deployment",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: MurakubeAppTheme.fontName,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 16,
                                  letterSpacing: 0.5,
                                  color: MurakubeAppTheme.lightText,
                                ),
                              ),
                            ),
                          ])),
                          Expanded(
                              child: Column(children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(0),
                              child: Container(
                                height: 200,
                                child: Transform.scale(
                                  scale: 0.75,
                                  child: FutureBuilder(
                                    future: _futureStatefulset,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return PieChart(
                                          PieChartData(
                                              pieTouchData: PieTouchData(
                                                  touchCallback:
                                                      (pieTouchResponse) {
                                                setState(() {
                                                  if (pieTouchResponse
                                                              .touchInput
                                                          is FlLongPressEnd ||
                                                      pieTouchResponse
                                                              .touchInput
                                                          is FlPanEnd) {
                                                    touchedIndex = -1;
                                                  } else {
                                                    touchedIndex =
                                                        pieTouchResponse
                                                            .touchedSectionIndex;
                                                  }
                                                });
                                              }),
                                              startDegreeOffset: 270,
                                              borderData: FlBorderData(
                                                show: false,
                                              ),
                                              sectionsSpace: 0,
                                              centerSpaceRadius: 0,
                                              sections:
                                                  showingSectionsStatefulset(
                                                      snapshot.data)),
                                        );
                                      } else {
                                        return Center(
                                            child: CircularProgressIndicator());
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: Text(
                                "Statefulset",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: MurakubeAppTheme.fontName,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 16,
                                  letterSpacing: 0.5,
                                  color: MurakubeAppTheme.lightText,
                                ),
                              ),
                            ),
                          ])),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  List<PieChartSectionData> showingSectionsDeployment(Deployment deployment) {
    return List.generate(2, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 20 : 16;
      final double radius = isTouched ? 110 : 100;

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.red,
            value: deployment.status.failed,
            title: (deployment.status.failed > 0)
                ? deployment.status.failed.toInt().toString()
                : '',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xff00C752),
            value: deployment.status.running,
            title: (deployment.status.running > 0)
                ? deployment.status.running.toInt().toString()
                : '',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        default:
          return null;
      }
    });
  }

  List<PieChartSectionData> showingSectionsStatefulset(
      Statefulset statefulset) {
    return List.generate(2, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 20 : 16;
      final double radius = isTouched ? 110 : 100;

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.red,
            value: statefulset.status.failed,
            title: (statefulset.status.failed > 0)
                ? statefulset.status.failed.toInt().toString()
                : '',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xff00C752),
            value: statefulset.status.running,
            title: (statefulset.status.running > 0)
                ? statefulset.status.running.toInt().toString()
                : '',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        default:
          return null;
      }
    });
  }
}

class ChartView extends StatefulWidget {
  final AnimationController animationController;
  final Animation animation;

  const ChartView({Key key, this.animationController, this.animation})
      : super(key: key);

  @override
  _PieChartState createState() => new _PieChartState();
}
