import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:tractian_challenge/features/assets/data/datasources/asset_local_datasource.dart';
import 'package:tractian_challenge/features/assets/data/datasources/location_local_datasource.dart';
import 'package:tractian_challenge/features/assets/domain/repositories/asset_repository.dart';
import 'package:tractian_challenge/features/assets/domain/repositories/location_repository.dart';
import 'package:tractian_challenge/features/assets/domain/usecases/get_assets_usecase.dart';
import 'package:tractian_challenge/features/assets/domain/usecases/get_locations_usecase.dart';
import 'package:tractian_challenge/features/assets/presentation/controller/assets_controller.dart';

import '../features/home/home_page_test.dart';

class MockAssetLocalDataSource extends Mock implements AssetLocalDataSource {}

class MockLocationLocalDataSource extends Mock
    implements LocationLocalDataSource {}

class MockAssetRepository extends Mock implements AssetRepository {}

class MockLocationRepository extends Mock implements LocationRepository {}

class MockGetAssetsUsecase extends Mock implements GetAssetsUsecase {}

class MockGetLocationsUsecase extends Mock implements GetLocationsUsecase {}

class GetItTesterHelper {
  static Future<void> registerAllMocks() async {
    final AssetLocalDataSource mockAssetLocalDataSource =
        MockAssetLocalDataSource();
    final LocationLocalDataSource mockLocationLocalDataSource =
        MockLocationLocalDataSource();
    final AssetRepository mockAssetRepository = MockAssetRepository();
    final LocationRepository mockLocationRepository = MockLocationRepository();
    final GetAssetsUsecase mockGetAssetsUsecase = GetAssetsUseCaseStub();
    final GetLocationsUsecase mockGetLocationsUsecase =
        GetLocationsUseCaseStub();

    GetIt.I
      ..registerSingleton<AssetLocalDataSource>(mockAssetLocalDataSource)
      ..registerSingleton<LocationLocalDataSource>(mockLocationLocalDataSource)
      ..registerSingleton<AssetRepository>(mockAssetRepository)
      ..registerSingleton<LocationRepository>(mockLocationRepository)
      ..registerSingleton<GetAssetsUsecase>(mockGetAssetsUsecase)
      ..registerSingleton<GetLocationsUsecase>(mockGetLocationsUsecase)
      ..registerSingleton<AssetsController>(AssetsController());

    return await GetIt.I.allReady();
  }
}
