import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/pages/location_details_page.dart';
import 'package:rick_and_morty/pages/not_found_page.dart';
import 'package:rick_and_morty/pages/person_details_page.dart';
import 'package:rick_and_morty/pages/person_list_page.dart';
import 'package:rick_and_morty/providers/theme_providers.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
        )
      ],
      child: App(),
    );
  }
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  Brightness? brightness;

  // https://stackoverflow.com/questions/58260648/how-to-listen-for-changes-to-platformbrightness-in-flutter
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    brightness = WidgetsBinding.instance.window.platformBrightness;
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    setState(() {
      brightness = WidgetsBinding.instance.window.platformBrightness;
    });
    super.didChangePlatformBrightness();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      theme: themeProvider.current(brightness),
      title: 'Rick and Morty',
      home: const PersonListPage(),
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      initialRoute: '/',
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          builder: (BuildContext context) {
            return const NotFoundPage();
          },
        );
      },
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case PersonListPage.routeName:
            return MaterialPageRoute(
              builder: (BuildContext context) {
                return const PersonListPage();
              },
            );
          case PersonDetailsPage.routeName:
            final args = settings.arguments as Map<String, dynamic>?;
            if (args != null &&
                args.containsKey("id") &&
                args.containsKey("title")) {
              final int id = args["id"] as int;
              final String title = args["title"] as String;
              return MaterialPageRoute(
                builder: (BuildContext context) {
                  return PersonDetailsPage(
                    id: id,
                    title: title,
                  );
                },
              );
            }
            return MaterialPageRoute(
              builder: (BuildContext context) {
                return const NotFoundPage();
              },
            );
          case LocationDetailsPage.routeName:
            final args = settings.arguments as Map<String, dynamic>?;
            if (args != null &&
                args.containsKey("title") &&
                args.containsKey("url")) {
              final String title = args["title"] as String;
              final String url = args["url"] as String;
              return MaterialPageRoute(
                builder: (BuildContext context) {
                  return LocationDetailsPage(
                    title: title,
                    url: url,
                  );
                },
              );
            }
            return MaterialPageRoute(
              builder: (BuildContext context) {
                return const NotFoundPage();
              },
            );
          default:
            return MaterialPageRoute(
              builder: (BuildContext context) {
                return const NotFoundPage();
              },
            );
        }
      },
    );
  }
}
