import 'package:stocks/src/view.dart';

import 'package:stocks/src/controller.dart';

/// The initial Widget passed to the runApp()
class MyApp extends AppStatefulWidget {
  ///
  MyApp({super.key});
  @override
  AppStateX<StatefulWidget> createAppState() => _StocksAppState();
}

/// The State object for the Application
class _StocksAppState extends AppStateX<MyApp> {
  /// Supply the 'look and behavior' of the application
  _StocksAppState()
      : super(
          controller: AppStocks(),
          title: 'Stocks',
          errorHandler: AppErrorHandler.errorHandler,
          errorScreen: AppErrorHandler.displayErrorWidget,
          inUnknownRoute: AppErrorHandler.onUnknownRoute,
          allowChangeTheme: true,
          localizationsDelegates: <LocalizationsDelegate<dynamic>>[
            AppStocks.localizationsDelegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: const <Locale>[
            Locale('en', 'US'),
            Locale('es', 'ES'),
          ],
        );

  @override
  Map<String, WidgetBuilder> onRoutes() => <String, WidgetBuilder>{
        '/': (BuildContext context) => const StockHome(),
        '/settings': (BuildContext context) => const StockSettings(),
      };

  @override
  MaterialPageRoute<void>? Function(RouteSettings settings)
      onOnGenerateRoute() => (RouteSettings settings) {
            if (settings.name == '/stock') {
              final Object? symbol = settings.arguments;
              return MaterialPageRoute<void>(
                settings: settings,
                builder: (BuildContext context) => (controller as AppStocks)
                    .symbolPage(symbol: symbol as String),
              );
            }
            // The other paths we support are in the routes table.
            return null;
          };

  @override
  bool onShowPerformanceOverlay() => DevTools().showPerformanceOverlay;
  @override
  bool onShowSemanticsDebugger() => DevTools().showSemanticsDebugger;
  @override
  bool onDebugShowCheckedModeBanner() => DevTools().debugShowCheckedModeBanner;
  @override
  bool onDebugShowMaterialGrid() => DevTools().debugShowMaterialGrid;
  @override
  bool onDebugPaintSizeEnabled() => DevTools().debugPaintSizeEnabled;
  @override
  bool onDebugPaintLayerBordersEnabled() => DevTools().debugPaintLayerBordersEnabled;
  @override
  bool onDebugPaintBaselinesEnabled() => DevTools().debugPaintBaselinesEnabled;
  @override
  bool onDebugPaintPointersEnabled() => DevTools().debugPaintPointersEnabled;
  @override
  bool onDebugRepaintRainbowEnabled() => DevTools().debugRepaintRainbowEnabled;
}
