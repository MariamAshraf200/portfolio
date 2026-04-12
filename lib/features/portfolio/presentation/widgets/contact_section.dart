import 'package:flutter/material.dart';
import 'package:protofolio/features/portfolio/domain/entities/contact_link.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({
    super.key,
    required this.contactLinks,
    required this.onTap,
  });

  final List<ContactLink> contactLinks;
  final ValueChanged<ContactLink> onTap;

  IconData _iconFor(String label) {
    switch (label.toLowerCase()) {
      case 'call':
        return Icons.call;
      case 'whatsapp':
        return Icons.chat;
      case 'email':
        return Icons.email;
      case 'github':
        return Icons.code;
      case 'linkedin':
        return Icons.business;
      default:
        return Icons.open_in_new;
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Contact',
          style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 10),
        Text(
          'Available for collaborations, freelance projects, and full-time opportunities.',
          style: textTheme.bodyLarge?.copyWith(
            color: const Color(0xFF2D5266),
            height: 1.6,
          ),
        ),
        const SizedBox(height: 20),
        LayoutBuilder(
          builder: (context, constraints) {
            final isCompact = constraints.maxWidth < 740;
            if (isCompact) {
              return Column(
                children: contactLinks
                    .map(
                      (link) => _ContactCard(
                        link: link,
                        onTap: onTap,
                        icon: _iconFor(link.label),
                      ),
                    )
                    .toList(growable: false),
              );
            }
            return Wrap(
              spacing: 14,
              runSpacing: 14,
              children: contactLinks
                  .map(
                    (link) => SizedBox(
                      width: (constraints.maxWidth - 14) / 2,
                      child: _ContactCard(
                        link: link,
                        onTap: onTap,
                        icon: _iconFor(link.label),
                      ),
                    ),
                  )
                  .toList(growable: false),
            );
          },
        ),
      ],
    );
  }
}

class _ContactCard extends StatelessWidget {
  const _ContactCard({
    required this.link,
    required this.onTap,
    required this.icon,
  });

  final ContactLink link;
  final ValueChanged<ContactLink> onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => onTap(link),
        child: Ink(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0x220E3A53)),
          ),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: const Color(0xFFE9F4F8),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: const Color(0xFF1F7A8C)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      link.label,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _labelSubtitle(link.label),
                      style: textTheme.bodyMedium?.copyWith(
                        color: const Color(0xFF44677A),
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.open_in_new_rounded, color: Color(0xFF2E5A70)),
            ],
          ),
        ),
      ),
    );
  }

  String _labelSubtitle(String label) {
    switch (label.toLowerCase()) {
      case 'call':
        return 'Direct phone contact';
      case 'whatsapp':
        return 'Fast chat on WhatsApp';
      case 'email':
        return 'Professional email communication';
      case 'github':
        return 'Code repositories and contributions';
      case 'linkedin':
        return 'Professional profile and network';
      default:
        return 'Open contact channel';
    }
  }
}
