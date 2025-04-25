import 'package:flutter/material.dart';
import 'package:taskmanager/ui/widgets/screen_background.dart';
import 'package:taskmanager/ui/widgets/tm_app_bar.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(),
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 32),
          Text(
            'Add New Task',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 24),
          TextFormField(
            decoration: InputDecoration(hintText: 'Title'),
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 8),
          TextFormField(
            maxLines: 6,
            decoration: InputDecoration(hintText: 'Description',contentPadding: EdgeInsets.symmetric(horizontal: 16,vertical: 8)),
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _onTapSubmitButton,
            child: const Icon(Icons.arrow_circle_right_outlined),
          ),
        ],
              ),
          ),
        ),
      ),
    );
  }
  void _onTapSubmitButton() {
  }
}
