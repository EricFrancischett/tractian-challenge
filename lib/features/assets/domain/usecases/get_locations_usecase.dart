import 'package:get_it/get_it.dart';
import 'package:tractian_challenge/common/entities/location/location_entity.dart';
import 'package:tractian_challenge/features/assets/domain/repositories/location_repository.dart';

class GetLocationsUsecase {
  LocationRepository locationRepository = GetIt.I<LocationRepository>();

  Future<List<LocationEntity>> call({required String locationsFilePath}) async {
    return await locationRepository.getLocations(
        locationsFilePath: locationsFilePath);
  }
}
