import 'package:protofolio/features/portfolio/domain/entities/personal_profile.dart';
import 'package:protofolio/features/portfolio/domain/repositories/portfolio_repository.dart';

class GetPersonalProfileUseCase {
  const GetPersonalProfileUseCase(this._portfolioRepository);

  final PortfolioRepository _portfolioRepository;

  Future<PersonalProfile> call() {
    return _portfolioRepository.getPersonalProfile();
  }
}
