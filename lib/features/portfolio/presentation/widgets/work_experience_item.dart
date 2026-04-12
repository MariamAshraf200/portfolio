import 'package:flutter/material.dart';
import 'package:protofolio/features/portfolio/domain/entities/work_experience.dart';

class WorkExperienceItem extends StatefulWidget {
  const WorkExperienceItem({
    super.key,
    required this.experience,
    required this.index,
    required this.showTimelineConnector,
  });

  final WorkExperience experience;
  final int index;
  final bool showTimelineConnector;

  @override
  State<WorkExperienceItem> createState() => _WorkExperienceItemState();
}

class _WorkExperienceItemState extends State<WorkExperienceItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final responsibilities = widget.experience.keyResponsibilities;
    final animationDuration = Duration(milliseconds: 320 + (widget.index * 90));

    return TweenAnimationBuilder<double>(
      duration: animationDuration,
      curve: Curves.easeOutCubic,
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, value, child) {
        final dx = (1 - value) * 20;
        final opacity = value.clamp(0.0, 1.0);
        return Opacity(
          opacity: opacity,
          child: Transform.translate(offset: Offset(dx, 0), child: child),
        );
      },
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _TimelineNode(showConnector: widget.showTimelineConnector),
            const SizedBox(width: 14),
            Expanded(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                curve: Curves.easeOut,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: _isHovered
                        ? const Color(0xFF1F7A8C)
                        : const Color(0x220E3A53),
                  ),
                  boxShadow: _isHovered
                      ? const [
                          BoxShadow(
                            color: Color(0x1A0E3A53),
                            blurRadius: 18,
                            offset: Offset(0, 10),
                          ),
                        ]
                      : const [],
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final compact = constraints.maxWidth < 620;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (compact)
                          _HeaderCompact(experience: widget.experience)
                        else
                          _HeaderWide(experience: widget.experience),
                        const SizedBox(height: 12),
                        ...responsibilities.map(
                          (responsibility) => Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(top: 4),
                                  child: Icon(
                                    Icons.arrow_right_rounded,
                                    size: 20,
                                    color: Color(0xFF1F7A8C),
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    responsibility,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          color: const Color(0xFF2B5063),
                                          height: 1.55,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TimelineNode extends StatelessWidget {
  const _TimelineNode({required this.showConnector});

  final bool showConnector;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 20,
      child: Column(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: const BoxDecoration(
              color: Color(0xFF1F7A8C),
              shape: BoxShape.circle,
            ),
          ),
          if (showConnector)
            Container(
              width: 2,
              height: 110,
              margin: const EdgeInsets.only(top: 4),
              color: const Color(0xFFD5E7EE),
            ),
        ],
      ),
    );
  }
}

class _HeaderCompact extends StatelessWidget {
  const _HeaderCompact({required this.experience});

  final WorkExperience experience;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          experience.jobTitle,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 6),
        Text(
          experience.companyName,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: const Color(0xFF2F5A6E),
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        _DurationChip(duration: experience.duration),
      ],
    );
  }
}

class _HeaderWide extends StatelessWidget {
  const _HeaderWide({required this.experience});

  final WorkExperience experience;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                experience.jobTitle,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 6),
              Text(
                experience.companyName,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: const Color(0xFF2F5A6E),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        _DurationChip(duration: experience.duration),
      ],
    );
  }
}

class _DurationChip extends StatelessWidget {
  const _DurationChip({required this.duration});

  final String duration;

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: const Color(0xFFE6F3F7),
      side: const BorderSide(color: Color(0x332A6E84)),
      avatar: const Icon(
        Icons.schedule_rounded,
        size: 16,
        color: Color(0xFF1F7A8C),
      ),
      label: Text(
        duration,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
          color: const Color(0xFF0E5463),
          fontWeight: FontWeight.w700,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
    );
  }
}
