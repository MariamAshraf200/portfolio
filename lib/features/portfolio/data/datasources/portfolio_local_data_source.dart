import 'package:protofolio/core/constants/app_constants.dart';
import 'package:protofolio/features/portfolio/data/models/contact_link_model.dart';
import 'package:protofolio/features/portfolio/data/models/personal_profile_model.dart';
import 'package:protofolio/features/portfolio/data/models/project_item_model.dart';
import 'package:protofolio/features/portfolio/data/models/work_experience_model.dart';

class PortfolioLocalDataSource {
  const PortfolioLocalDataSource();

  PersonalProfileModel getPersonalProfile() {
    return const PersonalProfileModel(
      fullName: AppConstants.fullName,
      address: AppConstants.address,
      aboutMe:
          'I design and engineer maintainable Flutter applications that combine '
          'performance, clean architecture, and clear product thinking. I care '
          'about turning requirements into smooth, user-focused experiences.',
    );
  }

  List<ProjectItemModel> getProjects() {
    return const [
      ProjectItemModel(
        title: 'Flagship Product Case Study',
        description:
            'A production-grade Flutter case study will be published here soon.',
        isPlanned: true,
      ),
      ProjectItemModel(
        title: 'Open Source Contribution Showcase',
        description:
            'Selected repositories, architecture notes, and impact metrics are coming next.',
        isPlanned: true,
      ),
    ];
  }

  List<ContactLinkModel> getContactLinks() {
    return const [
      ContactLinkModel(label: 'Call', url: 'tel:${AppConstants.phoneNumber}'),
      ContactLinkModel(label: 'WhatsApp', url: 'https://wa.me/201212803051'),
      ContactLinkModel(label: 'Email', url: 'mailto:${AppConstants.email}'),
      ContactLinkModel(label: 'GitHub', url: AppConstants.githubUrl),
      ContactLinkModel(label: 'LinkedIn', url: AppConstants.linkedInUrl),
    ];
  }

  List<WorkExperienceModel> getWorkExperiences() {
    return const [
      WorkExperienceModel(
        jobTitle: 'Junior Flutter Developer',
        companyName: 'روح مطروح | Rouh Matrouh',
        duration: 'Mar 2025 - Present',
        keyResponsibilities: [
          'Built and maintained Flutter applications following Clean Architecture and SOLID principles.',
          'Implemented robust state management and clean coding practices to keep features scalable.',
          'Collaborated on continuous product improvements with a quality-focused development flow.',
        ],
      ),
      WorkExperienceModel(
        jobTitle: 'Flutter Developer (Internship)',
        companyName: 'Cellula Technologies',
        duration: 'Sep 2024 - Dec 2024',
        keyResponsibilities: [
          'Developed and tested mobile app features, reducing bug occurrence by 20%.',
          'Enhanced UI design quality, improving user satisfaction metrics by 15%.',
          'Streamlined app functionality, increasing performance efficiency by 30%.',
        ],
      ),
    ];
  }
}
