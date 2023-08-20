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
    _settings.clear();
  }

  // The App's State object
  AppState? _state;

  /// Navigates to the Settings Route
  Future<void> routeSettings(BuildContext context) async {
    await Navigator.popAndPushNamed(context, '/settings');
    setChanges();
  }

  // Indicates which settings have changed.
  final _settings = <String>{};

  /// The settings were changed
  bool isChanged() {
    final changed = _settings.isNotEmpty;
    _settings.clear();
    return changed;
  }

  /// Refresh the app if the settings have changed.
  bool setChanges() {
    final changed = isChanged();
    if (changed && _state != null) {
      _state?.setState(() {});
    }
    return changed;
  }

  /// Record the current switch setting
  // ignore: avoid_positional_boolean_parameters
  bool noteChange(String switchName, bool? switchValue) {
    final noted = switchValue != null;
    if (noted) {
      //
      if (_settings.contains(switchName)) {
        _settings.remove(switchName);
      } else {
        _settings.add(switchName);
      }
      // If the setting was on and running but now turned off
      if (switchValue == false && _settings.contains(switchName)) {
        _settings.remove(switchName);
        // Refresh the app now to rid of any debug displays
        _state?.setState(() {});
      }
    }
    return noted;
  }

  ///
  bool? get debugShowCheckedModeBanner =>
      _state?.debugShowCheckedModeBanner ?? true;
  set debugShowCheckedModeBanner(bool? v) {
    //
    setState(() {});

    _state?.debugShowCheckedModeBanner = v ?? false;

    noteChange('debugShowCheckedModeBanner', v);
  }

  ///
  bool? get debugShowMaterialGrid => _state?.debugShowMaterialGrid ?? false;
  set debugShowMaterialGrid(bool? v) {
    //
    setState(() {});

    _state?.debugShowMaterialGrid = v ?? false;

    noteChange('debugShowMaterialGrid', v);
  }

  ///
  bool? get debugPaintSizeEnabled => _state?.debugPaintSizeEnabled ?? false;
  set debugPaintSizeEnabled(bool? v) {
    //
    setState(() {});

    _state?.debugPaintSizeEnabled = v ?? false;

    noteChange('debugPaintSizeEnabled', v);
  }

  ///
  bool? get debugPaintBaselinesEnabled =>
      _state?.debugPaintBaselinesEnabled ?? false;
  set debugPaintBaselinesEnabled(bool? v) {
    //
    setState(() {});

    _state?.debugPaintBaselinesEnabled = v ?? false;

    noteChange('debugPaintBaselinesEnabled', v);
  }

  ///
  bool? get debugPaintLayerBordersEnabled =>
      _state?.debugPaintLayerBordersEnabled ?? false;
  set debugPaintLayerBordersEnabled(bool? v) {
    //
    setState(() {});

    _state?.debugPaintLayerBordersEnabled = v ?? false;

    noteChange('debugPaintLayerBordersEnabled', v);
  }

  ///
  bool? get debugPaintPointersEnabled =>
      _state?.debugPaintPointersEnabled ?? false;
  set debugPaintPointersEnabled(bool? v) {
    //
    setState(() {});

    _state?.debugPaintPointersEnabled = v ?? false;

    noteChange('debugPaintPointersEnabled', v);
  }

  ///
  bool? get debugRepaintRainbowEnabled =>
      _state?.debugRepaintRainbowEnabled ?? false;
  set debugRepaintRainbowEnabled(bool? v) {
    //
    setState(() {});

    _state?.debugRepaintRainbowEnabled = v ?? false;

    noteChange('debugRepaintRainbowEnabled', v);
  }

  ///
  bool? get showPerformanceOverlay => _state?.showPerformanceOverlay ?? false;
  set showPerformanceOverlay(bool? v) {
    //
    setState(() {});

    _state?.showPerformanceOverlay = v ?? false;

    noteChange('showPerformanceOverlay', v);
  }

  ///
  bool? get showSemanticsDebugger => _state?.showSemanticsDebugger ?? false;
  set showSemanticsDebugger(bool? v) {
    //
    setState(() {});

    _state?.showSemanticsDebugger = v ?? false;

    noteChange('showSemanticsDebugger', v);
  }
}
