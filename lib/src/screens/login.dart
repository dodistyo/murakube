import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:murakube/src/services/service_manager.dart';

import '../murakube_app_theme.dart';

class LoginScreen extends StatefulWidget {
  final Function childActionRedirectHome;

  LoginScreen({Key key, this.childActionRedirectHome}) : super(key: key);
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  TextEditingController dashboardHostname = TextEditingController();
  TextEditingController token = TextEditingController();
  // Create storage
  final storage = new FlutterSecureStorage();

  void actionLogin(dashboardHostname, payload) async {
    if (dashboardHostname == "" && payload == "") {
      Fluttertoast.showToast(msg: "Fill all the required field !");
    } else {
      try {
        await storage.write(key: 'dashboardHostname', value: dashboardHostname);
        var apiURL = await storage.read(key: "dashboardHostname");

        final res = await ServiceManager().login(apiURL, payload);
        if (res["jweToken"] == "") {
          Fluttertoast.showToast(msg: "Invalid token");
        } else {
          // Write value
          await storage.write(key: 'token', value: payload);
          widget.childActionRedirectHome();
        }
      } catch (e) {
        Fluttertoast.showToast(msg: "Something went wrong");
        print('something went wrong');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: MurakubeAppTheme.background,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Stack(
              children: <Widget>[
                //SET CONTAINER SEBAGAI BACKGROUND
                Container(
                  height: MediaQuery.of(context).size.height,
                ),
                //BAGIAN INI KITA GUNAKAN POSITIONED UNTUK MENGATUR SUDUTNYA, JIKA MASIH BINGUNG SOAL MATERI INI BACA NOTE DIBAWAH.
                Positioned(
                  //JARAK DARI ATAS KITA AMBIL DARI HEIGHT DIBAGI 3.6
                  // top: base_position,
                  top: MediaQuery.of(context).size.height / 5,
                  //ISINYA ADALAH CONTAINER YANG WIDTHNYA SELEBAR MUNGKIN
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    // decoration: BoxDecoration(color: MurakubeAppTheme.k8sBase),
                    child: Card(
                      //LALU CARD KITA SET MARGINNYA 20 DARI CONTAINER
                      margin: const EdgeInsets.all(20.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 6, //KETEBALANNYA
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                  color: MurakubeAppTheme.k8sBase,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(15.0),
                                      topLeft: Radius.circular(15.0))),
                              width: double.maxFinite,
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(vertical: 16),
                              child: Text(
                                "Murakube Dashboard",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 32),
                              child: Column(
                                children: <Widget>[
                                  SizedBox(height: 12),
                                  Text(
                                    "Every Service Account has a Secret with valid Bearer Token that can be used to log in to Dashboard. To find out more about how to configure and use Bearer Tokens, please refer to the Authentication section.",
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 32),
                              child: Column(
                                children: <Widget>[
                                  SizedBox(height: 12),
                                  TextField(
                                      controller: dashboardHostname,
                                      decoration: InputDecoration(
                                          labelText: "Dashboard hostname *",
                                          hintText:
                                              "https://k8s.dashboard.com")),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 32),
                              child: Column(
                                children: <Widget>[
                                  SizedBox(height: 12),
                                  TextField(
                                      controller: token,
                                      decoration: InputDecoration(
                                          labelText: "Token *")),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 12),
                              child: RaisedButton(
                                // shape: RoundedRectangleBorder(
                                //     borderRadius: BorderRadius.circular(50)),
                                child: Text("Sign in"),
                                onPressed: () {
                                  actionLogin(
                                      dashboardHostname.text, token.text);
                                },
                                color: MurakubeAppTheme.k8sBase,
                                textColor: Colors.white,
                              ),
                            )
                          ]),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
