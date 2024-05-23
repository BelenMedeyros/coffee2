import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:coffe_app/src/models/coffee_image.dart';
import 'package:gallery_saver_updated/gallery_saver.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class CoffeeRepository {

  Future<List<CoffeeImage>> fetchImages(int count) async {
    final List<CoffeeImage> images = [];
    for (int i = 0; i < count; i++) {
      final response = await http.get(Uri.parse('https://coffee.alexflipnote.dev/random'));
      if (response.statusCode == 200) {
        final Uint8List imageData = response.bodyBytes;
        final CoffeeImage image = CoffeeImage(imageData: imageData);
        images.add(image);
      } else {
        break;
      }
    }
    return images;
  }


  Future<void> downloadAndSaveImage(CoffeeImage coffeeImage) async {
    try {
      Directory temporaryDirectory = await getTemporaryDirectory();
      String tempPath = temporaryDirectory.path;

      File imageFile = File('$tempPath/image.jpg');

      await GallerySaver.saveImage(imageFile.path, albumName: 'Coffee Images');
    } catch (e) {
      print('Error al guardar la imagen: $e');
    }
  }
}
