import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:laundry_app/core/widgets/colors.dart';
import 'package:laundry_app/features/home/presentation/views/widgets/home_screen_body.dart';
import 'package:laundry_app/features/user_profile.dart/presentation/views/user_profile_screen.dart';
import 'package:laundry_app/features/view_order_screen/presentation/views/order_screen.dart';

class HomeScreen extends StatefulWidget {
  
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; // تتبع الصفحة الحالية

  final List<Widget> _pages = [
    HomeScreenBody(), // ✅ تجنب التكرار اللانهائي
    OrderScreen(selectedImage: 'assets/images/location.png',),
    NotificationsPage(),
    UserProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colorss.applicationColor,
      body: _pages[_selectedIndex], // ✅ عرض الصفحة المختارة
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colorss.applicationColor,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        iconSize: 30, // ✅ تكبير الأيقونات
        currentIndex: _selectedIndex,
        onTap: _onItemTapped, // ✅ عند الضغط على أي عنصر يتم التبديل بين الصفحات
        type: BottomNavigationBarType.fixed, // ✅ لمنع تغيير الحجم عند التبديل
        items:  [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'.tr()),
          BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: 'Orders'.tr()),
          BottomNavigationBarItem(icon: Icon(Icons.notifications_none), label: 'Notifications'.tr()),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'.tr()),
        ],
      ),
    );
  }
}

// ✅ صفحات افتراضية للطلبات، الإشعارات، والإعدادات
// class OrdersPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Center(child: Text("Orders Page", style: TextStyle(fontSize: 20))),
//     );
//   }
// }

class NotificationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Notifications Page", style: TextStyle(fontSize: 20))),
    );
  }
}


