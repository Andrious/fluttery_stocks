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
import 'package:flutter/gestures.dart' show DragStartBehavior;

import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

import 'package:stocks/src/model.dart';
import 'package:stocks/src/view.dart';
import 'package:stocks/src/controller.dart';

///
class StockHomeController extends StateXController {
  ///
  factory StockHomeController() => _this ??= StockHomeController._();
  StockHomeController._();
  static StockHomeController? _this;

  @override
  void initState() {
    super.initState();
    _widget = _Widgets(this);
    _onTaps = OnTaps(this);
  }

  @override
  void dispose() {
    _this = null;
    super.dispose();
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
  _Widgets get widget => _widget;
  late _Widgets _widget;

  ///
  OnTaps get onTap => _onTaps;
  late OnTaps _onTaps;

  ///
  BuildContext get context => state!.context;

  ///
  PreferredSizeWidget buildAppBar() {
    return AppBar(
      elevation: 0,
      title: _widget.appBarTitle,
      actions: <Widget>[
        _widget.search,
        _widget.popMenu,
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
        controller: _searchQuery,
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
      animation: Listenable.merge(<Listenable>[_searchQuery, AppStocks.stocks]),
      builder: (BuildContext context, Widget? child) {
        return _buildStockList(
            context,
            _filterBySearchQuery(_getStockList(AppStocks.stocks, stockSymbols))
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

  void _handleStockMenu(BuildContext context, _StockMenuItem value) {
    switch (value) {
      case _StockMenuItem.autorefresh:
        setState(() {
          _autorefresh = !_autorefresh;
        });
        break;
      case _StockMenuItem.refresh:
        showDialog<void>(
          context: context,
          builder: (BuildContext context) => _NotImplementedDialog(),
        );
        break;
      case _StockMenuItem.speedUp:
        timeDilation /= 5.0;
        break;
      case _StockMenuItem.speedDown:
        timeDilation *= 5.0;
        break;
    }
  }

  void _handleSearchBegin() {
    ModalRoute.of(context)?.addLocalHistoryEntry(LocalHistoryEntry(
      onRemove: () {
        setState(() {
          _isSearching = false;
          _searchQuery.clear();
        });
      },
    ));
    setState(() {
      _isSearching = true;
    });
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
    if (_searchQuery.text.isEmpty) {
      return stocks;
    }
    final RegExp regexp = RegExp(_searchQuery.text, caseSensitive: false);
    return stocks.where((Stock stock) => stock.symbol.contains(regexp));
  }

  ///
  // ignore: use_setters_to_change_properties
  void handleStockModeChange(StockMode? value) {
    AppStocks.stockMode = value!;
  }
}

///
enum StockHomeTab { market, portfolio }

class _AppBar {
  _AppBar(this.con) {
    popMenu = PopupMenuButton(
      onSelected: (_StockMenuItem value) {
        con._handleStockMenu(con.context, value);
      },
      itemBuilder: (BuildContext context) => <PopupMenuItem<_StockMenuItem>>[
        CheckedPopupMenuItem(
          value: _StockMenuItem.autorefresh,
          checked: _autorefresh,
          child: const Text('Autorefresh'),
        ),
        const PopupMenuItem(
          value: _StockMenuItem.refresh,
          child: Text('Refresh'),
        ),
        const PopupMenuItem(
          value: _StockMenuItem.speedUp,
          child: Text('Increase animation speed'),
        ),
        const PopupMenuItem(
          value: _StockMenuItem.speedDown,
          child: Text('Decrease animation speed'),
        ),
      ],
    );

    search = IconButton(
      icon: const Icon(Icons.search),
      onPressed: con._handleSearchBegin,
      tooltip: 'Search',
    );
  }
  StockHomeController con;
  late PopupMenuButton<_StockMenuItem> popMenu;
  late IconButton search;
  late Tab market;
  late Tab portfolio;
  late Text appBarTitle;

  void stockStrings() {
    market = Tab(text: StockStrings.of(con.context).market());

    portfolio = Tab(text: StockStrings.of(con.context).portfolio());

    appBarTitle = Text(StockStrings.of(con.context).title());
  }

  // CheckedPopupMenuItem<_StockMenuItem> autoRefresh = CheckedPopupMenuItem(
  //   value: _StockMenuItem.autorefresh,
  //   checked: _autorefresh,
  //   child: const Text('Autorefresh'),
  // );

  // PopupMenuItem<_StockMenuItem> refresh = const PopupMenuItem(
  //   value: _StockMenuItem.refresh,
  //   child: Text('Refresh'),
  // );

  // PopupMenuItem<_StockMenuItem> increase = const PopupMenuItem(
  //   value: _StockMenuItem.speedUp,
  //   child: Text('Increase animation speed'),
  // );

  // PopupMenuItem<_StockMenuItem> decrease = const PopupMenuItem(
  //   value: _StockMenuItem.speedDown,
  //   child: Text('Decrease animation speed'),
  // );
}

// class _FloatingActionButton {
//   _FloatingActionButton(StockHomeController con) {
//     _createCompany = FloatingActionButton(
//       tooltip: 'Create company',
// //      backgroundColor: Theme.of(con.context).accentColor,
//       onPressed: () {
//         showModalBottomSheet<void>(
//           context: con.context,
//           builder: (BuildContext context) => const _CreateCompanySheet(),
//         );
//       },
//       child: const Icon(Icons.add),
//     );
//   }
//   // FloatingActionButton get createCompany => _createCompany;
//   // late FloatingActionButton _createCompany;
// }

class _Widgets {
  _Widgets(this.con) {
    // An AppBar class
    _appBar = _AppBar(con);

//    _body = _Body(con);
  }
  StockHomeController con;
  // late _ListTiles listTiles;
  late _AppBar _appBar;
//  late _Body _body;
  // late _FloatingActionButton _floatingButton;

//  Widget get body => _body.body;

  PreferredSizeWidget get appBar =>
      _isSearching ? con.buildSearchBar() : con.buildAppBar();

  // Widget get stockList => listTiles.stockList;

  // Widget get accountBalance => listTiles.accountBalance;

  // Widget get dumpConsole => listTiles.dumpConsole;

  // Widget get optimistic => listTiles.optimistic;

  // Widget get pessimistic => listTiles.pessimistic;
  //
  // Widget get settings => listTiles.settings;
  //
  // Widget get about => listTiles.about;

  Widget get appBarTitle => _appBar.appBarTitle;

  Widget get search => _appBar.search;

  Widget get popMenu => _appBar.popMenu;

  Widget get market => _appBar.market;

  Widget get portfolio => _appBar.portfolio;

  // Widget get createCompany => const _CreateCompanySheet();

  void didChangeDependencies() {
    // _floatingButton = _FloatingActionButton(con);
    _appBar.stockStrings();
  }

  Widget get marketTab => con.buildStockTab(
      con.context, StockHomeTab.market, AppStocks.stocks.allSymbols.toList());

  Widget get portfolioTab => con.buildStockTab(
      con.context, StockHomeTab.portfolio, con.portfolioSymbols);

// _FloatingActionButton get floatingButton => _floatingButton;
}

// class _CreateCompanySheet extends StatelessWidget {
//   const _CreateCompanySheet({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: const <Widget>[
//         TextField(
//           autofocus: true,
//           decoration: InputDecoration(
//             hintText: 'Company Name',
//           ),
//         ),
//         Text('(This demo is not yet complete.)'),
//         // For example, we could add a button that actually updates the list
//         // and then contacts the server, etc.
//       ],
//     );
//   }
// }

// class _ListTiles {
//   _ListTiles(this.con);
//   StockHomeController con;

// ListTile stockList = const ListTile(
//   leading: Icon(Icons.assessment),
//   title: Text('Stock List'),
//   selected: true,
// );

// ListTile accountBalance = const ListTile(
//   leading: Icon(Icons.account_balance),
//   title: Text('Account Balance'),
//   enabled: false,
// );

// ListTile dumpConsole = ListTile(
//   leading: const Icon(Icons.dvr),
//   title: const Text('Dump App to Console'),
//   onTap: () {
//     try {
//       debugDumpApp();
//       debugDumpRenderTree();
//       debugDumpLayerTree();
//       debugDumpSemanticsTree(DebugSemanticsDumpOrder.traversalOrder);
//     } catch (e, stack) {
//       debugPrint('Exception while dumping app:\n$e\n$stack');
//     }
//   },
// );
//
// ListTile get optimistic => ListTile(
//       leading: const Icon(Icons.thumb_up),
//       title: const Text('Optimistic'),
//       trailing: Radio<StockMode>(
//         value: StockMode.optimistic,
//         groupValue: AppStocks.stockMode,
//         onChanged: con.handleStockModeChange,
//       ),
//       onTap: () {
//         con.handleStockModeChange(StockMode.optimistic);
//         con.state?.setState(() {});
//       },
//     );
//
// ListTile get pessimistic => ListTile(
//       leading: const Icon(Icons.thumb_down),
//       title: const Text('Pessimistic'),
//       trailing: Radio<StockMode>(
//         value: StockMode.pessimistic,
//         groupValue: AppStocks.stockMode,
//         onChanged: con.handleStockModeChange,
//       ),
//       onTap: () {
//         con.handleStockModeChange(StockMode.pessimistic);
//         con.state?.setState(() {});
//       },
//     );
//
// ListTile get settings => ListTile(
//       leading: const Icon(Icons.settings),
//       title: const Text('Settings'),
//       onTap: () => con.onTap.settings(con.context),
//     );
//
// ListTile get about => ListTile(
//       leading: const Icon(Icons.help),
//       title: const Text('About'),
//       onTap: () => con.onTap.about(con.context),
//     );
// }

///
class OnTaps {
  ///
  OnTaps(this.con);

  ///
  StockHomeController con;

  ///
  GestureTapCallback get dumpConsole => () {
        try {
          debugDumpApp();
          debugDumpRenderTree();
          debugDumpLayerTree();
          debugDumpSemanticsTree(DebugSemanticsDumpOrder.traversalOrder);
        } catch (e, stack) {
          debugPrint('Exception while dumping app:\n$e\n$stack');
        }
      };

  ///
  GestureTapCallback get optimistic => () {
        con.handleStockModeChange(StockMode.optimistic);
        con.state?.setState(() {});
      };

  ///
  GestureTapCallback get pessimistic => () {
        con.handleStockModeChange(StockMode.pessimistic);
        con.state?.setState(() {});
      };

  ///
  Future<void> settings(BuildContext context) async {
    await Navigator.popAndPushNamed(context, '/settings');
    Settings().refresh();
  }

  ///
  void about(BuildContext context) {
    showAboutDialog(context: context);
  }
}

// class _Drawer {
//   _Drawer(this.con);
//   StockHomeController con;
//
//   Widget get drawer => Drawer(
//         child: ListView(
//           dragStartBehavior: DragStartBehavior.down,
//           children: <Widget>[
//             const DrawerHeader(child: Center(child: Text('Stocks'))),
//             con.widget.stockList,
//             con.widget.accountBalance,
//             con.widget.dumpConsole,
//             const Divider(),
//             con.widget.optimistic,
//             con.widget.pessimistic,
//             const Divider(),
//             con.widget.settings,
//             con.widget.about,
//           ],
//         ),
//       );
// }

// class _Body {
//   _Body(this.con);
//   StockHomeController con;
//
//   Widget get body => TabBarView(
//         dragStartBehavior: DragStartBehavior.down,
//         children: <Widget>[
//           con.widget.marketTab,
//           con.widget.portfolioTab,
//         ],
//       );
// }

class _NotImplementedDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Not Implemented'),
      content: const Text('This feature has not yet been implemented.'),
      actions: <Widget>[
        ElevatedButton(
          onPressed: debugDumpApp,
          child: Row(
            children: <Widget>[
              const Icon(
                Icons.dvr,
                size: 18,
              ),
              Container(
                width: 8,
              ),
              const Text('DUMP APP TO CONSOLE'),
            ],
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          child: const Text('OH WELL'),
        ),
      ],
    );
  }
}

final TextEditingController _searchQuery = TextEditingController();
bool _isSearching = false;
bool _autorefresh = false;

enum _StockMenuItem { autorefresh, refresh, speedUp, speedDown }
