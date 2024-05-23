import 'dart:typed_data';

import 'package:bloc_test/bloc_test.dart';
import 'package:coffe_app/src/bloc/coffee_bloc.dart';
import 'package:coffe_app/src/bloc/coffee_event.dart';
import 'package:coffe_app/src/bloc/coffee_state.dart';
import 'package:coffe_app/src/models/coffee_image.dart';
import 'package:coffe_app/src/repositories/coffeee_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CoffeeBloc', () {
    late CoffeeBloc coffeeBloc;
    late CoffeeRepository coffeeRepository;

    setUp(() {
      coffeeRepository = CoffeeRepository();
      coffeeBloc = CoffeeBloc(coffeeRepository: coffeeRepository);
    });

    tearDown(() {
      coffeeBloc.close();
    });

    test('initial state is ImageLoading', () {
      expect(coffeeBloc.state, isA<ImageLoading>());
    });

    blocTest<CoffeeBloc, CoffeeState>(
      'emits [ImageLoading, ImageLoaded] when FetchImages is added',
      build: () => coffeeBloc,
      act: (bloc) async {
        bloc.add(FetchImages());

        expectLater(
          coffeeBloc.stream,
          emitsInOrder([
            isA<ImageLoading>(),
            isA<ImageLoaded>(),
          ]),
        );
      },
    );

    blocTest<CoffeeBloc, CoffeeState>(
      'emits [ImageLoading, ImageError] when FetchImages is added and there is an error',
      build: () => coffeeBloc,
      act: (bloc) async {
        bloc.add(FetchImages());

        expectLater(
          coffeeBloc.stream,
          emitsInOrder([
            isA<ImageLoading>(),
            isA<ImageError>(),
          ]),
        );
      },
    );

    blocTest<CoffeeBloc, CoffeeState>(
      'emits [ImageDownloading, ImageDownloaded] when DownloadImage is added and image is saved successfully',
      build: () => coffeeBloc,
      act: (bloc) async {
        bloc.add(DownloadImage(coffeeImage: CoffeeImage(imageData: Uint8List(3)), index: 0));

        expectLater(
          coffeeBloc.stream,
          emitsInOrder([
            isA<ImageDownloading>(),
            isA<ImageDownloaded>(),
          ]),
        );
      },
    );

    blocTest<CoffeeBloc, CoffeeState>('emits [ImageDownloading, ImageError] when DownloadImage is added and there is an error saving image',
        build: () => coffeeBloc,
        act: (bloc) async {
          bloc.add(DownloadImage(coffeeImage: CoffeeImage(imageData: Uint8List(3)), index: 0));

          expectLater(
            coffeeBloc.stream,
            emitsInOrder([
              isA<ImageDownloading>(),
              isA<ImageDownloaded>(),
            ]),
          );
        });
  });
}
