part of 'main_cubit.dart';

final class MainState {
  final ThemeMode themeMode;

  const MainState({this.themeMode = ThemeMode.dark});

  MainState copyWith({ThemeMode? themeMode}) {
    return MainState(themeMode: themeMode ?? this.themeMode);
  }
}
