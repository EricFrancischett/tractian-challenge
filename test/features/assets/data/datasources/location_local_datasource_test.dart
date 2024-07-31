import 'package:flutter_test/flutter_test.dart';
import 'package:tractian_challenge/core/error/exceptions.dart';
import 'package:tractian_challenge/core/generics/status.dart';
import 'package:tractian_challenge/features/assets/data/datasources/location_local_datasource.dart';

main() {
  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  group(
    'LocationLocalDataSourceImpl Tests',
    () {
      final sut = LocationLocalDataSourceImpl();
      String mockJsonPath = 'assets/units/test_unit/locations.json';

      test('should return List of locations when the file is loaded successfully',
          () async {
        //Given
        mockJsonPath = 'assets/units/test_unit/locations.json';
        //When
        final resource =
            await sut.getLocations(locationsFilePath: mockJsonPath);
        //Then
        expect(resource.status, Status.success);
        expect(resource.data, isA<List<Map<String, dynamic>>>());
        expect(resource.data?.length, 4);
      });

      test('should return a FileNotFoundException when the file is not found',
          () async {
        //Given
        mockJsonPath = 'assets/units/test_unit/null.json';
        //When
        final resource =
            await sut.getLocations(locationsFilePath: mockJsonPath);
        //Then
        expect(resource.status, Status.failed);
        expect(resource.error, isA<FileNotFoundException>());
      });

      test('should return a InvalidFormatException when the JSON is invalid',
          () async {
        //Given
        mockJsonPath = 'assets/units/test_unit/bad_format.json';
        //When
        final resource =
            await sut.getLocations(locationsFilePath: mockJsonPath);
        //Then
        expect(resource.status, Status.failed);
        expect(resource.error, isA<InvalidFormatException>());
      });
    },
  );
}
