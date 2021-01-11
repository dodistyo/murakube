import 'package:murakube/src/models/workload/deployment.dart';
import 'package:murakube/src/models/workload/statfulset.dart';
import 'k8s_workload.dart';

import 'auth.dart';

class ServiceManager {
  Future login(payload) async {
    return await Auth().login(payload);
  }

  Future<Deployment> getDeployment() async {
    return await Workload().fetchDeployment();
  }

  Future<Statefulset> getStatefulset() async {
    return await Workload().fetchStatefulset();
  }
}
