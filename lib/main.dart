import 'package:coinedone/repository/dataRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/dataBloc/dataBloc.dart';
import 'ui/dashboard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => DataBloc(repository: DataRepositoryImpl()),
        child: Dashboard(),
      ),
    );
  }
}

