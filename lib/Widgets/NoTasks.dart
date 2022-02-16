import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class NoTasks extends StatelessWidget {
  const NoTasks({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top :15, left: 20, right: 20),
        child: DottedBorder(
          borderType: BorderType.RRect,
          radius: Radius.circular(20),
          dashPattern: [10, 10],
          color: Theme.of(context).primaryColor,
          strokeWidth: 2,
          child: Container(
            width: width*0.8,
            height: height*0.1,
            child: Center(
              child: Text(
                "No Tasks for today",
                style: Theme.of(context).textTheme.bodyText1,
              ), 
            ),
          )
        ),
      ),
    );
  }
}