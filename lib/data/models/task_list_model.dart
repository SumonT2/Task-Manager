import 'package:taskmanager/data/models/task_model.dart';

class TaskListModel{
  late final String status;
  late final List<TaskModel> taskList;

  TaskListModel.fromJson(Map<String, dynamic> jsonData){
    status = jsonData['status'];
    if(jsonData['data']!=null){
      taskList=[];
      jsonData['data'].forEach((e){
        taskList.add(TaskModel.fromJson(e));
      });
    }
    else{
      taskList=[];
    }
  }
}
