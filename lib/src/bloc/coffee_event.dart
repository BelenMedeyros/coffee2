import 'package:coffe_app/src/models/coffee_image.dart';
import 'package:equatable/equatable.dart';

abstract class CoffeeEvent extends Equatable {
  const CoffeeEvent();
}

class FetchImages extends CoffeeEvent {
  @override
  List<Object?> get props => [];
}

class RefreshImages extends CoffeeEvent {
  @override
  List<Object?> get props => [];
}


class DownloadImage extends CoffeeEvent {
  final CoffeeImage coffeeImage;
  final int index;

  DownloadImage({required this.coffeeImage, required this.index});

  @override
  List<Object?> get props => [coffeeImage, index];
}

class ImageErrorEvent extends CoffeeEvent {
  final String errorMessage;

  ImageErrorEvent(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}


