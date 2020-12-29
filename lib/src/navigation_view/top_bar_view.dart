import 'package:flutter/cupertino.dart';
import 'package:murakube/src/murakube_app_theme.dart';
import 'package:flutter/material.dart';

Widget getAppBarUI(
    animationController, topBarAnimation, topBarOpacity, k8sTextColor) {
  return Column(
    children: <Widget>[
      AnimatedBuilder(
        animation: animationController,
        builder: (BuildContext context, Widget child) {
          return FadeTransition(
            opacity: topBarAnimation,
            child: Transform(
              transform: Matrix4.translationValues(
                  0.0, 30 * (1.0 - topBarAnimation.value), 0.0),
              child: Container(
                decoration: BoxDecoration(
                  color: MurakubeAppTheme.k8sBase.withOpacity(topBarOpacity),
                  borderRadius: const BorderRadius.only(
                      // bottomLeft: Radius.circular(32.0),
                      ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: MurakubeAppTheme.grey
                            .withOpacity(0.4 * topBarOpacity),
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
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      )
    ],
  );
}
