import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/coffee_bloc.dart';
import '../bloc/coffee_event.dart';
import '../bloc/coffee_state.dart';
import '../widgets/loading.dart';

class CoffeeGrid extends StatelessWidget {
  const CoffeeGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoffeeBloc, CoffeeState>(
      builder: (context, state) {
        if (state is ImageLoading || (state is ImageLoaded && state.isRefreshing)) {
          return const Center(
            child: LoadingProgressIndicator(title: 'Loading Coffee images'),
          );
        } else if (state is ImageLoaded) {
          return RefreshIndicator(
            color: Colors.brown,
            onRefresh: () async {
              BlocProvider.of<CoffeeBloc>(context).refresh();
              await Future.delayed(const Duration(seconds: 2));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0).copyWith(bottom: 0),
              child: NotificationListener<ScrollNotification>(
                onNotification: (scrollNotification) {
                  if (scrollNotification is ScrollEndNotification &&
                      scrollNotification.metrics.pixels == scrollNotification.metrics.maxScrollExtent &&
                      !BlocProvider.of<CoffeeBloc>(context).isFetching) {
                    BlocProvider.of<CoffeeBloc>(context).add(FetchImages());
                  }
                  return false;
                },
                child: GridView.builder(
                  itemCount: state.imageUrls.length + 1,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 2.0,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 8.0,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    if (index < state.imageUrls.length) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            'single_image',
                            arguments: {
                              'imageBytes': state.imageUrls[index],
                              'index': index,
                            },
                          );
                        },
                        child: Hero(
                          tag: index,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.memory(
                              state.imageUrls[index].imageData,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    } else {
                      if (!state.isRefreshing && !BlocProvider.of<CoffeeBloc>(context).isFetching) {
                        BlocProvider.of<CoffeeBloc>(context).add(FetchImages());
                      }
                      return const Center(
                        child: LoadingProgressIndicator(height: 60),
                      );
                    }
                  },
                ),
              ),
            ),
          );
        } else if (state is ImageError) {
          return const Center(
            child: Text('Failed to load images'),
          );
        }
        return Container();
      },
    );
  }
}
