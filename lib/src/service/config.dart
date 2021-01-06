class Config {
  final String apiEndpoint = "https://k8s.unsircle.id";
  final String apiPrefix = "/api/v1";

  String get apiURL {
    return apiEndpoint + apiPrefix;
  }
}
