import 'package:flutter/services.dart';
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

  Widget mainBody = Stack(
    children: <Widget>[],
  );

  bool loggedin = false;

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
    // await storage.delete(key: "token");
    var token = await storage.read(key: "token");
    setState(() {
      if (token == "" || token == null) {
        print("here");
        loggedin = false;
        tabBody = LoginScreen(
          childActionRedirectHome: actionRedirectHome,
        );
      } else {
        loggedin = true;
        tabBody = DashboardScreen(animationController: animationController);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: _onWillPop,
      child: Container(
          color: MurakubeAppTheme.background,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              children: <Widget>[
                tabBody,
                (() {
                  if (loggedin) {
                    return bottomBar();
                  } else {
                    return Column();
                  }
                }()),
              ],
            ),
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
      loggedin = true;
      tabBody = DashboardScreen(animationController: animationController);
      // mainBody = Stack(
      //   children: <Widget>[
      //     tabBody,
      //     bottomBar(),
      //   ],
      // );
    });
  }

  Widget bottomBar() {
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
                  tabBody =
                      DashboardScreen(animationController: animationController);
                });
              });
            } else {
              animationController.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody =
                      TrainingScreen(animationController: animationController);
                });
              });
            }
          },
        ),
      ],
    );
  }

  // this is the future function called to show dialog for confirm exit.
  Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Confirm Exit?',
                style: new TextStyle(color: Colors.black, fontSize: 20.0)),
            content: new Text(
                'Are you sure you want to exit the app? Tap \'Yes\' to exit \'No\' to cancel.'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () {
                  // this line exits the app.
                  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                },
                child: new Text('Yes', style: new TextStyle(fontSize: 18.0)),
              ),
              new FlatButton(
                onPressed: () =>
                    Navigator.pop(context), // this line dismisses the dialog
                child: new Text('No', style: new TextStyle(fontSize: 18.0)),
              )
            ],
          ),
        ) ??
        false;
  }
}
