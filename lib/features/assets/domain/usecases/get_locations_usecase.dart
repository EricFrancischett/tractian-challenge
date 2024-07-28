import 'package:get_it/get_it.dart';
import 'package:tractian_challenge/common/entities/location/location_entity.dart';
import 'package:tractian_challenge/common/generics/resource.dart';
import 'package:tractian_challenge/features/assets/domain/repositories/location_repository.dart';

class GetLocationsUsecase {
  LocationRepository locationRepository = GetIt.I<LocationRepository>();

  Future<Resource<List<LocationEntity>, Exception>> call(
      {required String locationsFilePath}) async {
    try {
      final resource = await locationRepository.getLocations(
          locationsFilePath: locationsFilePath);
      if (resource.hasError) {
        return Resource.failed(error: resource.error);
      } else {
        final List<LocationEntity> jsonLocations = resource.data!;
        return Resource.success(data: jsonLocations);
      }
    } catch (error) {
      return Resource.failed(error: Exception(error));
    }
  }
}
