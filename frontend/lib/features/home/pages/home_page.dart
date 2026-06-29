import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/core/constants/utils.dart';
import 'package:frontend/features/home/widgets/date_selector.dart';
import 'package:frontend/features/home/widgets/task_card.dart';

class HomePage extends StatelessWidget {
  static MaterialPageRoute route() =>
      MaterialPageRoute(builder: (context) => HomePage());
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Task'),
        actions: [IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.add))],
      ),
      body: Column(
        children: [
          DateSelector(),
          Row(
            children: [
              Expanded(
                child: TaskCard(
                  color: Color.fromRGBO(246, 222, 194, 1),
                  headerText: 'Hello',
                  descriptionText: 'test task',
                ),
              ),
              Container(
                height: 10,
                width: 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: strengthenColor(
                    Color.fromRGBO(246, 222, 194, 1),
                    0.69,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text('10:00AM', style: TextStyle(fontSize: 17)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
