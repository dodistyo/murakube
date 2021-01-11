import 'package:fluttertoast/fluttertoast.dart';
import 'package:murakube/src/components/chart_view.dart';
import 'package:murakube/src/murakube_app_theme.dart';
import 'package:flutter/material.dart';
import 'package:murakube/src/navigation_view/top_bar_view.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key key, this.animationController}) : super(key: key);

  final AnimationController animationController;
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with TickerProviderStateMixin {
  Animation<double> topBarAnimation;

  List<Widget> listViews = <Widget>[];
  final ScrollController scrollController = ScrollController();
  double topBarOpacity = 0.0;

  Color k8sTextColor = MurakubeAppTheme.k8sBase;

  final GlobalKey<PieChartState> _key = GlobalKey();

  @override
  void initState() {
    topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: widget.animationController,
            curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn)));
    addAllListData();

    scrollController.addListener(() {
      if (scrollController.offset >= 24) {
        if (topBarOpacity != 1.0) {
          setState(() {
            topBarOpacity = 1.0;
            k8sTextColor = MurakubeAppTheme.white;
          });
        }
      } else if (scrollController.offset <= 24 &&
          scrollController.offset >= 0) {
        if (topBarOpacity != scrollController.offset / 24) {
          setState(() {
            topBarOpacity = scrollController.offset / 24;
          });
        }
      } else if (scrollController.offset <= 0) {
        if (topBarOpacity != 0.0) {
          setState(() {
            topBarOpacity = 0.0;
            k8sTextColor = MurakubeAppTheme.k8sBase;
          });
        }
      }
    });
    super.initState();
  }

  Future<Null> refreshDasboard() async {
    _key.currentState.refreshDashboard();
  }

  methodInParent() => Fluttertoast.showToast(
      msg: "Method called in parent", gravity: ToastGravity.CENTER);

  void addAllListData() {
    const int count = 9;
    listViews.add(
      ChartView(
        key: _key,
        function: methodInParent,
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController,
            curve:
                Interval((1 / count) * 1, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController,
      ),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MurakubeAppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            getMainListViewUI(),
            getAppBarUI(widget.animationController, topBarAnimation,
                topBarOpacity, k8sTextColor),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            )
          ],
        ),
      ),
    );
  }

  Widget getMainListViewUI() {
    return FutureBuilder<bool>(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox();
        } else {
          return RefreshIndicator(
            onRefresh: refreshDasboard,
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              controller: scrollController,
              padding: EdgeInsets.only(
                top: AppBar().preferredSize.height +
                    MediaQuery.of(context).padding.top +
                    24,
                bottom: 62 + MediaQuery.of(context).padding.bottom,
              ),
              itemCount: listViews.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context, int index) {
                widget.animationController.forward();
                return listViews[index];
              },
            ),
          );
        }
      },
    );
  }
}
