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
    return {"Authorization": "Bearer " + await getToken()};
  }
}
