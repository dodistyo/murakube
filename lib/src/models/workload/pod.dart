import 'package:murakube/src/models/workload/workload_status.dart';

class Pod {
  Status status;
  Pod({this.status});
  @override
  String toString() {
    return 'Pod{status: $status}';
  }

  Status get getStatus {
    return status;
  }

  factory Pod.fromJson(Map<String, dynamic> json) {
    return Pod(
      status: Status.fromJson(json["status"]),
    );
  }
}
