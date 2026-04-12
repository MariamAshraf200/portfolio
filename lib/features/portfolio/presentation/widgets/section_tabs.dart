import 'package:flutter/material.dart';
import 'package:protofolio/features/portfolio/presentation/state/portfolio_section.dart';

class SectionTabs extends StatelessWidget {
  const SectionTabs({
    super.key,
    required this.selectedSection,
    required this.onChanged,
  });

  final PortfolioSection selectedSection;
  final ValueChanged<PortfolioSection> onChanged;

  @override
  Widget build(BuildContext context) {
    final chips = PortfolioSection.values
        .map(
          (section) => ChoiceChip(
            showCheckmark: false,
            selected: section == selectedSection,
            avatar: Icon(
              _icon(section),
              size: 18,
              color: section == selectedSection
                  ? Colors.white
                  : const Color(0xFF255067),
            ),
            label: Text(_title(section)),
            labelStyle: TextStyle(
              color: section == selectedSection
                  ? Colors.white
                  : const Color(0xFF255067),
              fontWeight: FontWeight.w700,
            ),
            selectedColor: const Color(0xFF1F7A8C),
            backgroundColor: Colors.white,
            onSelected: (_) => onChanged(section),
          ),
        )
        .toList(growable: false);

    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 520;
        if (compact) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: chips
                .map(
                  (chip) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: chip,
                  ),
                )
                .toList(growable: false),
          );
        }
        return Wrap(spacing: 12, runSpacing: 12, children: chips);
      },
    );
  }

  IconData _icon(PortfolioSection section) {
    switch (section) {
      case PortfolioSection.home:
        return Icons.home_rounded;
      case PortfolioSection.about:
        return Icons.person_rounded;
      case PortfolioSection.workExperience:
        return Icons.work_history_rounded;
      case PortfolioSection.contact:
        return Icons.contact_phone_rounded;
    }
  }

  String _title(PortfolioSection section) {
    switch (section) {
      case PortfolioSection.home:
        return 'Home';
      case PortfolioSection.about:
        return 'About Me';
      case PortfolioSection.workExperience:
        return 'Experience';
      case PortfolioSection.contact:
        return 'Contact';
    }
  }
}
