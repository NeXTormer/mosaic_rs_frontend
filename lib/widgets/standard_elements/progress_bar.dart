import 'package:flutter/material.dart';

import '../../main.dart';

class ProgressBar extends StatelessWidget {
  ProgressBar(this.progress, this.text,
      {this.alternateColor = false, this.thickness = 6, this.length = 180});

  final double thickness;
  final double length;
  final double progress;
  final String text;

  final bool alternateColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          this.text,
          style: TextStyle(color: theme.greyTextColor, fontSize: 12),
        ),
        const SizedBox(height: 4),
        Container(
            height: thickness,
            width: length,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(100)),
              child: TweenAnimationBuilder<double>(
                  duration: const Duration(milliseconds: 150),
                  curve: Curves.easeInOut,
                  tween: Tween<double>(begin: 0, end: progress),
                  builder: (context, value, child) {
                    return LinearProgressIndicator(
                      value: value,
                      backgroundColor: alternateColor
                          ? theme.accentColorLight.withAlpha(255)
                          : theme.mainColorLight,
                      valueColor: AlwaysStoppedAnimation<Color>(
                          alternateColor ? theme.accentColor : theme.mainColor),
                    );
                  }),
            )),
      ],
    );
  }
}
