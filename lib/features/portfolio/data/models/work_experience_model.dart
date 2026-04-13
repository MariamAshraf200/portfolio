import 'package:protofolio/features/portfolio/domain/entities/work_experience.dart';

class WorkExperienceModel extends WorkExperience {
  const WorkExperienceModel({
    required super.jobTitle,
    required super.companyName,
    super.companyUrl,
    super.apkDownloadUrl,
    super.showApkDownloadButton,
    required super.duration,
    required super.keyResponsibilities,
  });
}
