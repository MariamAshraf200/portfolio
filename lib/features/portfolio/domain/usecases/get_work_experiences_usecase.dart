import 'package:protofolio/features/portfolio/domain/entities/work_experience.dart';
import 'package:protofolio/features/portfolio/domain/repositories/portfolio_repository.dart';

class GetWorkExperiencesUseCase {
  const GetWorkExperiencesUseCase(this._portfolioRepository);

  final PortfolioRepository _portfolioRepository;

  Future<List<WorkExperience>> call() {
    return _portfolioRepository.getWorkExperiences();
  }
}
