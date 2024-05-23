import 'package:flutter/material.dart';

class LoadingProgressIndicator extends StatelessWidget {
  const LoadingProgressIndicator({
    Key? key,
    this.title,
    this.height,
  }) : super(key: key);

  final String? title;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/coffeegif.gif',
          color: Colors.brown,
          height: height ?? 150,
        ),
        Text(
          title ?? '',
          style: const TextStyle(
            color: Colors.brown,
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }
}
