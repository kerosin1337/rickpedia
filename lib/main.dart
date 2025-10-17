import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/api/dio_client.dart';
import 'features/character/bloc/character_bloc.dart';
import 'features/character/data/repository/character_repository.dart';
import 'features/main/cubit/main_cubit.dart';
import 'features/main/presentation/pages/main_page.dart';
import 'shared/theme/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final DioClient dioClient = DioClient();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CharacterBloc(CharacterRepository(dioClient)),
        ),
        BlocProvider(create: (context) => MainCubit()),
      ],
      child: BlocBuilder<MainCubit, MainState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'RickPedia',
            debugShowCheckedModeBanner: false,
            theme: getTheme(Brightness.light),
            darkTheme: getTheme(Brightness.dark),
            themeMode: state.themeMode,
            home: const MainPage(),
          );
        },
      ),
    );
  }
}
