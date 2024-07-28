// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assets_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AssetsController on _AssetsControllerBase, Store {
  Computed<List<TreeNode<dynamic>>>? _$filteredNodesComputed;

  @override
  List<TreeNode<dynamic>> get filteredNodes => (_$filteredNodesComputed ??=
          Computed<List<TreeNode<dynamic>>>(() => super.filteredNodes,
              name: '_AssetsControllerBase.filteredNodes'))
      .value;

  late final _$searchQueryAtom =
      Atom(name: '_AssetsControllerBase.searchQuery', context: context);

  @override
  String get searchQuery {
    _$searchQueryAtom.reportRead();
    return super.searchQuery;
  }

  @override
  set searchQuery(String value) {
    _$searchQueryAtom.reportWrite(value, super.searchQuery, () {
      super.searchQuery = value;
    });
  }

  late final _$showEnergySensorsAtom =
      Atom(name: '_AssetsControllerBase.showEnergySensors', context: context);

  @override
  bool get showEnergySensors {
    _$showEnergySensorsAtom.reportRead();
    return super.showEnergySensors;
  }

  @override
  set showEnergySensors(bool value) {
    _$showEnergySensorsAtom.reportWrite(value, super.showEnergySensors, () {
      super.showEnergySensors = value;
    });
  }

  late final _$showCriticalStatusAtom =
      Atom(name: '_AssetsControllerBase.showCriticalStatus', context: context);

  @override
  bool get showCriticalStatus {
    _$showCriticalStatusAtom.reportRead();
    return super.showCriticalStatus;
  }

  @override
  set showCriticalStatus(bool value) {
    _$showCriticalStatusAtom.reportWrite(value, super.showCriticalStatus, () {
      super.showCriticalStatus = value;
    });
  }

  late final _$futureTreeNodesAtom =
      Atom(name: '_AssetsControllerBase.futureTreeNodes', context: context);

  @override
  ObservableFuture<List<TreeNode<dynamic>>>? get futureTreeNodes {
    _$futureTreeNodesAtom.reportRead();
    return super.futureTreeNodes;
  }

  @override
  set futureTreeNodes(ObservableFuture<List<TreeNode<dynamic>>>? value) {
    _$futureTreeNodesAtom.reportWrite(value, super.futureTreeNodes, () {
      super.futureTreeNodes = value;
    });
  }

  late final _$loadTreeNodesAsyncAction =
      AsyncAction('_AssetsControllerBase.loadTreeNodes', context: context);

  @override
  Future<void> loadTreeNodes(UnitsEnum unit) {
    return _$loadTreeNodesAsyncAction.run(() => super.loadTreeNodes(unit));
  }

  late final _$_AssetsControllerBaseActionController =
      ActionController(name: '_AssetsControllerBase', context: context);

  @override
  void setSearchQuery(String value) {
    final _$actionInfo = _$_AssetsControllerBaseActionController.startAction(
        name: '_AssetsControllerBase.setSearchQuery');
    try {
      return super.setSearchQuery(value);
    } finally {
      _$_AssetsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setShowEnergySensors(bool value) {
    final _$actionInfo = _$_AssetsControllerBaseActionController.startAction(
        name: '_AssetsControllerBase.setShowEnergySensors');
    try {
      return super.setShowEnergySensors(value);
    } finally {
      _$_AssetsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setShowCriticalStatus(bool value) {
    final _$actionInfo = _$_AssetsControllerBaseActionController.startAction(
        name: '_AssetsControllerBase.setShowCriticalStatus');
    try {
      return super.setShowCriticalStatus(value);
    } finally {
      _$_AssetsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
searchQuery: ${searchQuery},
showEnergySensors: ${showEnergySensors},
showCriticalStatus: ${showCriticalStatus},
futureTreeNodes: ${futureTreeNodes},
filteredNodes: ${filteredNodes}
    ''';
  }
}
