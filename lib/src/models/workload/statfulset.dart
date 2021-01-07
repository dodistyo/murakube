import 'package:murakube/src/models/workload/workload_status.dart';

class Statefulset {
  Status status;
  Statefulset({this.status});
  @override
  String toString() {
    return 'Statefulset{status: $status}';
  }

  Status get getStatus {
    return status;
  }

  factory Statefulset.fromJson(Map<String, dynamic> json) {
    return Statefulset(
      status: Status.fromJson(json["status"]),
    );
  }
}
