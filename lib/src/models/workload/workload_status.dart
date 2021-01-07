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
