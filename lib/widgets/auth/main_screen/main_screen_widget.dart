import 'package:flutter/material.dart';

class MainScreenWidget extends StatefulWidget {
  const MainScreenWidget({super.key});

  @override
  State<MainScreenWidget> createState() => _MainScreenWidgetState();
}

class _MainScreenWidgetState extends State<MainScreenWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text('Drive Test'),
            Expanded(child: SizedBox()),
            IconButton(onPressed: () {}, icon: Icon(Icons.account_box_rounded)),
          ],
        ),
      ),
    );
  }
}
