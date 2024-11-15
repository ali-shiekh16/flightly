import 'package:flightly/pages/admin-pages/add_flights_page.dart';
import 'package:flightly/pages/admin-pages/feedback_review_page.dart';
import 'package:flightly/pages/admin-pages/promotion_page.dart';
import 'package:flightly/pages/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flightly/app/theme/font.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const AddFlightsPage(),
    const PromotionPage(),
    const FeedbackReviewPage(),
    const HomeScreen(),
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
        title: Text(_selectedIndex == 0
            ? 'Add Flights'
            : _selectedIndex == 1
                ? 'Promotions'
                : 'FeedBack Reviews'),
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
                      'User Screen ',
                      style: TextStyle(fontSize: 20),
                    ),
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    },
                  ),
                ),
              ),
              Divider(
                color: Theme.of(context).dividerColor,
              ),
            ],
          ),
        ),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.add_box_rounded), label: 'Add flight'),
          BottomNavigationBarItem(
              icon: Icon(Icons.discount_rounded), label: 'Promotions'),
          BottomNavigationBarItem(
              icon: Icon(Icons.reviews_rounded), label: 'Reviews'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.red,
      ),
    );
  }
}
