import 'package:get_it/get_it.dart';
import 'package:protofolio/core/utils/url_launcher_service.dart';
import 'package:protofolio/features/portfolio/data/datasources/portfolio_local_data_source.dart';
import 'package:protofolio/features/portfolio/data/repositories/portfolio_repository_impl.dart';
import 'package:protofolio/features/portfolio/domain/repositories/portfolio_repository.dart';
import 'package:protofolio/features/portfolio/domain/usecases/get_contact_links_usecase.dart';
import 'package:protofolio/features/portfolio/domain/usecases/get_personal_profile_usecase.dart';
import 'package:protofolio/features/portfolio/domain/usecases/get_projects_usecase.dart';
import 'package:protofolio/features/portfolio/domain/usecases/get_work_experiences_usecase.dart';
import 'package:protofolio/features/portfolio/presentation/state/portfolio_controller.dart';

final GetIt getIt = GetIt.instance;

void setupDependencies() {
  if (!getIt.isRegistered<PortfolioLocalDataSource>()) {
    getIt.registerLazySingleton<PortfolioLocalDataSource>(
      () => const PortfolioLocalDataSource(),
    );
  }

  if (!getIt.isRegistered<PortfolioRepository>()) {
    getIt.registerLazySingleton<PortfolioRepository>(
      () => PortfolioRepositoryImpl(getIt<PortfolioLocalDataSource>()),
    );
  }

  if (!getIt.isRegistered<GetPersonalProfileUseCase>()) {
    getIt.registerLazySingleton<GetPersonalProfileUseCase>(
      () => GetPersonalProfileUseCase(getIt<PortfolioRepository>()),
    );
  }

  if (!getIt.isRegistered<GetProjectsUseCase>()) {
    getIt.registerLazySingleton<GetProjectsUseCase>(
      () => GetProjectsUseCase(getIt<PortfolioRepository>()),
    );
  }

  if (!getIt.isRegistered<GetWorkExperiencesUseCase>()) {
    getIt.registerLazySingleton<GetWorkExperiencesUseCase>(
      () => GetWorkExperiencesUseCase(getIt<PortfolioRepository>()),
    );
  }

  if (!getIt.isRegistered<GetContactLinksUseCase>()) {
    getIt.registerLazySingleton<GetContactLinksUseCase>(
      () => GetContactLinksUseCase(getIt<PortfolioRepository>()),
    );
  }

  if (!getIt.isRegistered<UrlLauncherService>()) {
    getIt.registerLazySingleton<UrlLauncherService>(
      () => const UrlLauncherService(),
    );
  }

  if (!getIt.isRegistered<PortfolioController>()) {
    getIt.registerFactory<PortfolioController>(
      () => PortfolioController(
        getPersonalProfileUseCase: getIt<GetPersonalProfileUseCase>(),
        getProjectsUseCase: getIt<GetProjectsUseCase>(),
        getWorkExperiencesUseCase: getIt<GetWorkExperiencesUseCase>(),
        getContactLinksUseCase: getIt<GetContactLinksUseCase>(),
      ),
    );
  }
}
