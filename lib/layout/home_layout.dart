import 'package:flutter/material.dart';
import 'package:to_do_application/pages/home_screen/home_screen.dart';
import 'package:to_do_application/pages/home_screen/widgets/bottom_sheet_widget.dart';
import 'package:to_do_application/pages/settings_screen/settings_screen.dart';

class HomeLayout extends StatefulWidget {
  static const String routeName = "Home Screen";

  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int selectedIndex = 0;
  List<Widget> screens = [
    const HomeScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      body: screens[selectedIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddTaskBottomSheet();
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 30,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      extendBody: true,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 15,
        color: theme.colorScheme.outline,
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (value) {
            setState(() {
              selectedIndex = value;
            });
          },
          items: const [
            BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage("assets/images/home_icon.png"),
                ),
                label: "Home"),
            BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage("assets/images/settings_icon.png"),
                ),
                label: "Settings"),
          ],
        ),
      ),
    );
  }

  void showAddTaskBottomSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      context: context,
      builder: (context) => Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: const BottomSheetWidget(),
      ),
    );
  }
}
