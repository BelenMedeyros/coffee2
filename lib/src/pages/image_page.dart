import 'package:coffe_app/src/bloc/coffee_bloc.dart';
import 'package:coffe_app/src/bloc/coffee_event.dart';
import 'package:coffe_app/src/models/coffee_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/coffee_state.dart';

class SingleImagePage extends StatelessWidget {
  const SingleImagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final CoffeeImage imageUrl = arguments['imageBytes'];
    final int index = arguments['index'] as int;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Coffee App',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.5,
              child: Image.memory(
                imageUrl.imageData,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Hero(
              tag: index,
              child: Image.memory(
                imageUrl.imageData,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: BlocConsumer<CoffeeBloc, CoffeeState>(
        listener: (context, state) {
          if (state is ImageDownloaded) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.brown,
                content: Text(state.message),
              ),
            );
          } else if (state is ImageError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.brown,
                content: Text(state.message),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is ImageDownloading) {
            return const CircularProgressIndicator(
              color: Colors.brown,
            );
          } else {
            return FloatingActionButton(
              backgroundColor: Colors.brown,
              onPressed: () {
                BlocProvider.of<CoffeeBloc>(context).add(DownloadImage(index: index, coffeeImage: imageUrl));
              },
              child: const Icon(Icons.download),
            );
          }
        },
      ),
    );
  }
}
