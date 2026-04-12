import 'package:flutter/material.dart';
import 'package:protofolio/core/constants/app_constants.dart';
import 'package:protofolio/features/portfolio/domain/entities/personal_profile.dart';

class HeroHeader extends StatelessWidget {
  const HeroHeader({
    super.key,
    required this.profile,
    required this.onPrimaryAction,
    required this.onSecondaryAction,
  });

  final PersonalProfile profile;
  final VoidCallback onPrimaryAction;
  final VoidCallback onSecondaryAction;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(26),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0E3A53), Color(0xFF1F7A8C)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: const [
          BoxShadow(
            color: Color(0x2F0E3A53),
            blurRadius: 24,
            offset: Offset(0, 12),
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final compact = constraints.maxWidth < 760;
          return Flex(
            direction: compact ? Axis.vertical : Axis.horizontal,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: compact ? 0 : 3,
                child: _IdentityBlock(textTheme: textTheme, profile: profile),
              ),
              SizedBox(width: compact ? 0 : 20, height: compact ? 20 : 0),
              _ActionBlock(
                compact: compact,
                onPrimaryAction: onPrimaryAction,
                onSecondaryAction: onSecondaryAction,
              ),
            ],
          );
        },
      ),
    );
  }
}

class _IdentityBlock extends StatelessWidget {
  const _IdentityBlock({required this.textTheme, required this.profile});

  final TextTheme textTheme;
  final PersonalProfile profile;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.16),
            borderRadius: BorderRadius.circular(999),
          ),
          child: const Text(
            'Flutter Engineer',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          profile.fullName,
          style: textTheme.displaySmall?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            height: 1.05,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          profile.address,
          style: textTheme.titleMedium?.copyWith(
            color: const Color(0xFFE4F8FB),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          AppConstants.professionalSummary,
          style: textTheme.bodyLarge?.copyWith(
            color: const Color(0xFFD6F0F6),
            height: 1.5,
          ),
        ),
      ],
    );
  }
}

class _ActionBlock extends StatelessWidget {
  const _ActionBlock({
    required this.compact,
    required this.onPrimaryAction,
    required this.onSecondaryAction,
  });

  final bool compact;
  final VoidCallback onPrimaryAction;
  final VoidCallback onSecondaryAction;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: compact
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.end,
      children: [
        FilledButton.icon(
          onPressed: onPrimaryAction,
          icon: const Icon(Icons.mail_outline_rounded),
          label: const Text('Email Me'),
        ),
        const SizedBox(height: 12),
        OutlinedButton.icon(
          onPressed: onSecondaryAction,
          icon: const Icon(Icons.call_outlined),
          label: const Text('Call Now'),
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.white,
            side: const BorderSide(color: Color(0xCCFFFFFF)),
          ),
        ),
      ],
    );
  }
}
