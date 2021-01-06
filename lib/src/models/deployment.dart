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

class Status {
  double running;
  double pending;
  double failed;
  double succeeded;
  Status({this.running, this.pending, this.failed, this.succeeded});
  @override
  String toString() {
    return 'Status{running: $running, pending: $pending, failed: $failed, succeeded: $succeeded}';
  }

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
        running: json["running"].toDouble(),
        pending: json["pending"].toDouble(),
        failed: json["failed"].toDouble(),
        succeeded: json["succeeded"].toDouble());
  }
}
