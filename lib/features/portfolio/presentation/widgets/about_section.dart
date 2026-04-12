import 'package:flutter/material.dart';
import 'package:protofolio/core/constants/app_constants.dart';
import 'package:protofolio/features/portfolio/domain/entities/personal_profile.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key, required this.profile});

  final PersonalProfile profile;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About Me',
          style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 14),
        Text(
          profile.aboutMe,
          style: textTheme.bodyLarge?.copyWith(
            height: 1.65,
            color: const Color(0xFF2B5063),
          ),
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: const [
            _SkillChip(label: 'Clean Architecture'),
            _SkillChip(label: 'Flutter Web'),
            _SkillChip(label: 'Provider / Bloc'),
            _SkillChip(label: 'Scalable UI Systems'),
          ],
        ),
        const SizedBox(height: 24),
        LayoutBuilder(
          builder: (context, constraints) {
            final compact = constraints.maxWidth < 720;
            if (compact) {
              return const Column(
                children: [
                  _InfoCard(label: 'Name', value: AppConstants.fullName),
                  SizedBox(height: 12),
                  _InfoCard(label: 'Address', value: AppConstants.address),
                  SizedBox(height: 12),
                  _InfoCard(label: 'Phone', value: AppConstants.phoneNumber),
                  SizedBox(height: 12),
                  _InfoCard(label: 'Email', value: AppConstants.email),
                ],
              );
            }
            return const Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _InfoCard(
                        label: 'Name',
                        value: AppConstants.fullName,
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: _InfoCard(
                        label: 'Address',
                        value: AppConstants.address,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _InfoCard(
                        label: 'Phone',
                        value: AppConstants.phoneNumber,
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: _InfoCard(
                        label: 'Email',
                        value: AppConstants.email,
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F8FB),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: textTheme.labelLarge?.copyWith(
              color: const Color(0xFF3F6474),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}

class _SkillChip extends StatelessWidget {
  const _SkillChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFE7F2F7),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.check_circle_outline_rounded,
            size: 16,
            color: Color(0xFF1F7A8C),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: const Color(0xFF1B4F67),
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
