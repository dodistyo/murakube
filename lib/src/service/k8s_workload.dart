import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:murakube/src/models/workload/deployment.dart';
import 'package:murakube/src/models/workload/statfulset.dart';
import 'dart:async';
import 'config.dart';

class Workload {
  final String apiURL = Config().apiURL;
  final String namespace = Config().defaultNamespace;
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
    http.Response resp = await ioClient.get(apiURL + '/deployment/' + namespace,
        headers: baseHeader);
    final json = jsonDecode(resp.body);
    final res = Deployment.fromJson(json);
    return res;
  }

  //Get Statefulset from API
  Future<Statefulset> fetchStatefulset() async {
    http.Response resp = await ioClient
        .get(apiURL + '/statefulset/' + namespace, headers: baseHeader);
    final json = jsonDecode(resp.body);
    final res = Statefulset.fromJson(json);
    return res;
  }
}
