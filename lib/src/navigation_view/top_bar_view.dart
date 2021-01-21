import 'package:flutter/cupertino.dart';
import 'package:murakube/src/index_screen.dart';
import 'package:murakube/src/murakube_app_theme.dart';
import 'package:flutter/material.dart';

class TopBar extends StatefulWidget {
  final Function childActionLogout;
  const TopBar({Key key, this.childActionLogout}) : super(key: key);
  @override
  State<StatefulWidget> createState() => TopBarState();
}

class TopBarState extends State<TopBar> {
  Function logout;
  final topBarOpacity = 1.0;
  final k8sTextColor = MurakubeAppTheme.white;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height / 8.8,
          decoration: BoxDecoration(
            color: MurakubeAppTheme.k8sBase.withOpacity(1.0),
            borderRadius: const BorderRadius.only(
                // bottomLeft: Radius.circular(32.0),
                ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: MurakubeAppTheme.grey.withOpacity(0.4 * topBarOpacity),
                  offset: const Offset(1.1, 1.1),
                  blurRadius: 10.0),
            ],
          ),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).padding.top,
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 16 - 8.0 * topBarOpacity,
                    bottom: 16 - 8.0 * topBarOpacity),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'murakube',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: MurakubeAppTheme.fontName,
                            fontWeight: FontWeight.w700,
                            fontSize: 22 + 6 - 6 * topBarOpacity,
                            letterSpacing: 1.2,
                            color: k8sTextColor,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 38,
                      width: 38,
                      child: InkWell(
                        highlightColor: Colors.transparent,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(32.0)),
                        onTap: () {},
                        child: Center(
                          child: Icon(
                            Icons.keyboard_arrow_left,
                            color: k8sTextColor,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 8,
                        right: 8,
                      ),
                      child: Row(
                        children: <Widget>[
                          // Padding(
                          //   padding: const EdgeInsets.only(right: 8),
                          //   child: Icon(
                          //     Icons.calendar_today,
                          //     color: MurakubeAppTheme.grey,
                          //     size: 18,
                          //   ),
                          // ),
                          Text(
                            'dashboard',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: MurakubeAppTheme.fontName,
                              fontWeight: FontWeight.normal,
                              fontSize: 18,
                              letterSpacing: -0.2,
                              color: k8sTextColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 38,
                      width: 38,
                      child: InkWell(
                        highlightColor: Colors.transparent,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(32.0)),
                        onTap: () {},
                        child: Center(
                          child: Icon(
                            Icons.keyboard_arrow_right,
                            color: k8sTextColor,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 38,
                      width: 38,
                      child: InkWell(
                        highlightColor: Colors.transparent,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(32.0)),
                        onTap: _confirmLogout,
                        child: Center(
                          child: Icon(
                            Icons.exit_to_app,
                            color: k8sTextColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Future<bool> _confirmLogout() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Confirm Logout?',
                style: new TextStyle(color: Colors.black, fontSize: 20.0)),
            content: new Text(
                'Are you sure you want to logout? Tap \'Yes\' to logout \'No\' to cancel.'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                  widget.childActionLogout();
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
