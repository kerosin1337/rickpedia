import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/features/main/cubit/main_cubit.dart';

class ThemeSwitch extends StatefulWidget {
  const ThemeSwitch({super.key});

  @override
  State<ThemeSwitch> createState() => _ThemeSwitchState();
}

class _ThemeSwitchState extends State<ThemeSwitch> {
  late final MainCubit mainCubit;

  @override
  void initState() {
    super.initState();
    mainCubit = context.read<MainCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Switch(
            value: state.themeMode == ThemeMode.light,
            onChanged: (value) {
              mainCubit.changeTheme();
            },
          ),
        );
      },
    );
  }
}
