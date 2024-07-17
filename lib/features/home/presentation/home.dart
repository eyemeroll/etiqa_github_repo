
import 'package:etiqa_github_repo/features/home/presentation/widget/repo_widget.dart';
import 'package:etiqa_github_repo/features/settings/presentation/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {

  int currentIndex = 0;

  var screens =  const [ RepoWidget(), SettingsWidget()];

  @override
  Widget build(BuildContext context) {

    

    return Scaffold(
      appBar: AppBar(
        title: const Text('Trending Repos'),
      ),
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index){
          setState(() {
            currentIndex = index;
          });
        },
        items: const [BottomNavigationBarItem(
          
        label: 'Home',
        icon: Icon(Icons.home)
        
        ),
        BottomNavigationBarItem(
          label: 'Settings',
          icon: Icon(Icons.settings))],),
      );
  }
}
