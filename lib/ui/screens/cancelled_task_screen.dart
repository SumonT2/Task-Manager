import 'package:flutter/material.dart';
import 'package:taskmanager/ui/widgets/centered_circular_progress_indicator.dart';

import '../../data/models/task_list_model.dart';
import '../../data/models/task_model.dart';
import '../../data/service/network_client.dart';
import '../../data/utils/urls.dart';
import '../widgets/snack_bar_message.dart';
import '../widgets/summary_card.dart';
import '../widgets/task_card.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  bool _getCancelledTaskInProgress = false;
  List<TaskModel> _cancelledTastList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getAllNewTaskList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Visibility(
        visible: _getCancelledTaskInProgress==false,
        replacement: CenteredCircularProgressIndicator(),
        child: ListView.separated(
          itemCount: _cancelledTastList.length,
          itemBuilder: (context, index) {
             return  TaskCard(taskStatus: TaskStatus.cancelled,taskModel: _cancelledTastList[index], refreshList: _getAllNewTaskList,);
          },
          separatorBuilder: (context, index) => const SizedBox(height: 8),
        ),
      ),
    );
  }
  Future<void> _getAllNewTaskList() async {
    _getCancelledTaskInProgress = true;
    setState(() {});

    final NetworkResponse response = await NetworkClient.getRequest(
      url: Urls.cancelledTaskListUrl,
    );
    if (response.isSuccess) {
      TaskListModel taskListModel = TaskListModel.fromJson(response.data ?? {});
      _cancelledTastList = taskListModel.taskList;
    } else {
      showSnackBarMessage(context, response.errorMessage);
    }
    _getCancelledTaskInProgress = false;
    setState(() {});
  }
}
