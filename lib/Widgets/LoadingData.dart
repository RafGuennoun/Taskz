import 'package:flutter/material.dart';

class LoadingData extends StatelessWidget {
  const LoadingData({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 25, bottom: 10),
          child: Text(
            'Taday task :',
            style: Theme.of(context).textTheme.bodyText1
          ),
        ),
        
        SizedBox(
          width: width,
          height: height*0.5,
          child: const Center(
            child: SizedBox(
              width: 100,
              height: 100,
              child: CircularProgressIndicator(
                color: Colors.grey ,
              ),
            ),
          ),
        )
      ],
    );
  }
}