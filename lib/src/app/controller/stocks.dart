import 'package:stocks/src/model.dart';
import 'package:stocks/src/view.dart';
import 'package:stocks/src/controller.dart';

///
class AppStocks extends AppController {
  ///
  factory AppStocks([StateX? state]) => _this ??= AppStocks._(state);
  AppStocks._([StateX? state]) : super(state) {
    _stocks = StockData();
  }
  static AppStocks? _this;

  @override
  Future<bool> initAsync() async {
    // Retrieve its data
    return _stocks.initAsync();
  }

  @override
  void initState() {
    super.initState();
    _state = state as AppState;
  }

  static AppState? _state;

  ///
  static StockData get stocks => _stocks;
  static late StockData _stocks;

  ///
  static ThemeData get theme {
    switch (stockMode) {
      case StockMode.optimistic:
        return ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.purple,
        );
      case StockMode.pessimistic:
        final theme = ThemeData(
          brightness: Brightness.dark,
        );
        return theme.copyWith(
          colorScheme: theme.colorScheme.copyWith(secondary: Colors.redAccent),
        );
    }
//    return null;
  }

  ///
  static set theme(ThemeData v) {
    _state?.theme = v;
    _state?.refresh();
  }

  ///
  static StockMode get stockMode => _stockMode;
  static set stockMode(StockMode v) {
    _stockMode = v;
    _state?.theme = theme;
    _state?.refresh();
  }

  static StockMode _stockMode = StockMode.optimistic;

  ///
  static BackupMode get backupMode => _backupMode;
  static set backupMode(BackupMode v) {
    _backupMode = v;
    _state?.refresh();
  }

  static BackupMode _backupMode = BackupMode.enabled;

  ///
  static final _StocksLocalizationsDelegate localizationsDelegate =
      _StocksLocalizationsDelegate();

  ///
  static StockSymbolPage symbolPage({required String symbol}) =>
      StockSymbolPage(symbol: symbol, stocks: AppStocks.stocks);
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
