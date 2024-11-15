import 'package:flutter/material.dart';
import 'home_page.dart';
import 'book_flight_page.dart';
import 'my_trips_page.dart';
import 'profile_page.dart';
import 'package:flightly/app/theme/font.dart';
import 'package:flightly/app/auth/admin_auth_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const BookFlightPage(),
    const MyTripsPage(),
    const ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _selectedIndex == 0
              ? 'Home'
              : _selectedIndex == 1
                  ? 'Book Flight'
                  : _selectedIndex == 2
                      ? 'My Trips'
                      : 'Profile',
        ),
        automaticallyImplyLeading: false,
      ),

      drawer: Container(
        color: Theme.of(context).dialogBackgroundColor,
        width: MediaQuery.of(context).size.width / 1.5,
        child: Padding(
          padding: const EdgeInsets.only(top: 120),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: ListTile(
                  leading: const Icon(
                    Icons.person_3_rounded,
                    size: 30,
                  ),
                  title: InkWell(
                    child: const Text(
                      'Admin login ',
                      style: TextStyle(fontSize: 20),
                    ),
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => adminAuth()),
                      );
                    },
                  ),
                ),
              ),
              Divider(
                color: Theme.of(context).dividerColor,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: ListTile(
                  leading: Icon(
                    Icons.color_lens_sharp,
                    size: 30,
                  ),
                  title: InkWell(
                    child: Text(
                      'xyz',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
              Divider(color: Theme.of(context).dividerColor),
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: ListTile(
                  leading: Icon(
                    Icons.color_lens_sharp,
                    size: 30,
                  ),
                  title: InkWell(
                    child: Text(
                      'xyz',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
              Divider(color: Theme.of(context).dividerColor),
              const Padding(
                padding: const EdgeInsets.only(left: 20),
                child: ListTile(
                  leading: Icon(
                    Icons.color_lens_sharp,
                    size: 30,
                  ),
                  title: InkWell(
                    child: Text(
                      'xyz',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),

      //afzal work close

      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.flight_takeoff), label: 'Book Flight'),
          BottomNavigationBarItem(
              icon: Icon(Icons.trip_origin), label: 'My Trips'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.red,
      ),
    );
  }
}
