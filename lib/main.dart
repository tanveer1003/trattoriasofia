import 'package:flutter/material.dart';
import 'package:trattoriasofia/views/hourslocation_screen.dart';

void main() {
  runApp(MyApp(false));
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  bool isLogin;
  MyApp(this.isLogin, {super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowMaterialGrid: false,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      initialRoute: isLogin ? "/" : '/',
      routes: {
        '/': (context) => const NavigationExample(),
        '/hourslocation': (context) => const HoursLocationScreen(),
        '/profile': (context) => const HoursLocationScreen(),
      },
    );
  }
}

class NavigationExample extends StatefulWidget {
  const NavigationExample({super.key});

  @override
  State<NavigationExample> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<NavigationExample> {
  int currentPageIndex = 0;

  final screens = [
    const HoursLocationScreen(),
    const HoursLocationScreen(),
    const HoursLocationScreen(),
    const HoursLocationScreen(),
  ]; // Your actual page widgets

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
            screens[currentPageIndex], // Directly access screens based on index
        bottomNavigationBar: NavigationBarTheme(
          data: NavigationBarThemeData(
              labelTextStyle: MaterialStateProperty.resolveWith<TextStyle>(
                (Set<MaterialState> states) =>
                    states.contains(MaterialState.selected)
                        ? const TextStyle(color: Colors.green)
                        : const TextStyle(color: Colors.black),
              ),
              iconTheme: MaterialStateProperty.resolveWith(
                  (Set<MaterialState> states) =>
                      states.contains(MaterialState.selected)
                          ? const IconThemeData(
                              color: Colors.green,
                            )
                          : const IconThemeData(color: Colors.black))),
          child: NavigationBar(
            selectedIndex: currentPageIndex,
            onDestinationSelected: (int index) {
              setState(() {
                currentPageIndex = index;
              });
            },
            destinations: const <Widget>[
              NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home_filled),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(Icons.pages_outlined),
                selectedIcon: Icon(Icons.pages_rounded),
                label: 'Tables',
              ),
              NavigationDestination(
                selectedIcon: Icon(Icons.bookmark),
                icon: Icon(Icons.bookmark_border),
                label: 'Orders',
              ),
              NavigationDestination(
                selectedIcon: Icon(Icons.person),
                icon: Icon(Icons.person_2_outlined),
                label: 'Profile',
              ),
            ],
          ),
        ));
  }
}
