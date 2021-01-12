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
  final token = TextEditingController();
  // Create storage
  final storage = new FlutterSecureStorage();

  void actionLogin(payload) async {
    try {
      final res = await ServiceManager().login(payload);
      if (res["jweToken"] == "") {
        Fluttertoast.showToast(msg: "Invalid token");
      } else {
        // Write value
        await storage.write(key: 'token', value: payload);
        widget.childActionRedirectHome();
      }
    } catch (e) {
      // Fluttertoast.showToast(msg: "Something went wrong");
      print('something went wrong');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: MurakubeAppTheme.background,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: <Widget>[
              //SET CONTAINER SEBAGAI BACKGROUND
              Container(
                height: MediaQuery.of(context).size.height,
              ),
              //BAGIAN INI KITA GUNAKAN POSITIONED UNTUK MENGATUR SUDUTNYA, JIKA MASIH BINGUNG SOAL MATERI INI BACA NOTE DIBAWAH.
              Positioned(
                //JARAK DARI ATAS KITA AMBIL DARI HEIGHT DIBAGI 3.6
                top: MediaQuery.of(context).size.height / 3.6,
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
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
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
                                TextField(
                                    decoration:
                                        InputDecoration(labelText: "Token")),
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
                                    "eyJhbGciOiJSUzI1NiIsImtpZCI6Iks4UmZtaWUxVlNWaEZGeTFwa0hLd3hxb1ZfdXlja3VJb25aN09vT3VwM3cifQ.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJrdWJlLXN5c3RlbSIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VjcmV0Lm5hbWUiOiJkYXNoYm9hcmQtYWRtaW4tdG9rZW4tdmttYmciLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC5uYW1lIjoiZGFzaGJvYXJkLWFkbWluIiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZXJ2aWNlLWFjY291bnQudWlkIjoiZjM0ZDdiNzktYmIwYS00ODQyLWI3YjQtZTY3YjU2MjBiZjM4Iiwic3ViIjoic3lzdGVtOnNlcnZpY2VhY2NvdW50Omt1YmUtc3lzdGVtOmRhc2hib2FyZC1hZG1pbiJ9.IiWKfiV4zrK-GbNvQSeJdcHGFSOagxBzIsDWE5U7qTSnIHhI_1ZMHuSWpwh1TsLIW-bmvK7WtPT9mcZ1SY7qpFLzJij0fG9Ndebs4qwz9FRL8844k50JehS5bVU910iIPLX4OdRkOwK9lWpbbzLm0QG8JE9zEAhFC6X_maOaXJUbMhLEQrxb31NXZ3joSsqu9UoPXgBTVvpw1H_CPYV8W1Iit5AMv0mBM1yaIf5O3L3pVrUdqGrXEUg3bx5j7-PgZ2B5PqtK18kaI70XqwVQdbEQYtxjTHanjfsNCLhV2a9Kh2gfn4HRz4K5k1R7UlinvXw7qgjJ57yhKmA9rqRiQQ");
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
        ));
  }
}
