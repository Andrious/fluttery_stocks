import 'package:stocks/src/view.dart';

import 'package:stocks/src/controller.dart';

/// A class for interaction methods
class ControllerMethods {
  ///
  ControllerMethods(this._con);

  ///
  final StockHomeController _con;

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
  void devTools(BuildContext context) => DevTools().routeSettings(context);

  ///
  void about(BuildContext context) => showAboutDialog(
        context: context,
        applicationVersion: 'version: ${App.version} build: ${App.buildNumber}',
      );

  ///
  void optimistic() => _con.onChange(StockMood.optimistic);

  ///
  void pessimistic() => _con.onChange(StockMood.pessimistic);

  ///
  // ignore: avoid_positional_boolean_parameters
  void confirmToOptimistic([bool? value]) {
    switch (_con.app.stockMood) {
      case StockMood.optimistic:
        onChangedToOptimistic(false);
        break;
      case StockMood.pessimistic:
        showDialog<bool>(
          context: _con.state!.context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Change mood?'),
              content: const Text(
                  'Optimistic means everything is awesome. Are you sure you can handle that?'),
              actions: <Widget>[
                ElevatedButton(
                  child: const Text('NO THANKS'),
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                ),
                ElevatedButton(
                  child: const Text('AGREE'),
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                ),
              ],
            );
          },
        ).then<void>(onChangedToOptimistic);
        break;
    }
  }

  ///
  // ignore: avoid_positional_boolean_parameters
  void onChangedToOptimistic(bool? value) {
    value ??= false;
    _con.app.stockMood = value ? StockMood.optimistic : StockMood.pessimistic;
    _con.state?.notifyClients();
  }
}
