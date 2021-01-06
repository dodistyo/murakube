import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:murakube/src/models/deployment.dart';
import 'dart:async';
import 'config.dart';

final String apiURL = Config().apiURL;

Future<Deployment> fetchDeployment() async {
  HttpClient client = new HttpClient()
    ..badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);
  var ioClient = new IOClient(client);
  http.Response resp =
      await ioClient.get(apiURL + '/deployment/production', headers: {
    'Authorization':
        'Bearer eyJhbGciOiJSUzI1NiIsImtpZCI6Iks4UmZtaWUxVlNWaEZGeTFwa0hLd3hxb1ZfdXlja3VJb25aN09vT3VwM3cifQ.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJrdWJlLXN5c3RlbSIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VjcmV0Lm5hbWUiOiJkYXNoYm9hcmQtYWRtaW4tdG9rZW4tdmttYmciLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC5uYW1lIjoiZGFzaGJvYXJkLWFkbWluIiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZXJ2aWNlLWFjY291bnQudWlkIjoiZjM0ZDdiNzktYmIwYS00ODQyLWI3YjQtZTY3YjU2MjBiZjM4Iiwic3ViIjoic3lzdGVtOnNlcnZpY2VhY2NvdW50Omt1YmUtc3lzdGVtOmRhc2hib2FyZC1hZG1pbiJ9.IiWKfiV4zrK-GbNvQSeJdcHGFSOagxBzIsDWE5U7qTSnIHhI_1ZMHuSWpwh1TsLIW-bmvK7WtPT9mcZ1SY7qpFLzJij0fG9Ndebs4qwz9FRL8844k50JehS5bVU910iIPLX4OdRkOwK9lWpbbzLm0QG8JE9zEAhFC6X_maOaXJUbMhLEQrxb31NXZ3joSsqu9UoPXgBTVvpw1H_CPYV8W1Iit5AMv0mBM1yaIf5O3L3pVrUdqGrXEUg3bx5j7-PgZ2B5PqtK18kaI70XqwVQdbEQYtxjTHanjfsNCLhV2a9Kh2gfn4HRz4K5k1R7UlinvXw7qgjJ57yhKmA9rqRiQQ'
  });
  final json = jsonDecode(resp.body);
  final res = Deployment.fromJson(json);

  return res;
}
