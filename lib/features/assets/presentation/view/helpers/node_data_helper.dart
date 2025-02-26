import 'package:flutter/material.dart';
import 'package:tractian_challenge/core/adapters/svg_adapter.dart';
import 'package:tractian_challenge/core/constants/assets_constants.dart';
import 'package:tractian_challenge/core/constants/colors_constants.dart';
import 'package:tractian_challenge/core/entities/asset/asset_entity.dart';
import 'package:tractian_challenge/core/entities/location/location_entity.dart';
import 'package:tractian_challenge/features/assets/domain/enums/component_sensor_type_enum.dart';
import 'package:tractian_challenge/features/assets/domain/enums/component_status_enum.dart';
import 'package:tractian_challenge/features/assets/domain/enums/node_type_enum.dart';

class NodeDataHelper {
  static String getNodeName(dynamic data) {
    if (data.name != null) {
      return data.name;
    } else {
      return 'Unknown';
    }
  }

  static NodeTypeEnum? getNodeType(dynamic data) {
    if (data is LocationEntity) {
      return NodeTypeEnum.location;
    } else if (data is AssetEntity) {
      if (data.sensorType != null) {
        return NodeTypeEnum.component;
      } else {
        return NodeTypeEnum.asset;
      }
    } else {
      return null;
    }
  }

  static Widget? getIconByType(NodeTypeEnum? type) {
    switch (type) {
      case NodeTypeEnum.asset:
        return const SvgAdapter(
          path: AssetsConstants.assetIcon,
          width: 20,
          height: 20,
          color: ColorsConstants.darkBlue,
        );
      case NodeTypeEnum.location:
        return const SvgAdapter(
          path: AssetsConstants.locaitonIcon,
          width: 20,
          height: 20,
          color: ColorsConstants.darkBlue,
        );
      case NodeTypeEnum.component:
        return const SvgAdapter(
          path: AssetsConstants.componentIcon,
          width: 20,
          height: 20,
          color: ColorsConstants.darkBlue,
        );
      default:
        return null;
    }
  }

  static ComponentSensorTypeEnum? getComponentSensorType(dynamic data) {
    if (data is AssetEntity) {
      String? sensorType = data.sensorType;
      if (sensorType != null) {
        if (sensorType == 'energy') {
          return ComponentSensorTypeEnum.energy;
        } else if (sensorType == 'vibration') {
          return ComponentSensorTypeEnum.vibration;
        }
      }
    }
    return null;
  }

  static ComponentStatusEnum? getComponentStatus(dynamic data) {
    if (data is AssetEntity) {
      String? status = data.status;
      if (status != null) {
        if (status == 'alert') {
          return ComponentStatusEnum.alert;
        } else if (status == 'operating') {
          return ComponentStatusEnum.operating;
        }
      }
    }
    return null;
  }

  static bool matchesEnergySensorFilter(dynamic data) {
    if (data is AssetEntity) {
      return data.sensorType == 'energy';
    }
    return false;
  }

  static bool matchesCriticalStatusFilter(dynamic data) {
    if (data is AssetEntity) {
      return data.status == 'alert';
    }
    return false;
  }
}
