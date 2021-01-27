import 'package:murakube/src/models/workload/workload_status.dart';

class Replicaset {
  Status status;
  Replicaset({this.status});
  @override
  String toString() {
    return 'Replicaset{status: $status}';
  }

  Status get getStatus {
    return status;
  }

  factory Replicaset.fromJson(Map<String, dynamic> json) {
    return Replicaset(
      status: Status.fromJson(json["status"]),
    );
  }
}
