import 'package:murakube/src/models/workload/deployment.dart';
import 'package:murakube/src/models/workload/pod.dart';
import 'package:murakube/src/models/workload/replicaset.dart';
import 'package:murakube/src/models/workload/statfulset.dart';
import 'k8s_workload.dart';

import 'auth.dart';

class ServiceManager {
  Future login(dashboardHostname, payload) async {
    return await Auth().login(dashboardHostname, payload);
  }

  Future<Deployment> getDeployment() async {
    return await Workload().fetchDeployment();
  }

  Future<Statefulset> getStatefulset() async {
    return await Workload().fetchStatefulset();
  }

  Future<Pod> getPod() async {
    return await Workload().fetchPod();
  }

  Future<Replicaset> getReplicaset() async {
    return await Workload().fetchReplicaset();
  }
}
