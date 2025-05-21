import 'package:flutter/material.dart';

class ProgressTracker with ChangeNotifier {
  Map progress = {};

  int getProgressTracker(String key) {
    if (progress[key] == null && progress[key] == 0.0) {
      return 0;
    }
    return double.parse(((progress[key] ?? 0) * 100).toString()).toInt();
  }

  void runWithProgress(
    Future<void> Function() futureFunction, {
    String key = 'new',
    void Function()? onDone,
  }) async {
    bool isRunning = true;
    progress[key] = 0.0;
    notifyListeners();
    try {
      //  Future.delayed(const Duration(seconds: 10));
      futureFunction().then((value) async {
        isRunning = false;
        notifyListeners();
        var currentStep = progress[key] * 100.0;
        while (double.parse(progress[key].toString()) < 1.0) {
          // debugPrint('hell');
          await Future.delayed(const Duration(microseconds: 20));
          currentStep++;
          if (progress[key] < 1.0) {
            progress[key] = (currentStep / 100);
            notifyListeners();
          }
          if (progress[key] == 1.0) {
            debugPrint('progress $key : ${progress[key]}');
            onDone?.call();
          }
        }
        // progress[key] = 1.0;
        notifyListeners();

        // Future.delayed(const Duration(milliseconds: 100), () {
        //   progress[key] = 1.0;
        //   notifyListeners();
        // });
      });

      int currentStep = 1;
      while (isRunning && progress[key] < 0.80) {
        await Future.delayed(const Duration(milliseconds: 50));
        if (progress[key] == 0.2 ||
            progress[key] == 0.5 ||
            progress[key] == 0.6) {
          // currentStep++;
          await Future.delayed(const Duration(seconds: 2));
        }
        currentStep++;
        if (progress[key] < 1.0) {
          progress[key] = (currentStep / 100);
          notifyListeners();
          // debugPrint('progress $key : ${progress[key]}');
        }
      }
      if (progress[key] <= 0.80) {
        while (isRunning && progress[key] < 0.95) {
          await Future.delayed(const Duration(seconds: 2));
          // if (progress[key] == 0.2 ||
          //     progress[key] == 0.4 ||
          //     progress[key] == 0.6) {
          //   await Future.delayed(const Duration(seconds: 2));
          // }
          currentStep++;
          if (progress[key] < 1.0) {
            progress[key] = (currentStep / 100);
            notifyListeners();
            // debugPrint('progress $key : ${progress[key]}');
          }
        }
      }
    } catch (e) {
      // Handle errors
      progress[key] = 0; // Indicate error
      notifyListeners();
      debugPrint('progress error: ${progress[key]} \n $e');

      isRunning = false;
    }
  }
}

class ProgressKey {
  static const uploadingDataProgress = 'uploading_data_progress';
}
