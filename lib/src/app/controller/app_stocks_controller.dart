import 'package:stocks/src/model.dart';
import 'package:stocks/src/view.dart';
import 'package:stocks/src/controller.dart';

///
class AppStocks extends AppController {
  ///
  factory AppStocks([StateX? state]) => _this ??= AppStocks._(state);
  AppStocks._([StateX? state]) : super(state) {
    _stocksData = StockData();
  }
  static AppStocks? _this;

  @override
  Future<bool> initAsync() async {
    // Retrieve its data
    return _stocksData.initAsync();
  }

  @override
  void initState() {
    super.initState();
    _appState = state as AppState;
    // Initial the general theme of the app
    _initStockMood();
  }

  // The App's first State object
  static AppState? _appState;

  ///
  StockData get stocksData => _stocksData;
  late StockData _stocksData;

  // Initialize a mode
  void _initStockMood() {
    final mode = Prefs.getString('StockMood', 'optimistic');
    stockMood =
        mode == 'optimistic' ? StockMood.optimistic : StockMood.pessimistic;
  }

  ///
  StockMood get stockMood => _mood;
  set stockMood(StockMood v) {
    _mood = v;
    // The App's State object can define the theme
    _appState?.theme = theme;
    _appState?.refresh();
  }

  StockMood _mood = StockMood.optimistic;

  ///
  ThemeData get theme {
    switch (stockMood) {
      case StockMood.optimistic:
        return ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.purple,
        );
      case StockMood.pessimistic:
        final theme = ThemeData(
          brightness: Brightness.dark,
        );
        return theme.copyWith(
          colorScheme: theme.colorScheme.copyWith(secondary: Colors.redAccent),
        );
    }
  }

  ///
  static BackupMode get backupMode => _backupMode;
  static set backupMode(BackupMode v) {
    _backupMode = v;
    _appState?.refresh();
  }

  static BackupMode _backupMode = BackupMode.enabled;

  ///
  static final _StocksLocalizationsDelegate localizationsDelegate =
      _StocksLocalizationsDelegate();

  ///
  StockSymbolPage symbolPage({required String symbol}) =>
      StockSymbolPage(symbol: symbol, stocks: stocksData);
}

class _StocksLocalizationsDelegate extends LocalizationsDelegate<StockStrings> {
  @override
  Future<StockStrings> load(Locale locale) => StockStrings.load(locale);

  @override
  bool isSupported(Locale locale) =>
      locale.languageCode == 'es' || locale.languageCode == 'en';

  @override
  bool shouldReload(_StocksLocalizationsDelegate old) => false;
}
