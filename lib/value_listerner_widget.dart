import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ValueListernerWidget extends StatefulWidget {
  @override
  _ValueListernerWidget createState() => _ValueListernerWidget();
}

class _ValueListernerWidget extends State<ValueListernerWidget> {
  // int counter = 0;
  ValueNotifier incerement = ValueNotifier(0);

  // @override
  // void didChangeDependencies() {
  //   // TODO: implement didChangeDependencies
  //   super.didChangeDependencies();
  //   incerement=ValueNotifier()
  // }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   incerement =
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Value listerenr"),
      ),
      body: ValueListenableBuilder(
        valueListenable: incerement,
        builder: (context, value, child) {
          return Center(
            child: Text("${incerement.value}"),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          incerement.value++;
          // incerement.value.
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
