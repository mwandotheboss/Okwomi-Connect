import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'screens/auth_screen.dart';
import 'screens/privacy_policy_page.dart';
import 'screens/terms_of_service_page.dart';
import 'screens/home_page.dart';
import 'screens/about_page.dart';
import 'screens/events_page.dart';
import 'screens/contact_page.dart';
import 'screens/dashboard_page.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final themeModeProvider = StateNotifierProvider<ThemeModeNotifier, ThemeMode>((ref) => ThemeModeNotifier());

class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  ThemeModeNotifier() : super(ThemeMode.system);

  bool _hasUserSetTheme = false;

  Future<void> loadUserTheme() async {
    if (_hasUserSetTheme) return;
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    final doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
    final theme = doc.data()?['theme'] as String?;
    if (theme == 'light') {
      state = ThemeMode.light;
    } else if (theme == 'dark') {
      state = ThemeMode.dark;
    } else {
      state = ThemeMode.system;
    }
  }

  Future<void> setTheme(ThemeMode mode) async {
    _hasUserSetTheme = true;
    state = mode;
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'theme': mode == ThemeMode.light ? 'light' : mode == ThemeMode.dark ? 'dark' : 'system',
      }, SetOptions(merge: true));
    }
  }
}

void main() async {
  usePathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyCyA5ndTPSO-0-xX8EJXYqzOa7NgkXx6kE",
        authDomain: "okwomi-connect.firebaseapp.com",
        projectId: "okwomi-connect",
        storageBucket: "okwomi-connect.firebasestorage.app",
        messagingSenderId: "926888649657",
        appId: "1:926888649657:web:4a8abebd1ff19960218c68",
        measurementId: "G-HYB6CCHKE5",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const ProviderScope(child: OkwomiConnect()));
}

class OkwomiConnect extends ConsumerWidget {
  const OkwomiConnect({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Okwomi Connect',
      theme: ThemeData(
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color(0xFF0B9FAB), // Teal Accent
          onPrimary: Color(0xFFFFFFFF),
          secondary: Color(0xFF213243), // Soft Navy
          onSecondary: Color(0xFF233344), // Deep Navy
          background: Color(0xFFFFFFFF), // White
          onBackground: Color(0xFF233344), // Deep Navy
          surface: Color(0xFFF8F8F8), // Card/Surface
          onSurface: Color(0xFF233344), // Deep Navy
          error: Colors.red,
          onError: Colors.white,
        ),
        fontFamily: 'NotoSans',
        textTheme: TextTheme(
          bodyLarge: TextStyle(fontSize: 16, color: Color(0xFF233344)), // Primary Text
          bodyMedium: TextStyle(fontSize: 16, color: Color(0xFF213243)), // Secondary Text
          titleLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF233344)),
          titleMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF213243)),
          headlineSmall: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF233344)),
          displaySmall: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF233344)),
        ),
        dividerColor: Color(0xFFCCCCCC), // Borders/Icons
        iconTheme: const IconThemeData(color: Color(0xFF213243)),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: const ColorScheme(
          brightness: Brightness.dark,
          primary: Color(0xFF0B9FAB), // Teal Accent
          onPrimary: Color(0xFF233344), // Deep Navy
          secondary: Color(0xFF213243), // Soft Navy
          onSecondary: Color(0xFFdad9d5), // Light Beige/Off-white
          background: Color(0xFF233344), // Deep Navy
          onBackground: Color(0xFFFFFFFF), // White
          surface: Color(0xFF213243), // Card/Surface
          onSurface: Color(0xFFdad9d5), // Secondary Text
          error: Colors.red,
          onError: Colors.white,
        ),
        fontFamily: 'NotoSans',
        textTheme: TextTheme(
          bodyLarge: TextStyle(fontSize: 16, color: Color(0xFFFFFFFF)), // Primary Text
          bodyMedium: TextStyle(fontSize: 16, color: Color(0xFFdad9d5)), // Secondary Text
          titleLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFFFFFFFF)),
          titleMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFFdad9d5)),
          headlineSmall: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFFFFFFFF)),
          displaySmall: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFFFFFFFF)),
        ),
        dividerColor: Color(0xFF444C56), // Borders/Icons
        iconTheme: const IconThemeData(color: Color(0xFFdad9d5)),
        useMaterial3: true,
      ),
      themeMode: themeMode,
      home: const HomePage(),
      routes: {
        '/login': (context) => const AuthScreen(),
        '/dashboard': (context) => const DashboardPage(),
        '/privacy': (context) => const PrivacyPolicyPage(),
        '/terms': (context) => const TermsOfServicePage(),
      },
      builder: (context, child) {
        return ThemeSwitcher(child: child!);
      },
    );
  }
}

class ThemeSwitcher extends ConsumerWidget {
  final Widget child;
  const ThemeSwitcher({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InheritedTheme.captureAll(context, child);
  }
}

class _ThemeModeToggle extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    IconData icon;
    String tooltip;
    ThemeMode nextMode;
    if (themeMode == ThemeMode.system) {
      icon = Icons.brightness_auto;
      tooltip = 'Switch to Light Theme';
      nextMode = ThemeMode.light;
    } else if (themeMode == ThemeMode.light) {
      icon = Icons.light_mode;
      tooltip = 'Switch to Dark Theme';
      nextMode = ThemeMode.dark;
    } else {
      icon = Icons.dark_mode;
      tooltip = 'Switch to System Theme';
      nextMode = ThemeMode.system;
    }
    return IconButton(
      icon: Icon(icon),
      tooltip: tooltip,
      onPressed: () {
        ref.read(themeModeProvider.notifier).setTheme(nextMode);
      },
    );
  }
}
