import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Config {
  final String apiPrefix = "/api/v1";
  final String defaultNamespace = "production";
  // Create storage
  final storage = new FlutterSecureStorage();

  // Read value
  Future<String> getToken() async {
    String value = await storage.read(key: "token");
    if (value != "" || value != null) {
      return value;
    } else {
      return "notoken";
    }
  }

  Future<String> apiURL() async {
    var apiURL = await storage.read(key: "dashboardHostname");
    return apiURL + apiPrefix;
  }

  Future<Map<String, String>> baseHeaders() async {
    // return {
    //   'Authorization':
    //       'Bearer eyJhbGciOiJSUzI1NiIsImtpZCI6Iks4UmZtaWUxVlNWaEZGeTFwa0hLd3hxb1ZfdXlja3VJb25aN09vT3VwM3cifQ.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJrdWJlLXN5c3RlbSIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VjcmV0Lm5hbWUiOiJkYXNoYm9hcmQtYWRtaW4tdG9rZW4tdmttYmciLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC5uYW1lIjoiZGFzaGJvYXJkLWFkbWluIiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZXJ2aWNlLWFjY291bnQudWlkIjoiZjM0ZDdiNzktYmIwYS00ODQyLWI3YjQtZTY3YjU2MjBiZjM4Iiwic3ViIjoic3lzdGVtOnNlcnZpY2VhY2NvdW50Omt1YmUtc3lzdGVtOmRhc2hib2FyZC1hZG1pbiJ9.IiWKfiV4zrK-GbNvQSeJdcHGFSOagxBzIsDWE5U7qTSnIHhI_1ZMHuSWpwh1TsLIW-bmvK7WtPT9mcZ1SY7qpFLzJij0fG9Ndebs4qwz9FRL8844k50JehS5bVU910iIPLX4OdRkOwK9lWpbbzLm0QG8JE9zEAhFC6X_maOaXJUbMhLEQrxb31NXZ3joSsqu9UoPXgBTVvpw1H_CPYV8W1Iit5AMv0mBM1yaIf5O3L3pVrUdqGrXEUg3bx5j7-PgZ2B5PqtK18kaI70XqwVQdbEQYtxjTHanjfsNCLhV2a9Kh2gfn4HRz4K5k1R7UlinvXw7qgjJ57yhKmA9rqRiQQ'
    // };
    return {"Authorization": "Bearer " + await getToken()};
  }
}
