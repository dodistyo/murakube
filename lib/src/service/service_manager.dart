import 'package:murakube/src/models/workload/deployment.dart';
import 'package:murakube/src/models/workload/statfulset.dart';
import 'package:murakube/src/service/k8s_workload.dart';

class ServiceManager {
  Future<Deployment> getDeployment() async {
    return await Workload().fetchDeployment();
  }

  Future<Statefulset> getStatefulset() async {
    return await Workload().fetchStatefulset();
  }
}
