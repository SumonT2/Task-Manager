import 'package:flutter/material.dart';
import 'package:taskmanager/ui/widgets/centered_circular_progress_indicator.dart';

import '../../data/models/task_list_model.dart';
import '../../data/models/task_model.dart';
import '../../data/models/task_status_count_model.dart';
import '../../data/service/network_client.dart';
import '../../data/utils/urls.dart';
import '../widgets/snack_bar_message.dart';
import '../widgets/summary_card.dart';
import '../widgets/task_card.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  bool _getCompletedTaskInProgress = false;
  List<TaskModel> _completedTastList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getAllCompletedTaskList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Visibility(
        visible: _getCompletedTaskInProgress==false,
        replacement: CenteredCircularProgressIndicator(),
        child: ListView.separated(
          itemCount: _completedTastList.length,
          itemBuilder: (context, index) {
             return  TaskCard(taskStatus: TaskStatus.completed,taskModel: _completedTastList[index],refreshList: _getAllCompletedTaskList,);
          },
          separatorBuilder: (context, index) => const SizedBox(height: 8),
        ),
      ),
    );
  }
  Future<void> _getAllCompletedTaskList() async {
    _getCompletedTaskInProgress = true;
    setState(() {});

    final NetworkResponse response = await NetworkClient.getRequest(
      url: Urls.completedTaskListUrl,
    );
    if (response.isSuccess) {
      TaskListModel taskListModel = TaskListModel.fromJson(response.data ?? {});
      _completedTastList = taskListModel.taskList;
    } else {
      showSnackBarMessage(context, response.errorMessage);
    }
    _getCompletedTaskInProgress = false;
    setState(() {});
  }
}
