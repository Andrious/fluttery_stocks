///
/// Copyright (C) 2019 Andrious Solutions
///
/// This program is free software; you can redistribute it and/or
/// modify it under the terms of the GNU General Public License
/// as published by the Free Software Foundation; either version 3
/// of the License, or any later version.
///
/// You may obtain a copy of the License at
///
///  http://www.apache.org/licenses/LICENSE-2.0
///
///
/// Unless required by applicable law or agreed to in writing, software
/// distributed under the License is distributed on an "AS IS" BASIS,
/// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
/// See the License for the specific language governing permissions and
/// limitations under the License.
///
///          Created  12 Jul 2019
///
///
///

import 'package:stocks/src/model.dart';
import 'package:stocks/src/view.dart';
import 'package:stocks/src/controller.dart';

import 'package:stocks/src/home/controller/home_controller_methods.dart';
import 'package:stocks/src/home/controller/home_controller_widgets.dart';

///
class StockHomeController extends StateXController {
  ///
  factory StockHomeController() => _this ??= StockHomeController._();
  StockHomeController._() {
    _appController = AppStocks();
  }
  static StockHomeController? _this;

  /// The App's Controller
  AppStocks get app => _appController;
  late AppStocks _appController;

  @override
  void initState() {
    super.initState();
    // Particular widgets controlled by this controller
    _widget = ControllerWidgets(this);
    // Particular methods used by this controller
    _onTaps = ControllerMethods(this);
  }

  @override
  void didChangeDependencies() {
    _widget.didChangeDependencies();
  }

  ///
  List<String> portfolioSymbols = <String>[
    'AAPL',
    'FIZZ',
    'FIVE',
    'FLAT',
    'ZINC',
    'ZNGA'
  ];

  ///
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  ///
  final TextEditingController searchQuery = TextEditingController();

  /// Access to the Controller's widgets
  ControllerWidgets get widget => _widget;
  late ControllerWidgets _widget;

  /// Access to the Controller's methods
  ControllerMethods get onTap => _onTaps;
  late ControllerMethods _onTaps;

  ///
  BuildContext get context => state!.context;

  ///
  PreferredSizeWidget buildAppBar() {
    return AppBar(
      elevation: 0,
      title: _widget.appBarTitle,
      actions: <Widget>[
        _widget.search,
//        _widget.popMenu,
      ],
      bottom: TabBar(
        tabs: <Widget>[
          _widget.market,
          _widget.portfolio,
        ],
      ),
    );
  }

  ///
  PreferredSizeWidget buildSearchBar() {
    return AppBar(
      leading: const BackButton(),
      title: TextField(
        controller: searchQuery,
        autofocus: true,
        decoration: const InputDecoration(
          hintText: 'Search stocks',
        ),
      ),
      backgroundColor: Theme.of(context).canvasColor,
    );
  }

  ///
  Widget buildStockTab(
      BuildContext context, StockHomeTab tab, List<String> stockSymbols) {
    return AnimatedBuilder(
      key: ValueKey<StockHomeTab>(tab),
      animation: Listenable.merge(
          <Listenable>[searchQuery, _appController.stocksData]),
      builder: (BuildContext context, Widget? child) {
        return _buildStockList(
            context,
            _filterBySearchQuery(
                    _getStockList(_appController.stocksData, stockSymbols))
                .toList(),
            tab);
      },
    );
  }

  Widget _buildStockList(
      BuildContext context, Iterable<Stock> stocks, StockHomeTab tab) {
    return StockList(
      stocks: stocks.toList(),
      onAction: _buyStock,
      onOpen: (Stock stock) {
        Navigator.pushNamed(context, '/stock', arguments: stock.symbol);
      },
      onShow: (Stock stock) {
        scaffoldKey.currentState?.showBottomSheet<void>(
            (BuildContext context) => StockSymbolBottomSheet(stock: stock));
      },
    );
  }

  void _buyStock(Stock stock) {
    setState(() {
      stock.percentChange = 100.0 * (1.0 / stock.lastSale);
      stock.lastSale += 1.0;
    });

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Purchased ${stock.symbol} for ${stock.lastSale}'),
      action: SnackBarAction(
        label: 'BUY MORE',
        onPressed: () {
          _buyStock(stock);
        },
      ),
    ));
  }

  Iterable<Stock> _getStockList(StockData stocks, Iterable<String> symbols) {
    return symbols
        .map<Stock>((String symbol) => stocks[symbol])
        .where((Stock stock) => stock != null);
  }

  Iterable<Stock> _filterBySearchQuery(Iterable<Stock> stocks) {
    if (searchQuery.text.isEmpty) {
      return stocks;
    }
    final RegExp regexp = RegExp(searchQuery.text, caseSensitive: false);
    return stocks.where((Stock stock) => stock.symbol.contains(regexp));
  }

  /// Called when the App's Drawer is opened or closed
  // ignore: avoid_positional_boolean_parameters
  void onDrawerChanged(bool isOpened) {
    if (!isOpened) {}
  }

  ///
  void onChange(StockMood? value) {
    if (value != null) {
      app.stockMood = value;
      setState(() {});
    }
  }
}

///
enum StockHomeTab {
  ///
  market,

  ///
  portfolio,
}
