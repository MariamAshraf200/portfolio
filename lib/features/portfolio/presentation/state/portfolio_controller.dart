import 'package:flutter/foundation.dart';
import 'package:protofolio/features/portfolio/domain/usecases/get_contact_links_usecase.dart';
import 'package:protofolio/features/portfolio/domain/usecases/get_personal_profile_usecase.dart';
import 'package:protofolio/features/portfolio/domain/usecases/get_projects_usecase.dart';
import 'package:protofolio/features/portfolio/domain/usecases/get_work_experiences_usecase.dart';
import 'package:protofolio/features/portfolio/presentation/state/portfolio_section.dart';
import 'package:protofolio/features/portfolio/presentation/state/portfolio_state.dart';

class PortfolioController extends ChangeNotifier {
  PortfolioController({
    required GetPersonalProfileUseCase getPersonalProfileUseCase,
    required GetProjectsUseCase getProjectsUseCase,
    required GetWorkExperiencesUseCase getWorkExperiencesUseCase,
    required GetContactLinksUseCase getContactLinksUseCase,
  }) : _getPersonalProfileUseCase = getPersonalProfileUseCase,
       _getProjectsUseCase = getProjectsUseCase,
       _getWorkExperiencesUseCase = getWorkExperiencesUseCase,
       _getContactLinksUseCase = getContactLinksUseCase;

  final GetPersonalProfileUseCase _getPersonalProfileUseCase;
  final GetProjectsUseCase _getProjectsUseCase;
  final GetWorkExperiencesUseCase _getWorkExperiencesUseCase;
  final GetContactLinksUseCase _getContactLinksUseCase;

  PortfolioState _state = PortfolioState.initial();

  PortfolioState get state => _state;

  Future<void> load() async {
    final profile = await _getPersonalProfileUseCase();
    final projects = await _getProjectsUseCase();
    final workExperiences = await _getWorkExperiencesUseCase();
    final contactLinks = await _getContactLinksUseCase();
    _state = _state.copyWith(
      isLoading: false,
      profile: profile,
      projects: projects,
      workExperiences: workExperiences,
      contactLinks: contactLinks,
    );
    notifyListeners();
  }

  void selectSection(PortfolioSection section) {
    _state = _state.copyWith(selectedSection: section);
    notifyListeners();
  }
}
