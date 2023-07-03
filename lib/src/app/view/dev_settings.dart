import 'package:stocks/src/controller.dart';

import 'package:stocks/src/view.dart';

///
class StockSettings extends StatefulWidget {
  ///
  const StockSettings({super.key});

  @override
  _StockSettingsState createState() => _StockSettingsState();
}

///
class _StockSettingsState extends StateX<StockSettings> {
  _StockSettingsState() : super(controller: DevTools()) {
    con = controller as DevTools;
  }
  late DevTools con;

  // Flag set when the App's settings are to be changed.
  bool changed = false;

  @override
  Widget buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Development Tools'),
      ),
      body: _buildSettingsPane(context),
    );
  }

  // The Cupertino interface was not implemented.
  @override
  Widget buildiOS(BuildContext context) => buildAndroid(context);

  ///
  ListView _buildSettingsPane(BuildContext context) {
    final _con = StockHomeController();
    _con.state?.dependOnInheritedWidget(context);
    final List<Widget> widgets = <Widget>[
      ListTile(
        leading: const Icon(Icons.thumb_up),
        title: const Text('Everything is awesome'),
        onTap: _con.onTap.confirmToOptimistic,
        trailing: _con.widget.toOptimistic,
      ),
      ListTile(
        leading: const Icon(Icons.picture_in_picture),
        title: const Text('Show rendering performance overlay'),
        onTap: () {
          con.showPerformanceOverlay = !con.showPerformanceOverlay!;
        },
        trailing: Switch(
          value: con.showPerformanceOverlay!,
          onChanged: (bool value) {
            con.showPerformanceOverlay = value;
          },
        ),
      ),
      ListTile(
        leading: const Icon(Icons.accessibility),
        title: const Text('Show accessibility information'),
        onTap: () {
          con.showSemanticsDebugger = !con.showSemanticsDebugger!;
        },
        trailing: Switch(
          value: con.showSemanticsDebugger!,
          onChanged: (bool value) {
            con.showSemanticsDebugger = value;
          },
        ),
      ),
      ListTile(
        leading: const Icon(Icons.bug_report),
        title: const Text('Show DEBUG banner'),
        onTap: () {
          con.debugShowCheckedModeBanner = !con.debugShowCheckedModeBanner!;
        },
        trailing: Switch(
          value: con.debugShowCheckedModeBanner!,
          onChanged: (bool value) {
            con.debugShowCheckedModeBanner = value;
          },
        ),
      ),
    ];
    // An approach to determine if running in your IDE or not is the assert()
    // i.e. When your in your Debugger or not.
    // The compiler removes assert functions and their content when in Production.
    assert(() {
      // material grid and size construction lines are only available in checked mode
      widgets.addAll(<Widget>[
        ListTile(
          leading: const Icon(Icons.border_clear),
          title: const Text('Show material grid'),
          onTap: () {
            con.debugShowMaterialGrid = !con.debugShowMaterialGrid!;
          },
          trailing: Switch(
            value: con.debugShowMaterialGrid!,
            onChanged: (bool value) {
              con.debugShowMaterialGrid = value;
            },
          ),
        ),
        ListTile(
          leading: const Icon(Icons.border_all),
          title: const Text('Paint construction lines'),
          onTap: () {
            con.debugPaintSizeEnabled = !con.debugPaintSizeEnabled!;
          },
          trailing: Switch(
            value: con.debugPaintSizeEnabled!,
            onChanged: (bool value) {
              con.debugPaintSizeEnabled = value;
            },
          ),
        ),
        ListTile(
          leading: const Icon(Icons.format_color_text),
          title: const Text('Show character baselines'),
          onTap: () {
            con.debugPaintBaselinesEnabled = !con.debugPaintBaselinesEnabled!;
          },
          trailing: Switch(
            value: con.debugPaintBaselinesEnabled!,
            onChanged: (bool value) {
              con.debugPaintBaselinesEnabled = value;
            },
          ),
        ),
        ListTile(
          leading: const Icon(Icons.filter_none),
          title: const Text('Highlight layer boundaries'),
          onTap: () {
            con.debugPaintLayerBordersEnabled =
                !con.debugPaintLayerBordersEnabled!;
          },
          trailing: Switch(
            value: con.debugPaintLayerBordersEnabled!,
            onChanged: (bool value) {
              con.debugPaintLayerBordersEnabled = value;
            },
          ),
        ),
        ListTile(
          leading: const Icon(Icons.mouse),
          title: const Text('Flash interface taps'),
          onTap: () {
            con.debugPaintPointersEnabled = !con.debugPaintPointersEnabled!;
          },
          trailing: Switch(
            value: con.debugPaintPointersEnabled!,
            onChanged: (bool value) {
              con.debugPaintPointersEnabled = value;
            },
          ),
        ),
        ListTile(
          leading: const Icon(Icons.gradient),
          title: const Text('Highlight repainted layers'),
          onTap: () {
            con.debugRepaintRainbowEnabled = !con.debugRepaintRainbowEnabled!;
          },
          trailing: Switch(
            value: con.debugRepaintRainbowEnabled!,
            onChanged: (bool value) {
              con.debugRepaintRainbowEnabled = value;
            },
          ),
        ),
      ]);
      return true;
    }());
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 20),
      children: widgets,
    );
  }

  // void _handleBackupChanged(bool? value) {
  //   value ??= true;
  //   AppStocks.backupMode = value ? BackupMode.enabled : BackupMode.disabled;
  // }
}
