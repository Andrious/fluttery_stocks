import 'package:stocks/src/view.dart';

import 'package:stocks/src/controller.dart';

/// The initial Widget passed to the runApp()
class MyApp extends AppStatefulWidget {
  ///
  MyApp({super.key});

  @override
  AppState<StatefulWidget> createAppState() => _StocksApp();
}

/// The State object for the Application
class _StocksApp extends AppState<MyApp> {
  /// Supply the 'look and behavior' of the application
  _StocksApp()
      : super(
          controller: AppStocks(),
          title: 'Stocks',
          theme: AppStocks.theme,
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
                builder: (BuildContext context) =>
                    AppStocks.symbolPage(symbol: symbol as String),
              );
            }
            // The other paths we support are in the routes table.
            return null;
          };
}
