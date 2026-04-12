import 'package:protofolio/features/portfolio/data/datasources/portfolio_local_data_source.dart';
import 'package:protofolio/features/portfolio/domain/entities/contact_link.dart';
import 'package:protofolio/features/portfolio/domain/entities/personal_profile.dart';
import 'package:protofolio/features/portfolio/domain/entities/project_item.dart';
import 'package:protofolio/features/portfolio/domain/entities/work_experience.dart';
import 'package:protofolio/features/portfolio/domain/repositories/portfolio_repository.dart';

class PortfolioRepositoryImpl implements PortfolioRepository {
  const PortfolioRepositoryImpl(this._localDataSource);

  final PortfolioLocalDataSource _localDataSource;

  @override
  Future<PersonalProfile> getPersonalProfile() async {
    return _localDataSource.getPersonalProfile();
  }

  @override
  Future<List<ProjectItem>> getProjects() async {
    return _localDataSource.getProjects();
  }

  @override
  Future<List<WorkExperience>> getWorkExperiences() async {
    return _localDataSource.getWorkExperiences();
  }

  @override
  Future<List<ContactLink>> getContactLinks() async {
    return _localDataSource.getContactLinks();
  }
}
