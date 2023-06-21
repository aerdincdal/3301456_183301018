import 'package:flutter/material.dart';
import 'package:world_time/notifier_classes.dart';
import 'package:world_time/themeNotifier.dart';
import 'package:provider/provider.dart';

class LanguageSelection extends StatelessWidget {
  const LanguageSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageUpdater>(
      builder: (context, langState, _) => Consumer<ThemeSelector>(
        builder: (context, themeSelector, _) => Text(
          langState.language,
          style: TextStyle(
            color: themeSelector.homeTopBarLanguageColor,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
