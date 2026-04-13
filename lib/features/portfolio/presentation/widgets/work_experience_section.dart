import 'package:flutter/material.dart';
import 'package:protofolio/features/portfolio/domain/entities/work_experience.dart';
import 'package:protofolio/features/portfolio/presentation/widgets/work_experience_item.dart';

class WorkExperienceSection extends StatelessWidget {
  const WorkExperienceSection({
    super.key,
    required this.workExperiences,
    required this.onOpenCompanyLink,
  });

  final List<WorkExperience> workExperiences;
  final ValueChanged<String> onOpenCompanyLink;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Work Experience',
          style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 10),
        Text(
          'A timeline of professional roles focused on Flutter engineering, product quality, and scalable architecture.',
          style: textTheme.bodyLarge?.copyWith(
            color: const Color(0xFF2D5266),
            height: 1.6,
          ),
        ),
        const SizedBox(height: 20),
        LayoutBuilder(
          builder: (context, constraints) {
            final isDesktop = constraints.maxWidth >= 980;
            if (!isDesktop) {
              return _ExperienceTimeline(
                workExperiences: workExperiences,
                onOpenCompanyLink: onOpenCompanyLink,
              );
            }
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: _SummaryCard(totalRoles: workExperiences.length),
                ),
                const SizedBox(width: 18),
                Expanded(
                  flex: 7,
                  child: _ExperienceTimeline(
                    workExperiences: workExperiences,
                    onOpenCompanyLink: onOpenCompanyLink,
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({required this.totalRoles});

  final int totalRoles;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F8FB),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0x1F1F7A8C)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.work_history_rounded, color: Color(0xFF1F7A8C)),
          const SizedBox(height: 10),
          Text(
            '$totalRoles professional roles',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 8),
          Text(
            'Experience includes full-cycle feature development, UI improvement, and performance-focused delivery.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: const Color(0xFF3A6374),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _ExperienceTimeline extends StatelessWidget {
  const _ExperienceTimeline({
    required this.workExperiences,
    required this.onOpenCompanyLink,
  });

  final List<WorkExperience> workExperiences;
  final ValueChanged<String> onOpenCompanyLink;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: workExperiences
          .asMap()
          .entries
          .map((entry) {
            final index = entry.key;
            final experience = entry.value;
            final isLast = index == workExperiences.length - 1;
            return Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 14),
              child: WorkExperienceItem(
                experience: experience,
                index: index,
                showTimelineConnector: !isLast,
                onOpenCompanyLink: onOpenCompanyLink,
              ),
            );
          })
          .toList(growable: false),
    );
  }
}
