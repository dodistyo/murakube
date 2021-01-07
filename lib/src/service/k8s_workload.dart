import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:murakube/src/models/deployment.dart';
import 'dart:async';
import 'config.dart';

class Workload {
  final String apiURL = Config().apiURL;
  final Map<String, String> baseHeader = Config().baseHeaders;
  final HttpClient client = new HttpClient()
    ..badCertificateCallback = ((X509Certificate cert, String host, int port) =>
        true); //Config to ignore ssl certificate exception
  IOClient ioClient;
  //Constructor
  Workload() {
    ioClient = new IOClient(client);
  }
  // End Of Constructor

  //Get Deployment from API
  Future<Deployment> fetchDeployment() async {
    http.Response resp = await ioClient.get(apiURL + '/deployment/production',
        headers: baseHeader);
    final json = jsonDecode(resp.body);
    final res = Deployment.fromJson(json);
    return res;
  }
}
