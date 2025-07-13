import 'package:befit/services/mealgeneration.dart';
import 'package:flutter/services.dart';
import 'package:befit/pages/SplashScreen.dart';
import 'package:befit/pages/chat_page.dart';
import 'package:befit/services/app_theme.dart';
import 'package:befit/pages/Login_screen.dart';
import 'package:flutter/material.dart';
import 'package:befit/pages/About_page.dart';
import 'package:befit/pages/BMI_calculator.dart';
import 'package:befit/pages/cardio_section.dart';
import 'package:befit/pages/Settings_page.dart';
import 'package:befit/pages/Suggested_page.dart';
import 'package:befit/pages/home_page.dart';
import 'package:befit/pages/intake_page.dart';
import 'package:befit/pages/profile_page.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  runApp(BeFitApp());
}

class BeFitApp extends StatelessWidget {
  BeFitApp({super.key});

  @override
  Widget build(BuildContext context) {
    String userHex = "#743452";
    Color userColor = Color(int.parse(userHex.replaceFirst('#', '0xff')));
    AppTheme.setCustomColor(userColor);
    return GetMaterialApp(
      title: 'Be 𝓯𝓲𝓽',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: SplashScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 2;
  bool _showSettings = false;

  Widget _buildNavItem(
    IconData icon,
    IconData activeIcon,
    String label,
    int index,
  ) {
    final bool isSelected = index == _selectedIndex;
    return Expanded(
      child: GestureDetector(
        onTap: () => _onItemTapped(index),
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Icon(isSelected ? activeIcon : icon, color: AppTheme.titleTextColor)],
        ),
      ),
    );
  }

  Widget _buildSvgNavItem(
    String icon,
    String activeIcon,
    String label,
    int index,
  ) {
    final bool isSelected = index == _selectedIndex;
    return Expanded(
      child: GestureDetector(
        onTap: () => _onItemTapped(index),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              isSelected ? activeIcon : icon,
              width: 24,
              height: 24,
              color: AppTheme.titleTextColor,
            ),
          ],
        ),
      ),
    );
  }

  final List<Widget> _pages = [
    BMIcalculatorPage(),
    DietPage(),
    MainHomePage(),
    SuggestedPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text(
          'вє ƒιт',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w800,
            letterSpacing: 2,
            color: AppTheme.titleTextColor,
            fontFamily: 'Segoe UI',
          ),
        ),
        centerTitle: true,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {
              setState(() {
                _showSettings = !_showSettings;
              });
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppTheme.appBarBg,
                AppTheme.backgroundColor,
                AppTheme.appBarBg,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: AppTheme.drawerHeaderBg,
                  image: DecorationImage(
                    image: AssetImage('assets/Drawer_images/img.png'),
                    fit: BoxFit.cover,
                    opacity: 0.6,
                  ),
                ),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'Welcome, Champ! 💪',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppTheme.titleTextColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.monitor_heart, color: AppTheme.titleTextColor),
                title: Text(
                  'track Workout',
                  style: TextStyle(color: AppTheme.titleTextColor),
                ),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Progresspage()),
                ),
              ),
              ListTile(
                leading: Icon(Icons.chat, color: AppTheme.titleTextColor),
                title: Text(
                  'ASK Be𝓯𝓲𝓽',
                  style: TextStyle(color: AppTheme.titleTextColor),
                ),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChatPage()),
                ),
              ),
              ListTile(
                leading: Icon(Icons.food_bank_sharp, color: AppTheme.titleTextColor),
                title: Text('Meal Generator', style: TextStyle(color: AppTheme.titleTextColor)),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MealChatPage()),
                ),
              ),
              ListTile(
                leading: Icon(Icons.info_outline, color: AppTheme.titleTextColor),
                title: Text('About Us', style: TextStyle(color: AppTheme.titleTextColor)),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Aboutpage()),
                ),
              ),
              ListTile(
                leading: Icon(Icons.logout, color: Colors.redAccent),
                title: Text('Logout', style: TextStyle(color: AppTheme.titleTextColor)),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignInScreen()),
                ),
              ),
            ],
          ),
        ),
      ),

      body: Stack(
        children: [
          _pages[_selectedIndex],
          if (_showSettings)
            Positioned(
              top: kToolbarHeight,
              right: 16,
              left: 16,
              child: SettingsDropdown(
                onClose: () {
                  setState(() {
                    _showSettings = false;
                  });
                },
              ),
            ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: Colors.transparent),
        padding: const EdgeInsets.symmetric(vertical: 8),
        height: 70,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double itemWidth = constraints.maxWidth / 5;
            return Stack(
              children: [
                Row(
                  children: [
                    _buildNavItem(
                      Icons.calculate_outlined,
                      Icons.calculate,
                      'Calculator',
                      0,
                    ),
                    _buildNavItem(
                      Icons.egg_alt_outlined,
                      Icons.egg_alt,
                      'Diet',
                      1,
                    ),
                    _buildNavItem(Icons.home_outlined, Icons.home, 'Home', 2),
                    _buildSvgNavItem(
                      'assets/navbar_icons/dumbell_outlined.svg',
                      'assets/navbar_icons/dumbell.svg',
                      'Workout',
                      3,
                    ),
                    _buildNavItem(
                      Icons.person_outline,
                      Icons.person,
                      'Profile',
                      4,
                    ),
                  ],
                ),
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                  left: _selectedIndex * itemWidth + (itemWidth / 2) - 20,
                  bottom: 8,
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppTheme.titleTextColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
