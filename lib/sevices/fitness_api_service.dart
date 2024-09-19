import 'package:flutter_step_tracking/sevices/firestore_service.dart';
import 'package:get/get.dart';
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
      return healthData
          .map((p) => int.parse(p.value.toString()))
          .reduce((previous, current) => previous + current);
    }
    return 0;
  }
}

class HealthRepository extends GetxController {
  var step = 0.obs;
  var error = "".obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchHealthData();
  }

  void fetchHealthData() async {
    try {
      isLoading.value = true;
      final healthdata = await StepTracker().getFootSteps();
      step.value = healthdata;
      error.value = "";
      isLoading.value = false;
      FirestoreRepository().uploadStep(step.value);
    } catch (e) {
      error.value = e.toString();
    }
    update();
  }
}

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HealthRepository());
  }
}
