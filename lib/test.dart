import 'package:getjob/features/auth/data/data_surce/firbase_data_surce.dart';
import 'package:flutter/material.dart';

class TestView extends StatefulWidget {
  const TestView({super.key});

  @override
  State<TestView> createState() => _TestViewState();
}

class _TestViewState extends State<TestView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Center(
        child: MaterialButton(
          onPressed: () async {
            await FirebaseTest().getAllFileInRef();
          },
          color: Colors.amberAccent,
          child: const Text('click'),
        ),
      )),
    );
  }
}
