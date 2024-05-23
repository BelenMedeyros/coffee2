import 'package:coffe_app/src/bloc/coffee_bloc.dart';
import 'package:coffe_app/src/bloc/coffee_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/coffee_grid.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: BlocProvider(
        create: (context) => BlocProvider.of<CoffeeBloc>(context)..add(FetchImages()),
        child: const CoffeeGrid(),
      ),
    );
  }
}