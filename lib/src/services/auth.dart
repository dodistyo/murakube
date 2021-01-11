import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:murakube/src/models/workload/deployment.dart';
import 'package:murakube/src/models/workload/statfulset.dart';
import 'dart:async';
import 'config.dart';

class Auth {
  final String apiURL = Config().apiURL;
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

  //Get Deployment from API
  Future getCSRF() async {
    http.Response resp = await ioClient.get(apiURL + '/csrftoken/login',
        headers: {'content-type': 'application/json'});
    final resJson = jsonDecode(resp.body);
    return resJson;
  }

  Future login(payload) async {
    final Map payloadRequest = {"token": payload};
    var csrf = await getCSRF();
    final csrfToken = csrf['token'];

    http.Response resp = await ioClient.post(apiURL + '/login',
        body: utf8.encode(json.encode(payloadRequest)),
        headers: {
          'content-type': 'application/json',
          'X-CSRF-TOKEN': csrfToken
        });
    final resJson = jsonDecode(resp.body);
    return resJson;
  }
}
