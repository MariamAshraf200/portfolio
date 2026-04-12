import 'package:protofolio/features/portfolio/domain/entities/contact_link.dart';
import 'package:protofolio/features/portfolio/domain/entities/personal_profile.dart';
import 'package:protofolio/features/portfolio/domain/entities/project_item.dart';
import 'package:protofolio/features/portfolio/domain/entities/work_experience.dart';

abstract class PortfolioRepository {
  Future<PersonalProfile> getPersonalProfile();

  Future<List<ProjectItem>> getProjects();

  Future<List<WorkExperience>> getWorkExperiences();

  Future<List<ContactLink>> getContactLinks();
}
