import 'package:stocks/src/model.dart';

import 'package:stocks/src/view.dart';

import 'package:stocks/src/controller.dart';

///
class DevTools extends StateXController {
  ///
  factory DevTools() => _this ??= DevTools._();
  DevTools._();
  static DevTools? _this;

  @override
  void initState() {
    super.initState();
    _state ??= App.appState;
  }

  // The App's State object
  AppStateX? _state;

  /// Navigates to the Settings Route
  Future<void> routeSettings(BuildContext context) async {
    await Navigator.popAndPushNamed(context, '/settings');
  }

  ///
  bool get debugShowCheckedModeBanner =>
      _debugShowCheckedModeBanner ??
      Prefs.getBool('debugShowCheckedModeBanner', false);
  set debugShowCheckedModeBanner(bool? v) {
    //
    if (v != null) {
      //
      Prefs.setBool('debugShowCheckedModeBanner', v);

      setState(() {});

      _debugShowCheckedModeBanner = v;

      _state?.setState(() {});
    }
  }

  bool? _debugShowCheckedModeBanner;

  ///
  bool get debugShowMaterialGrid =>
      _debugShowMaterialGrid ?? Prefs.getBool('debugShowMaterialGrid', false);
  set debugShowMaterialGrid(bool? v) {
    //
    if (v != null) {
      //
      Prefs.setBool('debugShowMaterialGrid', v);

      setState(() {});

      _debugShowMaterialGrid = v;

      _state?.setState(() {});
    }
  }

  bool? _debugShowMaterialGrid;

  ///
  bool get debugPaintSizeEnabled =>
      _state?.debugPaintSizeEnabled ??
      Prefs.getBool('debugPaintSizeEnabled', false);
  set debugPaintSizeEnabled(bool? v) {
    //
    if (v != null) {
      //
      Prefs.setBool('debugPaintSizeEnabled', v);

      setState(() {});

      _state?.debugPaintSizeEnabled = v;

      _state?.setState(() {});
    }
  }

  ///
  bool get debugPaintBaselinesEnabled =>
      _state?.debugPaintBaselinesEnabled ??
      Prefs.getBool('debugPaintBaselinesEnabled', false);
  set debugPaintBaselinesEnabled(bool? v) {
    //
    if (v != null) {
      //
      Prefs.setBool('debugPaintBaselinesEnabled', v);

      setState(() {});

      _state?.debugPaintBaselinesEnabled = v;

      _state?.setState(() {});
    }
  }

  ///
  bool get debugPaintLayerBordersEnabled =>
      _state?.debugPaintLayerBordersEnabled ??
      Prefs.getBool('debugPaintLayerBordersEnabled', false);
  set debugPaintLayerBordersEnabled(bool? v) {
    //
    if (v != null) {
      //
      Prefs.setBool('debugPaintLayerBordersEnabled', v);

      setState(() {});

      _state?.debugPaintLayerBordersEnabled = v;

      _state?.setState(() {});
    }
  }

  ///
  bool get debugPaintPointersEnabled =>
      _state?.debugPaintPointersEnabled ??
      Prefs.getBool('debugPaintPointersEnabled', false);
  set debugPaintPointersEnabled(bool? v) {
    //
    if (v != null) {
      //
      Prefs.setBool('debugPaintPointersEnabled', v);

      setState(() {});

      _state?.debugPaintPointersEnabled = v;

      _state?.setState(() {});
    }
  }

  ///
  bool get debugRepaintRainbowEnabled =>
      _state?.debugRepaintRainbowEnabled ??
      Prefs.getBool('debugRepaintRainbowEnabled', false);
  set debugRepaintRainbowEnabled(bool? v) {
    //
    if (v != null) {
      //
      Prefs.setBool('debugRepaintRainbowEnabled', v);

      setState(() {});

      _state?.debugRepaintRainbowEnabled = v;

      _state?.setState(() {});
    }
  }

  ///
  bool get showPerformanceOverlay =>
      _showPerformanceOverlay ?? Prefs.getBool('showPerformanceOverlay', false);
  set showPerformanceOverlay(bool? v) {
    //
    if (v != null) {
      //
      Prefs.setBool('showPerformanceOverlay', v);

      setState(() {});

      _showPerformanceOverlay = v;

      _state?.setState(() {});
    }
  }

  bool? _showPerformanceOverlay;

  ///
  bool get showSemanticsDebugger =>
      _showSemanticsDebugger ?? Prefs.getBool('showSemanticsDebugger', false);
  set showSemanticsDebugger(bool? v) {
    //
    if (v != null) {
      //
      Prefs.setBool('showSemanticsDebugger', v);

      setState(() {});

      _showSemanticsDebugger = v;

      _state?.setState(() {});
    }
  }

  bool? _showSemanticsDebugger;
}
