import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'appTheme.dart';
import 'splashScreen.dart';
import 'modules/bottomTab/bottomTabScreen.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) => runApp(new MyApp()));
  // runApp(new MyApp());
}

class MyApp extends StatefulWidget {
  static restartApp(BuildContext context) {
    final _MyAppState state = context.findAncestorStateOfType<_MyAppState>();

    state.restartApp();
  }

  static setCustomeTheme(BuildContext context) {
    final _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setCustomeTheme();
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Key key = new UniqueKey();

  void restartApp() {
    this.setState(() {
      navigatorKey = new GlobalKey<NavigatorState>();
      key = new UniqueKey();
    });
  }

  void setCustomeTheme() {
    setState(() {
      AppTheme.isLightTheme = !AppTheme.isLightTheme;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness:
          AppTheme.isLightTheme ? Brightness.dark : Brightness.light,
      statusBarBrightness:
          AppTheme.isLightTheme ? Brightness.light : Brightness.dark,
      systemNavigationBarColor:
          AppTheme.isLightTheme ? Colors.white : Colors.black,
      systemNavigationBarDividerColor: Colors.grey,
      systemNavigationBarIconBrightness:
          AppTheme.isLightTheme ? Brightness.dark : Brightness.light,
    ));
    return Container(
      key: key,
      color: AppTheme.getTheme().backgroundColor,
      child: MaterialApp(
          navigatorKey: navigatorKey,
          title: 'Pitch',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.getTheme(),
          routes: routes,
          builder: (BuildContext context, Widget child) {
            return Directionality(
              textDirection: TextDirection.ltr,
              child: Builder(
                builder: (BuildContext context) {
                  return MediaQuery(
                    data: MediaQuery.of(context).copyWith(
                      textScaleFactor: MediaQuery.of(context).size.width > 360
                          ? 1.0
                          : MediaQuery.of(context).size.width >= 340
                              ? 0.9
                              : 0.8,
                    ),
                    child: child,
                  );
                },
              ),
            );
          }),
    );
  }

  var routes = <String, WidgetBuilder>{
    Routes.SPLASH: (BuildContext context) => SplashScreen(),
    Routes.TabScreen: (BuildContext context) => new BottomTabScreen(),
  };
}

class Routes {
  static const String SPLASH = "/";
  static const String TabScreen = "/bottomTab/bottomTabScreen";
}
