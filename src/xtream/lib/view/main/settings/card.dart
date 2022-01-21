import 'package:flutter/material.dart';
import 'package:xtream/util/colors.dart';

class SettingsCard extends StatelessWidget {
  SettingsCard({Key? key, required this.text, required this.action}) : super(key: key);

  final String text;
  final VoidCallback action;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
          color: PersonalizedColor.black1,
          child: ListTile(
            title: Text(text, style: const TextStyle(
              color: Colors.white,
            )
            ),
          )
      ),
      onTap: action,
    );
  }
}
