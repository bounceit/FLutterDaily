import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.pink[900],
        appBar: AppBar(
        title: Text('Тренировка'),
    centerTitle: true,

    ),
    body: Column(
      children: [
        Text('Main Screen'),
        ElevatedButton(onPressed: () {
          Navigator.pushReplacementNamed(context, '/daily');
        }, child: Text('Перейти далее'))
       ],
     ),
    );
  }
}
