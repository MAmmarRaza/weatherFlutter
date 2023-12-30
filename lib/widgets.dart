import 'package:flutter/material.dart';

class Widgets extends StatelessWidget {
  const Widgets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
                'Descendant widgets obtain the current AppBarTheme object with AppBarTheme.of(context). Instances of AppBarTheme can be customized with AppBarTheme.copyWith.'),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
