import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../character/bloc/character_bloc.dart';
import '../../../character/presentation/pages/characters_page.dart';
import '../../../character/presentation/pages/favorite_characters_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  late final CharacterBloc characterBloc;

  final List<Widget> _screens = [
    const CharactersPage(),
    const FavoriteCharactersPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RickPedia'),
        actions: _selectedIndex == 1
            ? [
                BlocBuilder<CharacterBloc, CharacterState>(
                  buildWhen: (previous, current) => true,
                  builder: (context, state) {
                    return IconButton(
                      onPressed: () {
                        characterBloc.add(FavoriteCharactersChangeSortEvent());
                      },
                      icon: const Icon(Icons.sort),
                    );
                  },
                ),
                const SizedBox(width: 16),
              ]
            : null,
      ),
      body: _screens[_selectedIndex],
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
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedFontSize: 12,
      ),
    );
  }
}
