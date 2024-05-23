import 'dart:typed_data';
import 'package:coffe_app/src/bloc/coffee_event.dart';
import 'package:coffe_app/src/models/coffee_image.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CoffeeEvent', () {
    test('FetchImages supports value equality', () {
      expect(FetchImages(), equals(FetchImages()));
    });

    test('RefreshImages supports value equality', () {
      expect(RefreshImages(), equals(RefreshImages()));
    });

    test('DownloadImage supports value equality', () {
      final bytes = Uint8List.fromList([0, 1, 2, 3, 4, 5]);
      expect(DownloadImage(index: 1, coffeeImage: CoffeeImage(imageData: bytes)),
          equals(DownloadImage(coffeeImage: CoffeeImage(imageData: bytes), index: 1)));
    });

    test('DownloadImage has correct props', () {
      final bytes = Uint8List.fromList([0, 1, 2, 3, 4, 5]);
      expect(DownloadImage(coffeeImage: CoffeeImage(imageData: bytes), index: 1).props, [bytes, 1]);
    });
  });
}
