import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:tractian_challenge/core/enums/units_enum.dart';
import 'package:tractian_challenge/core/widgets/custom_scaffold.dart';
import 'package:tractian_challenge/features/assets/presentation/view/components/assets_text_field.dart';
import 'package:tractian_challenge/features/assets/presentation/view/components/selectable_assets_button.dart';
import 'package:tractian_challenge/features/assets/presentation/view/components/tree_view.dart';
import 'package:tractian_challenge/features/assets/presentation/controller/assets_controller.dart';

class AssetsPage extends StatefulWidget {
  final UnitsEnum unit;
  const AssetsPage({
    super.key,
    required this.unit,
  });

  @override
  State<AssetsPage> createState() => _AssetsPageState();
}

class _AssetsPageState extends State<AssetsPage> {
  late AssetsController controller;
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    controller = GetIt.I<AssetsController>();
    _searchController = TextEditingController();
    _searchController.addListener(() {
      controller.setSearchQuery(_searchController.text);
    });
    controller.loadTreeNodes(widget.unit);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      pageTitle: widget.unit.unitName,
      padding: const EdgeInsets.all(16),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          AssetsTextField(
            searchController: _searchController,
            labelText: 'Buscar Ativos ou Local',
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Observer(
                  builder: (_) => SelectableButton(
                    variant: SelectableButtonVariant.energy,
                    isSelected: controller.showEnergySensors,
                    onChanged: (value) {
                      controller.setShowEnergySensors(value ?? false);
                    },
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Observer(
                  builder: (_) => SelectableButton(
                    variant: SelectableButtonVariant.alert,
                    isSelected: controller.showCriticalStatus,
                    onChanged: (value) {
                      controller.setShowCriticalStatus(value ?? false);
                    },
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Observer(
              builder: (_) {
                if (controller.futureTreeNodes == null) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.futureTreeNodes!.status ==
                    FutureStatus.rejected) {
                  return Center(
                      child:
                          Text('Error: ${controller.futureTreeNodes!.error}'));
                }

                if (controller.futureTreeNodes!.status ==
                        FutureStatus.fulfilled &&
                    controller.futureTreeNodes!.value!.isEmpty) {
                  return const Center(child: Text('No assets found.'));
                }

                return TreeView(nodes: controller.filteredNodes);
              },
            ),
          ),
        ],
      ),
    );
  }
}
