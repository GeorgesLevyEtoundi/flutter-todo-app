import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:todo_app/app/data/services/storage/repository.dart';

import '../../data/models/task.dart';

class HomeController extends GetxController {
  TaskRepository taskRepository;

  HomeController({required this.taskRepository});

  final formKey = GlobalKey<FormState>();
  final editCtrl = TextEditingController();
  final chipIndex = 0.obs;
  final tasks = <Task>[].obs;
  final deleting = false.obs;
  final task = Rx<Task?>(null);

  @override
  void onInit() {
    super.onInit();

    tasks.assignAll(taskRepository.readTasks());

    ever(tasks, (_) => taskRepository.writeTasks(tasks));

    @override
    void onClose() {
      editCtrl.dispose();
      super.onClose();
    }
  }

  //  on change of icon index
  void changeChipIndex(int value) {
    chipIndex.value = value;
  }

  //  adds a new task
  addTask(Task task) {
    if (tasks.contains(task)) {
      return false;
    }
    tasks.add(task);

    return true;
  }

  //  deletes a task
  void changeDeleting(bool value) {
    deleting.value = value;
  }

  void changeTask(Task? select) {
    task.value = select;
  }

  void deleteTask(Task task) {
    tasks.remove(task);
  }
}
