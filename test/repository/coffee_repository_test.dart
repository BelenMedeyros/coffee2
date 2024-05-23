import 'package:coffe_app/src/repositories/coffeee_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:gallery_saver_updated/gallery_saver.dart';

class MockGallerySaver extends Mock implements GallerySaver {}

void main() {
  group('CoffeeRepository', () {
    late CoffeeRepository coffeeRepository;

    setUp(() {
      coffeeRepository = CoffeeRepository();
    });


    test('fetchImages fetches the requested number of images', () async {
      final images = await coffeeRepository.fetchImages(3);

      expect(images.length, 3);

    });

  });
}
