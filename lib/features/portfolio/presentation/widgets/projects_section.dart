import 'package:flutter/material.dart';
import 'package:protofolio/features/portfolio/domain/entities/project_item.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key, required this.projects});

  final List<ProjectItem> projects;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final children = <Widget>[];
    for (final project in projects) {
      children.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: _ProjectRoadmapCard(project: project),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Projects',
          style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 10),
        Text(
          'This section is prepared as a project showcase area with room for case studies, repositories, and impact metrics.',
          style: textTheme.bodyLarge?.copyWith(
            color: const Color(0xFF2D5266),
            height: 1.6,
          ),
        ),
        const SizedBox(height: 20),
        ...children,
      ],
    );
  }
}

class _ProjectRoadmapCard extends StatelessWidget {
  const _ProjectRoadmapCard({required this.project});

  final ProjectItem project;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Color(0x220E3A53)),
      ),
      leading: Icon(
        project.isPlanned
            ? Icons.schedule_rounded
            : Icons.rocket_launch_rounded,
      ),
      title: Text(
        project.title,
        style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
      ),
      subtitle: Text(project.description),
      trailing: Chip(label: Text(project.isPlanned ? 'Planned' : 'Live')),
    );
  }
}
