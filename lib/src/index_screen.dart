import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:murakube/src/models/tabIcon_data.dart';
import 'package:murakube/src/sample/sample_screen.dart';
import 'package:flutter/material.dart';
import 'package:murakube/src/screens/login.dart';
import 'navigation_view/bottom_bar_view.dart';
import 'murakube_app_theme.dart';
import 'screens/home/dashboard.dart';

class IndexScreen extends StatefulWidget {
  @override
  IndexScreenState createState() => IndexScreenState();
}

class IndexScreenState extends State<IndexScreen>
    with TickerProviderStateMixin {
  AnimationController animationController;

  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  Widget tabBody = Container(
    color: MurakubeAppTheme.background,
  );

  Widget tabLogin;

  bool loggedin;

  final storage = new FlutterSecureStorage();

  @override
  void initState() {
    tabIconsList.forEach((TabIconData tab) {
      tab.isSelected = false;
    });
    tabIconsList[0].isSelected = true;

    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    // tabBody = DashboardScreen(animationController: animationController);
    screen();
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  screen() async {
    var token = await storage.read(key: "token");
    setState(() {
      if (token == "") {
        loggedin = true;
        tabBody = LoginScreen(
          childActionRedirectHome: actionRedirectHome,
        );
      } else {
        loggedin = false;
        tabBody = DashboardScreen(animationController: animationController);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MurakubeAppTheme.background,
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: <Widget>[
              tabBody,
              // bottomBar(),
            ],
          )),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  void actionRedirectHome() async {
    setState(() {
      Fluttertoast.showToast(msg: "logged in");
      tabBody = DashboardScreen(animationController: animationController);
    });
  }

  Future<Widget> bottomBar() async {
    if (loggedin) {
      return Column(
        children: <Widget>[
          const Expanded(
            child: SizedBox(),
          ),
          BottomBarView(
            tabIconsList: tabIconsList,
            addClick: () {},
            changeIndex: (int index) {
              if (index == 0) {
                animationController.reverse().then<dynamic>((data) {
                  if (!mounted) {
                    return;
                  }
                  setState(() {
                    tabBody = DashboardScreen(
                        animationController: animationController);
                  });
                });
              } else {
                animationController.reverse().then<dynamic>((data) {
                  if (!mounted) {
                    return;
                  }
                  setState(() {
                    tabBody = TrainingScreen(
                        animationController: animationController);
                  });
                });
              }
            },
          ),
        ],
      );
    } else {
      return null;
    }
  }
}
