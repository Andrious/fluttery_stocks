import 'package:stocks/src/view.dart';

import 'package:stocks/src/controller.dart';

import 'package:stocks/src/model.dart';

import 'package:flutter/scheduler.dart' show timeDilation;

///
class ControllerWidgets {
  ///
  ControllerWidgets(this._con) {
    // An AppBar class
    _appBar = _PopupMenu(_con);
  }

  final StockHomeController _con;

  late _PopupMenu _appBar;

  ///
  PreferredSizeWidget get appBar =>
      _appBar._isSearching ? _con.buildSearchBar() : _con.buildAppBar();

  ///
  Widget get appBarTitle => _appBar.appBarTitle;

  ///
  Widget get search => _appBar.search;

  ///
  Widget get popMenu => _appBar.popMenu;

  ///
  Widget get market => _appBar.market;

  ///
  Widget get portfolio => _appBar.portfolio;

  /// Radio button for an optimistic mood
  Radio<StockMood> get optimistic => Radio<StockMood>(
        value: StockMood.optimistic,
        groupValue: _con.app.stockMood,
        onChanged: _con.onChange,
      );

  /// Radio button for a pessimistic mood
  Radio<StockMood> get pessimistic => Radio<StockMood>(
        value: StockMood.pessimistic,
        groupValue: _con.app.stockMood,
        onChanged: _con.onChange,
      );

  ///
  Checkbox get toOptimistic => Checkbox(
        value: _con.app.stockMood == StockMood.optimistic,
        onChanged: _con.onTap.confirmToOptimistic,
      );

  ///
  void didChangeDependencies() {
    _appBar.stockStrings();
  }

  ///
  Widget get marketTab => _con.buildStockTab(_con.context, StockHomeTab.market,
      _con.app.stocksData.allSymbols.toList());

  ///
  Widget get portfolioTab => _con.buildStockTab(
      _con.context, StockHomeTab.portfolio, _con.portfolioSymbols);
}

enum _StockMenuItem { autorefresh, refresh, speedUp, speedDown }

class _PopupMenu {
  _PopupMenu(this.con) {
    popMenu = PopupMenuButton(
      onSelected: (_StockMenuItem value) {
        _handleStockMenu(con.context, value);
      },
      itemBuilder: (BuildContext context) => <PopupMenuItem<_StockMenuItem>>[
        CheckedPopupMenuItem(
          value: _StockMenuItem.autorefresh,
          checked: _autorefresh,
          child: const Text('Auto refresh'),
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
      onPressed: _onSearch,
      tooltip: 'Search',
    );
  }
  StockHomeController con;
  late PopupMenuButton<_StockMenuItem> popMenu;
  late IconButton search;
  late Tab market;
  late Tab portfolio;
  late Text appBarTitle;

  bool _isSearching = false;
  bool _autorefresh = false;

  void stockStrings() {
    market = Tab(text: StockStrings.of(con.context).market());

    portfolio = Tab(text: StockStrings.of(con.context).portfolio());

    appBarTitle = Text(StockStrings.of(con.context).title());
  }

  void _handleStockMenu(BuildContext context, _StockMenuItem value) {
    switch (value) {
      case _StockMenuItem.autorefresh:
        con.setState(() {
          _autorefresh = !_autorefresh;
        });
        break;
      case _StockMenuItem.refresh:
        showDialog<void>(
          context: context,
          builder: (BuildContext context) => const NotImplementedDialog(),
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

  void _onSearch() {
    ModalRoute.of(con.context)?.addLocalHistoryEntry(LocalHistoryEntry(
      onRemove: () {
        con.setState(() {
          _isSearching = false;
          con.searchQuery.clear();
        });
      },
    ));
    con.setState(() {
      _isSearching = true;
    });
  }
}
