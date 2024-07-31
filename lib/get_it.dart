import 'package:get_it/get_it.dart';
import 'package:tractian_challenge/features/assets/data/datasources/asset_local_datasource.dart';
import 'package:tractian_challenge/features/assets/data/datasources/location_local_datasource.dart';
import 'package:tractian_challenge/features/assets/data/repositories/asset_repository_impl.dart';
import 'package:tractian_challenge/features/assets/data/repositories/location_repository_impl.dart';
import 'package:tractian_challenge/features/assets/domain/repositories/asset_repository.dart';
import 'package:tractian_challenge/features/assets/domain/repositories/location_repository.dart';
import 'package:tractian_challenge/features/assets/domain/usecases/get_assets_usecase.dart';
import 'package:tractian_challenge/features/assets/domain/usecases/get_locations_usecase.dart';
import 'package:tractian_challenge/features/assets/presentation/controller/assets_controller.dart';

class GetItServiceLocator {
  static final GetIt instance = GetIt.instance;
  GetItServiceLocator();

  static void setUp() {
    // // Data sources
    instance.registerFactory<AssetLocalDataSource>(
        () => AssetLocalDataSourceImpl());
    instance.registerFactory<LocationLocalDataSource>(
        () => LocationLocalDataSourceImpl());

    // Repositories
    instance.registerFactory<AssetRepository>(() => AssetRepositoryImpl());
    instance
        .registerFactory<LocationRepository>(() => LocationRepositoryImpl());

    // Use cases
    instance.registerFactory<GetAssetsUsecase>(() => DefaultGetAssetsUsecase());
    instance.registerFactory<GetLocationsUsecase>(
        () => DefaultGetLocationsUsecase());

    //Controllers
    instance.registerFactory<AssetsController>(() => AssetsController());
  }
}
