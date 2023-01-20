import 'package:stocks/src/model.dart';

import 'package:stocks/src/view.dart';

import 'package:stocks/src/controller.dart';

///
class Settings extends StateXController {
  ///
  factory Settings() => _this ??= Settings._();
  Settings._();
  static Settings? _this;

  @override
  void initState() {
    super.initState();
    _state ??= App.state;
    _settings.clear();
  }

  // The App's State object
  AppState? _state;
  // Indicates which settings have changed.
  final _settings = <String>{};

  bool _debugShowMaterialGrid = false;

  /// The settings were changed
  bool isChanged() {
    final changed = _settings.isNotEmpty;
    _settings.clear();
    return changed;
  }

  /// Refresh the app if the settings have changed.
  bool refresh() {
    final refreshed = isChanged();
    if (refreshed && _state != null) {
      _state?.setState(() {});
    }
    return refreshed;
  }

  ///
  bool? get debugShowMaterialGrid => _debugShowMaterialGrid;
  set debugShowMaterialGrid(bool? v) {
    //
    setState(() {});

    _state?.debugShowMaterialGrid = _debugShowMaterialGrid = v ?? false;

    if (_settings.contains('debugShowMaterialGrid')) {
      _settings.remove('debugShowMaterialGrid');
    } else {
      _settings.add('debugShowMaterialGrid');
    }
  }

  ///
  bool? get debugPaintSizeEnabled => _state?.debugPaintSizeEnabled;
  set debugPaintSizeEnabled(bool? v) {
    //
    setState(() {});

    _state?.debugPaintSizeEnabled = v ?? false;

    if (_settings.contains('debugPaintSizeEnabled')) {
      _settings.remove('debugPaintSizeEnabled');
    } else {
      _settings.add('debugPaintSizeEnabled');
    }
  }

  ///
  bool? get debugPaintBaselinesEnabled => _state?.debugPaintBaselinesEnabled;
  set debugPaintBaselinesEnabled(bool? v) {
    //
    setState(() {});

    _state?.debugPaintBaselinesEnabled = v ?? false;

    if (_settings.contains('debugPaintBaselinesEnabled')) {
      _settings.remove('debugPaintBaselinesEnabled');
    } else {
      _settings.add('debugPaintBaselinesEnabled');
    }
  }

  ///
  bool? get debugPaintLayerBordersEnabled =>
      _state?.debugPaintLayerBordersEnabled;
  set debugPaintLayerBordersEnabled(bool? v) {
    //
    setState(() {});

    _state?.debugPaintLayerBordersEnabled = v ?? false;

    if (_settings.contains('debugPaintLayerBordersEnabled')) {
      _settings.remove('debugPaintLayerBordersEnabled');
    } else {
      _settings.add('debugPaintLayerBordersEnabled');
    }
  }

  ///
  bool? get debugPaintPointersEnabled => _state?.debugPaintPointersEnabled;
  set debugPaintPointersEnabled(bool? v) {
    //
    setState(() {});

    _state?.debugPaintPointersEnabled = v ?? false;

    if (_settings.contains('debugPaintPointersEnabled')) {
      _settings.remove('debugPaintPointersEnabled');
    } else {
      _settings.add('debugPaintPointersEnabled');
    }
  }

  ///
  bool? get debugRepaintRainbowEnabled => _state?.debugRepaintRainbowEnabled;
  set debugRepaintRainbowEnabled(bool? v) {
    //
    setState(() {});

    _state?.debugRepaintRainbowEnabled = v ?? false;

    if (_settings.contains('debugRepaintRainbowEnabled')) {
      _settings.remove('debugRepaintRainbowEnabled');
    } else {
      _settings.add('debugRepaintRainbowEnabled');
    }
  }

  ///
  bool? get showPerformanceOverlay => _state?.showPerformanceOverlay;
  set showPerformanceOverlay(bool? v) {
    //
    setState(() {});

    _state?.showPerformanceOverlay = v ?? false;

    if (_settings.contains('showPerformanceOverlay')) {
      _settings.remove('showPerformanceOverlay');
    } else {
      _settings.add('showPerformanceOverlay');
    }
  }

  ///
  bool? get showSemanticsDebugger => _state?.showSemanticsDebugger;
  set showSemanticsDebugger(bool? v) {
    //
    setState(() {});

    _state?.showSemanticsDebugger = v ?? false;

    if (_settings.contains('showSemanticsDebugger')) {
      _settings.remove('showSemanticsDebugger');
    } else {
      _settings.add('showSemanticsDebugger');
    }
  }
}
