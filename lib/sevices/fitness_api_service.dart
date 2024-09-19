import 'package:flutter_step_tracking/sevices/firestore_service.dart';
import 'package:health/health.dart';

class StepTracker {
  bool requested = false;
  StepTracker() {
    Health().configure();
    Health().requestAuthorization([HealthDataType.STEPS]).then((v) {
      requested = v;
    });
  }
  Future<int> getFootSteps() async {
    if (requested) {
      var now = DateTime.now();
      List<HealthDataPoint> healthData = await Health().getHealthDataFromTypes(
          startTime: now.subtract(const Duration(days: 1)),
          endTime: now,
          types: [HealthDataType.STEPS]);
      int step = healthData
          .map((p) => int.parse(p.value.toString()))
          .reduce((previous, current) => previous + current);
      FirestoreRepository().uploadStep(step);
      return step;
    }
    return 0;
  }
}
