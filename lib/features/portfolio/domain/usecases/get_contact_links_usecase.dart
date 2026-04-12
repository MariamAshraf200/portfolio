import 'package:protofolio/features/portfolio/domain/entities/contact_link.dart';
import 'package:protofolio/features/portfolio/domain/repositories/portfolio_repository.dart';

class GetContactLinksUseCase {
  const GetContactLinksUseCase(this._portfolioRepository);

  final PortfolioRepository _portfolioRepository;

  Future<List<ContactLink>> call() {
    return _portfolioRepository.getContactLinks();
  }
}
