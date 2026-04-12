import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:protofolio/core/constants/app_constants.dart';
import 'package:protofolio/core/di/service_locator.dart';
import 'package:protofolio/core/utils/url_launcher_service.dart';
import 'package:protofolio/features/portfolio/presentation/pages/portfolio_page.dart';
import 'package:protofolio/features/portfolio/presentation/state/portfolio_controller.dart';

class ProtofolioApp extends StatelessWidget {
  const ProtofolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    final baseTextTheme = GoogleFonts.plusJakartaSansTextTheme();
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppConstants.kSecondaryColor,
      primary: AppConstants.kPrimaryColor,
      secondary: AppConstants.kSecondaryColor,
      surface: AppConstants.kSurfaceColor,
    );

    return ChangeNotifierProvider<PortfolioController>(
      create: (_) => getIt<PortfolioController>(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppConstants.appTitle,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: colorScheme,
          textTheme: baseTextTheme,
          scaffoldBackgroundColor: AppConstants.kBackgroundColor,
          filledButtonTheme: FilledButtonThemeData(
            style: FilledButton.styleFrom(
              backgroundColor: AppConstants.kAccentColor,
              foregroundColor: const Color(0xFF0C2A3A),
              textStyle: const TextStyle(fontWeight: FontWeight.w700),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
              textStyle: const TextStyle(fontWeight: FontWeight.w600),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
          chipTheme: ChipThemeData(
            selectedColor: AppConstants.kSecondaryColor,
            backgroundColor: AppConstants.kSurfaceColor,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
            side: BorderSide(
              color: AppConstants.kPrimaryColor.withValues(alpha: 0.2),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(999),
            ),
          ),
          cardTheme: CardThemeData(
            color: AppConstants.kSurfaceColor,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        home: PortfolioPage(urlLauncherService: getIt<UrlLauncherService>()),
      ),
    );
  }
}
