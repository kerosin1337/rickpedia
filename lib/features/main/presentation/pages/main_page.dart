import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/features/character/bloc/character_bloc.dart';
import '/features/character/presentation/pages/characters_page.dart';
import '/features/character/presentation/pages/favorite_characters_page.dart';
import '/features/main/presentation/widgets/favorite_sort_button.dart';
import '/features/main/presentation/widgets/theme_switch.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectedIndex = 0;

  late final CharacterBloc characterBloc;

  final List<Widget> screens = [
    const CharactersPage(),
    const FavoriteCharactersPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    characterBloc = context.read<CharacterBloc>();
    characterBloc
      ..add(CharactersGetEvent())
      ..add(FavoriteCharactersGetAllEvent());
  }

  List<Widget>? get appBarActions {
    return [
      if (selectedIndex == 1)
        const FavoriteSortButton()
      else
        const ThemeSwitch(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('RickPedia'), actions: appBarActions),
      body: screens[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
            activeIcon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            label: 'Search',
            activeIcon: Icon(Icons.favorite),
          ),
        ],
        currentIndex: selectedIndex,
        onTap: _onItemTapped,
        selectedFontSize: 12,
      ),
    );
  }
}
