import 'dart:typed_data';

import 'package:coffe_app/src/bloc/coffee_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CoffeeState', () {

    test('ImageDownloaded supports value equality', () {
      expect(ImageDownloaded('Image saved'), equals(ImageDownloaded('Image saved')));
    });

    test('ImageDownloaded has correct props', () {
      expect(ImageDownloaded('Image saved').props, ['Image saved']);
    });

    test('ImageError supports value equality', () {
      expect(ImageError('An error occurred'), equals(ImageError('An error occurred')));
    });

    test('ImageError has correct props', () {
      expect(ImageError('An error occurred').props, ['An error occurred']);
    });

    test('ImageLoading supports value equality', () {
      expect(ImageLoading(), equals(ImageLoading()));
    });

    test('ImageDownloading supports value equality', () {
      expect(ImageDownloading(), equals(ImageDownloading()));
    });
  });
}
