class WorkExperience {
  const WorkExperience({
    required this.jobTitle,
    required this.companyName,
    required this.duration,
    required this.keyResponsibilities,
  });

  final String jobTitle;
  final String companyName;
  final String duration;
  final List<String> keyResponsibilities;
}
