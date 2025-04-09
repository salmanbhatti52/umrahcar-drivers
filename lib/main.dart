import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:umrahcar_driver/screens/splash_screen.dart';
import 'package:umrahcar_driver/utils/colors.dart';
import 'package:umrahcar_driver/utils/const.dart';
import 'package:provider/provider.dart';

// ThemeProvider for theme switching
class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData;
  bool _isDarkMode;

  ThemeData get themeData => _themeData;
  bool get isDarkMode => _isDarkMode;

  ThemeProvider(bool isDarkMode)
      : _isDarkMode = isDarkMode,
        _themeData = isDarkMode ? darkTheme : lightTheme;

  void toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    _themeData = _isDarkMode ? darkTheme : lightTheme;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', _isDarkMode);
    notifyListeners();
  }
}

// Light Theme (White-based)
ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: primaryColor, // 0xFF3F85EE
  scaffoldBackgroundColor: mainColor, // 0xFFFFFFFF (White)
  colorScheme: ColorScheme.light(
    primary: primaryColor, // 0xFF3F85EE
    secondary: ConstantColor.textColor, // 0xFF333333 (Dark text for contrast)
    surface: mainColor, // 0xFFFFFFFF
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: ConstantColor.textColor, // 0xFF333333
    background: ConstantColor.backgroundColor, // 0xFFF5F5F5
  ),
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
      color: ConstantColor.textColor, // 0xFF333333
      fontSize: 20,
      fontFamily: 'Montserrat-Regular',
      fontWeight: FontWeight.bold,
    ),
    bodyMedium: TextStyle(
      color: ConstantColor.textColor, // 0xFF333333
      fontSize: 16,
      fontFamily: 'Montserrat-Regular',
    ),
    labelMedium: TextStyle(
      color: ConstantColor.darkgreyColor, // 0xFF666666
      fontSize: 12,
      fontFamily: 'Montserrat-Regular',
      fontWeight: FontWeight.w500,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: mainColor, // 0xFFFFFFFF
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(
        color: ConstantColor.dividerColor, // 0xFFE0E0E0
        width: 1.5,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(
        color: primaryColor.withOpacity(0.7), // 0xFF3F85EE with opacity
        width: 1.5,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(
        color: ConstantColor.errorColor, // 0xFFFF0000
        width: 1.5,
      ),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: buttonColor, // 0xFF3F85EE
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      shadowColor: ConstantColor.shadowColor, // 0x1A000000
      elevation: 4,
    ),
  ),
  useMaterial3: false,
);

// Dark Theme (Black-based)
ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: primaryColor, // 0xFF3F85EE
  scaffoldBackgroundColor: Colors.black, // Black background
  colorScheme: ColorScheme.dark(
    primary: primaryColor, // 0xFF3F85EE
    secondary: Colors.white, // White for contrast
    surface: Colors.black,
    onPrimary: Colors.black,
    onSecondary: Colors.black,
    onSurface: Colors.white,
    background: ConstantColor.darkgreyColor, // 0xFF666666
  ),
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontFamily: 'Montserrat-Regular',
      fontWeight: FontWeight.bold,
    ),
    bodyMedium: TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontFamily: 'Montserrat-Regular',
    ),
    labelMedium: TextStyle(
      color: Colors.white70,
      fontSize: 12,
      fontFamily: 'Montserrat-Regular',
      fontWeight: FontWeight.w500,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.black,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(
        color: ConstantColor.lightgreyColor.withOpacity(0.3), // 0xFFCCCCCC
        width: 1.5,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(
        color: primaryColor.withOpacity(0.7), // 0xFF3F85EE with opacity
        width: 1.5,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(
        color: ConstantColor.errorColor, // 0xFFFF0000
        width: 1.5,
      ),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: buttonColor, // 0xFF3F85EE
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      shadowColor: Colors.white.withOpacity(0.4),
      elevation: 4,
    ),
  ),
  useMaterial3: false,
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final isDarkMode = prefs.getBool('isDarkMode') ?? false; // Default to light mode

  runApp(MyApp(initialDarkMode: isDarkMode));
}

class MyApp extends StatefulWidget {
  final bool? initialDarkMode;

  const MyApp({super.key, this.initialDarkMode});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void configOneSignal() {
    OneSignal.initialize(onesignalAppId);
  }

  @override
  void initState() {
    configOneSignal();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(widget.initialDarkMode!),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'UmrahCar Driver',
            debugShowCheckedModeBanner: false,
            theme: themeProvider.themeData,
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}