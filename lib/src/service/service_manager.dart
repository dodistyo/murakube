import 'package:murakube/src/models/deployment.dart';
import 'package:murakube/src/service/k8s_workload.dart';

class ServiceManager {
  Future<Deployment> getDeployment() async {
    return await Workload().fetchDeployment();
  }
}
