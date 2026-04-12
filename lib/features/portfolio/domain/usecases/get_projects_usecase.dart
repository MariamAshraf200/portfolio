import 'package:protofolio/features/portfolio/domain/entities/project_item.dart';
import 'package:protofolio/features/portfolio/domain/repositories/portfolio_repository.dart';

class GetProjectsUseCase {
  const GetProjectsUseCase(this._portfolioRepository);

  final PortfolioRepository _portfolioRepository;

  Future<List<ProjectItem>> call() {
    return _portfolioRepository.getProjects();
  }
}
