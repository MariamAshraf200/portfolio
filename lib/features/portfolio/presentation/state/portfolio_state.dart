import 'package:protofolio/features/portfolio/domain/entities/contact_link.dart';
import 'package:protofolio/features/portfolio/domain/entities/personal_profile.dart';
import 'package:protofolio/features/portfolio/domain/entities/project_item.dart';
import 'package:protofolio/features/portfolio/domain/entities/work_experience.dart';
import 'package:protofolio/features/portfolio/presentation/state/portfolio_section.dart';

class PortfolioState {
  const PortfolioState({
    required this.isLoading,
    required this.selectedSection,
    required this.profile,
    required this.projects,
    required this.workExperiences,
    required this.contactLinks,
  });

  factory PortfolioState.initial() {
    return const PortfolioState(
      isLoading: true,
      selectedSection: PortfolioSection.home,
      profile: null,
      projects: [],
      workExperiences: [],
      contactLinks: [],
    );
  }

  final bool isLoading;
  final PortfolioSection selectedSection;
  final PersonalProfile? profile;
  final List<ProjectItem> projects;
  final List<WorkExperience> workExperiences;
  final List<ContactLink> contactLinks;

  PortfolioState copyWith({
    bool? isLoading,
    PortfolioSection? selectedSection,
    PersonalProfile? profile,
    List<ProjectItem>? projects,
    List<WorkExperience>? workExperiences,
    List<ContactLink>? contactLinks,
  }) {
    return PortfolioState(
      isLoading: isLoading ?? this.isLoading,
      selectedSection: selectedSection ?? this.selectedSection,
      profile: profile ?? this.profile,
      projects: projects ?? this.projects,
      workExperiences: workExperiences ?? this.workExperiences,
      contactLinks: contactLinks ?? this.contactLinks,
    );
  }
}
