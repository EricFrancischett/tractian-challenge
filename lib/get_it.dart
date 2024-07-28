import 'package:get_it/get_it.dart';
import 'package:tractian_challenge/features/assets/presentation/controller/assets_controller.dart';

class GetItServiceLocator {
  static final GetIt instance = GetIt.instance;
  GetItServiceLocator();

  static void setUp() {
    // // Data sources
    // instance.registerLazySingleton<AssetLocalDataSource>(() => AssetLocalDataSource());
    // instance.registerLazySingleton<LocationLocalDataSource>(() => LocationLocalDataSource());

    // // Repositories
    // instance.registerLazySingleton<AssetRepository>(() => AssetRepositoryImpl());
    // instance.registerLazySingleton<LocationRepository>(() => LocationRepositoryImpl());

    // // Use cases
    // instance.registerLazySingleton<GetAssets>(() => GetAssets(instance()));
    // instance.registerLazySingleton<GetLocations>(() => GetLocations(instance()));

    // Controllers
    instance.registerSingleton<AssetsController>(AssetsController());
  }
}
