import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:protofolio/core/constants/app_constants.dart';
import 'package:protofolio/core/utils/url_launcher_service.dart';
import 'package:protofolio/features/portfolio/data/datasources/portfolio_local_data_source.dart';
import 'package:protofolio/features/portfolio/data/repositories/portfolio_repository_impl.dart';
import 'package:protofolio/features/portfolio/domain/usecases/get_contact_links_usecase.dart';
import 'package:protofolio/features/portfolio/domain/usecases/get_personal_profile_usecase.dart';
import 'package:protofolio/features/portfolio/domain/usecases/get_projects_usecase.dart';
import 'package:protofolio/features/portfolio/domain/usecases/get_work_experiences_usecase.dart';
import 'package:protofolio/features/portfolio/presentation/pages/portfolio_page.dart';
import 'package:protofolio/features/portfolio/presentation/state/portfolio_controller.dart';

void main() {
  final localDataSource = const PortfolioLocalDataSource();
  final portfolioRepository = PortfolioRepositoryImpl(localDataSource);
  final getPersonalProfileUseCase = GetPersonalProfileUseCase(
    portfolioRepository,
  );
  final getProjectsUseCase = GetProjectsUseCase(portfolioRepository);
  final getWorkExperiencesUseCase = GetWorkExperiencesUseCase(
    portfolioRepository,
  );
  final getContactLinksUseCase = GetContactLinksUseCase(portfolioRepository);
  final portfolioController = PortfolioController(
    getPersonalProfileUseCase: getPersonalProfileUseCase,
    getProjectsUseCase: getProjectsUseCase,
    getWorkExperiencesUseCase: getWorkExperiencesUseCase,
    getContactLinksUseCase: getContactLinksUseCase,
  );

  runApp(
    ProtofolioApp(
      portfolioController: portfolioController,
      urlLauncherService: const UrlLauncherService(),
    ),
  );
}

class ProtofolioApp extends StatelessWidget {
  const ProtofolioApp({
    super.key,
    required this.portfolioController,
    required this.urlLauncherService,
  });

  final PortfolioController portfolioController;
  final UrlLauncherService urlLauncherService;

  @override
  Widget build(BuildContext context) {
    final baseTextTheme = GoogleFonts.plusJakartaSansTextTheme();
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppConstants.kSecondaryColor,
      primary: AppConstants.kPrimaryColor,
      secondary: AppConstants.kSecondaryColor,
      surface: AppConstants.kSurfaceColor,
    );

    return ChangeNotifierProvider<PortfolioController>.value(
      value: portfolioController,
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
        home: PortfolioPage(urlLauncherService: urlLauncherService),
      ),
    );
  }
}
