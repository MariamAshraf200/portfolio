class WorkExperience {
  const WorkExperience({
    required this.jobTitle,
    required this.companyName,
    this.companyUrl,
    this.apkDownloadUrl,
    this.showApkDownloadButton = false,
    required this.duration,
    required this.keyResponsibilities,
  });

  final String jobTitle;
  final String companyName;
  final String? companyUrl;
  final String? apkDownloadUrl;
  final bool showApkDownloadButton;
  final String duration;
  final List<String> keyResponsibilities;
}
