// Flutter
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Internal
import 'package:songtube/internal/focusnodes.dart';
import 'package:songtube/internal/textcontrollers.dart';
import 'package:songtube/provider/player_provider.dart';
import 'package:songtube/ui/themes.dart';
import 'package:songtube/provider/app_provider.dart';
import 'package:songtube/library.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  AppDataProvider provider = AppDataProvider();
  provider.initProvider();
  await Future.delayed(Duration(seconds: 1), () {
    runApp(Main(provider));
  });
}

AppDataProvider appData;

class Main extends StatelessWidget {

  final AppDataProvider provider;
  Main(this.provider);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: provider),
        Provider<FocusNodes>(create: (context) => FocusNodes()),
        Provider<TextControllers>(create: (context) => TextControllers()),
        ChangeNotifierProvider<Player>(create: (context) => Player()),
      ],
      child: Builder( builder: (context) {
        appData = Provider.of<AppDataProvider>(context);
        ThemeData customTheme;
        ThemeData darkTheme;

        darkTheme = appData.blackThemeEnabled 
                    ? AppTheme.black(appData.accentColor)
                    : AppTheme.dark(appData.accentColor);

        customTheme = appData.darkThemeEnabled
                      ? darkTheme
                      : AppTheme.white(appData.accentColor);

        return MaterialApp(
          title: "SongTube",
          theme: appData.systemThemeEnabled
                 ? AppTheme.white(appData.accentColor)
                 : customTheme,
          darkTheme: appData.systemThemeEnabled
                     ? darkTheme
                     : customTheme,
          home: Library(),
        );
      }, ),
    );

  }
}

