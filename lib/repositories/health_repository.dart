import 'dart:async';

import 'package:health/health.dart';

class HealthRepository {
  HealthFactory health = HealthFactory();

  var types = [
    HealthDataType.STEPS,
    HealthDataType.DISTANCE_DELTA,
    HealthDataType.MOVE_MINUTES,
  ];

  var permissions = [
    HealthDataAccess.READ_WRITE,
    HealthDataAccess.READ_WRITE,
    HealthDataAccess.READ_WRITE,
  ];

  bool isPaused = false;
  bool shouldFetchData = true;

  Future<bool> requestAuth() async =>
      await health.requestAuthorization(types, permissions: permissions);

  Stream<int?> fetchSteps() async* {
    var now = DateTime.now();
    var midnight = DateTime(now.year, now.month, now.day);
    await for (int? steps in health.getTotalStepsInInterval(midnight, now).asStream()) {
      if (!isPaused && shouldFetchData) {
        print(steps);
        yield steps;
      }
    }
  }

  Stream<String> fetchStepsDistance() async* {
    double totalDistance = 0;
    var now = DateTime.now();
    var midnight = DateTime(now.year, now.month, now.day);

    await for (List<HealthDataPoint> distance in health
        .getHealthDataFromTypes(midnight, now, [HealthDataType.DISTANCE_DELTA]).asStream()) {
      if (!isPaused && shouldFetchData) {
        for (var entry in distance) {
          var distanceElement = entry.value.toString();
          totalDistance += double.parse(distanceElement);
        }
        yield (totalDistance / 1000).toStringAsFixed(2);
      }
    }
  }

  Stream<String> fetchStepsDuration() async* {
    int totalDuration = 0;
    var now = DateTime.now();
    var midnight = DateTime(now.year, now.month, now.day);

    await for (List<HealthDataPoint> duration
        in health.getHealthDataFromTypes(midnight, now, [HealthDataType.MOVE_MINUTES]).asStream()) {
      if (!isPaused && shouldFetchData) {
        for (var entry in duration) {
          var durationElement = entry.value.toString();
          totalDuration += int.parse(durationElement);
        }
        yield totalDuration.toString();
      }
    }
  }

  void pause() {
    isPaused = true;
    shouldFetchData = false;
  }

  void resume() {
    isPaused = false;
    shouldFetchData = true;
  }
}
