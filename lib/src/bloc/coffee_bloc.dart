import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/coffee_image.dart';
import '../repositories/coffeee_repository.dart';
import 'coffee_event.dart';
import 'coffee_state.dart';

class CoffeeBloc extends Bloc<CoffeeEvent, CoffeeState> {
  final CoffeeRepository coffeeRepository;
  final List<CoffeeImage> _loadedImages = [];
  bool isFetching = false;

  CoffeeBloc({required this.coffeeRepository}) : super(ImageLoading()) {
    on<FetchImages>(_fetchImages);
    on<RefreshImages>((_, emit) async {
      await _fetchImages(FetchImages(), emit, refresh: true);
    });
    on<DownloadImage>(_downloadImage);
  }

  Future<void> _fetchImages(FetchImages event, Emitter<CoffeeState> emit, {bool refresh = false}) async {
    try {
      isFetching = true;
      if (refresh) {
        _loadedImages.clear();
      }
      final int imagesToLoad = _loadedImages.isEmpty ? 16 : 6;
      final images = await coffeeRepository.fetchImages(imagesToLoad);
      _loadedImages.addAll(images);
      emit(ImageLoaded(List.from(_loadedImages), isRefreshing: refresh));
    } catch (e) {
      emit(ImageError('Error fetching images'));
    } finally {
      isFetching = false;
    }
  }

  void refresh() {
    add(RefreshImages());
  }

  Future<void> _downloadImage(DownloadImage event, Emitter<CoffeeState> emit) async {
    try {
      emit(ImageDownloading());
      await coffeeRepository.downloadAndSaveImage(event.coffeeImage);
      const message = 'Image saved';
      emit(ImageDownloaded(message));
    } catch (e) {
      emit(ImageError('Error downloading image'));
    }
  }
}
