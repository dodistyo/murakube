import 'dart:convert';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'dart:async';
import 'config.dart';

class Auth {
  final String namespace = Config().defaultNamespace;
  final HttpClient client = new HttpClient()
    ..badCertificateCallback = ((X509Certificate cert, String host, int port) =>
        true); //Config to ignore ssl certificate exception
  IOClient ioClient;
  //Constructor
  Auth() {
    ioClient = new IOClient(client);
  }
  // End Of Constructor
  getApiURL() async {
    return await Config().apiURL();
  }

  //Get Deployment from API
  Future getCSRF(apiURL) async {
    http.Response resp = await ioClient.get(apiURL + '/csrftoken/login',
        headers: {'content-type': 'application/json'});
    final resJson = jsonDecode(resp.body);
    return resJson;
  }

  Future login(dashboardHostname, payload) async {
    var apiURL = dashboardHostname + Config().apiPrefix;

    final Map payloadRequest = {"token": payload};
    try {
      var csrf = await getCSRF(apiURL);
      final csrfToken = csrf['token'];
      http.Response resp = await ioClient.post(apiURL + '/login',
          body: utf8.encode(json.encode(payloadRequest)),
          headers: {
            'content-type': 'application/json',
            'X-CSRF-TOKEN': csrfToken
          });
      final resJson = jsonDecode(resp.body);
      return resJson;
    } catch (e) {
      Fluttertoast.showToast(msg: "Something went wrong");
    }
  }
}
