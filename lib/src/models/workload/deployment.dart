import 'package:murakube/src/models/workload/workload_status.dart';

class Deployment {
  Status status;
  Deployment({this.status});
  @override
  String toString() {
    return 'Deployment{status: $status}';
  }

  Status get getStatus {
    return status;
  }

  factory Deployment.fromJson(Map<String, dynamic> json) {
    return Deployment(
      status: Status.fromJson(json["status"]),
    );
  }
}
