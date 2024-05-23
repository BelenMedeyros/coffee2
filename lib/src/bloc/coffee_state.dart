import 'dart:typed_data';

import 'package:coffe_app/src/models/coffee_image.dart';
import 'package:equatable/equatable.dart';

abstract class CoffeeState extends Equatable{}

class ImageLoading extends CoffeeState {

  @override
  List<Object?> get props => [];
}


class ImageLoaded extends CoffeeState {
  final List<CoffeeImage> imageUrls;
  final bool isRefreshing;

  ImageLoaded(this.imageUrls, {this.isRefreshing = false});

  @override
  List<Object?> get props => [imageUrls, isRefreshing];
}

class ImageDownloaded extends CoffeeState {
  final String message;

  ImageDownloaded(this.message);

  @override
  List<Object> get props => [message];
}

class ImageDownloading extends CoffeeState {
  @override
  List<Object?> get props => [];
}


class ImageError extends CoffeeState {
  final String message;

  ImageError(this.message);

  @override
  List<Object> get props => [message];
}
