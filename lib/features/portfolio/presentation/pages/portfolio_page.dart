import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:protofolio/core/constants/app_constants.dart';
import 'package:protofolio/core/utils/url_launcher_service.dart';
import 'package:protofolio/features/portfolio/domain/entities/contact_link.dart';
import 'package:protofolio/features/portfolio/domain/entities/personal_profile.dart';
import 'package:protofolio/features/portfolio/presentation/state/portfolio_controller.dart';
import 'package:protofolio/features/portfolio/presentation/state/portfolio_section.dart';
import 'package:protofolio/features/portfolio/presentation/widgets/about_section.dart';
import 'package:protofolio/features/portfolio/presentation/widgets/contact_section.dart';
import 'package:protofolio/features/portfolio/presentation/widgets/hero_header.dart';
import 'package:protofolio/features/portfolio/presentation/widgets/portfolio_shell.dart';
import 'package:protofolio/features/portfolio/presentation/widgets/section_tabs.dart';
import 'package:protofolio/features/portfolio/presentation/widgets/work_experience_section.dart';

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({
    super.key,
    required UrlLauncherService urlLauncherService,
  }) : _urlLauncherService = urlLauncherService;

  final UrlLauncherService _urlLauncherService;

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  late final ScrollController _scrollController;
  late final Map<PortfolioSection, GlobalKey> _sectionKeys;
  bool _isProgrammaticScroll = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_handleScroll);
    _sectionKeys = {
      PortfolioSection.home: GlobalKey(),
      PortfolioSection.about: GlobalKey(),
      PortfolioSection.workExperience: GlobalKey(),
      PortfolioSection.contact: GlobalKey(),
    };
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      context.read<PortfolioController>().load();
    });
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_handleScroll)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PortfolioController>(
      builder: (context, controller, _) {
        final state = controller.state;
        return Scaffold(
          backgroundColor: AppConstants.kBackgroundColor,
          floatingActionButton: state.isLoading
              ? null
              : FloatingActionButton.small(
                  onPressed: () => _scrollToSection(PortfolioSection.home),
                  backgroundColor: const Color(0xFF1F7A8C),
                  foregroundColor: Colors.white,
                  child: const Icon(Icons.arrow_upward_rounded),
                ),
          body: PortfolioShell(
            child: state.isLoading
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Portfolio',
                        style: Theme.of(context).textTheme.headlineMedium
                            ?.copyWith(
                              color: AppConstants.kPrimaryColor,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Explore profile details, project roadmap, and direct contact channels.',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: const Color(0xFF2E5568),
                        ),
                      ),
                      const SizedBox(height: 18),
                      SectionTabs(
                        selectedSection: state.selectedSection,
                        onChanged: (section) {
                          controller.selectSection(section);
                          _scrollToSection(section);
                        },
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: SingleChildScrollView(
                          controller: _scrollController,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _SectionContainer(
                                sectionKey:
                                    _sectionKeys[PortfolioSection.home]!,
                                child: _buildHomeSection(
                                  profile: state.profile,
                                ),
                              ),
                              _SectionContainer(
                                sectionKey:
                                    _sectionKeys[PortfolioSection.about]!,
                                child: _buildAboutSection(
                                  profile: state.profile,
                                ),
                              ),
                              _SectionContainer(
                                sectionKey:
                                    _sectionKeys[PortfolioSection
                                        .workExperience]!,
                                child: WorkExperienceSection(
                                  workExperiences: state.workExperiences,
                                  onOpenCompanyLink: _openRawUrl,
                                ),
                              ),
                              _SectionContainer(
                                sectionKey:
                                    _sectionKeys[PortfolioSection.contact]!,
                                child: ContactSection(
                                  contactLinks: state.contactLinks,
                                  onTap: _openLink,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }

  Widget _buildHomeSection({required PersonalProfile? profile}) {
    if (profile == null) {
      return const SizedBox.shrink();
    }
    return HeroHeader(
      profile: profile,
      onPrimaryAction: () => _openRawUrl('mailto:${AppConstants.email}'),
      onSecondaryAction: () => _openRawUrl('tel:${AppConstants.phoneNumber}'),
    );
  }

  Widget _buildAboutSection({required PersonalProfile? profile}) {
    if (profile == null) {
      return const SizedBox.shrink();
    }
    return AboutSection(profile: profile);
  }

  void _handleScroll() {
    if (!mounted || _isProgrammaticScroll) {
      return;
    }

    final controller = context.read<PortfolioController>();
    const viewportAnchor = 180.0;
    PortfolioSection? nearestSection;
    var nearestDistance = double.infinity;

    for (final section in PortfolioSection.values) {
      final key = _sectionKeys[section];
      final sectionContext = key?.currentContext;
      if (sectionContext == null) {
        continue;
      }
      final renderObject = sectionContext.findRenderObject();
      if (renderObject is! RenderBox || !renderObject.hasSize) {
        continue;
      }

      final y = renderObject.localToGlobal(Offset.zero).dy;
      final distance = (y - viewportAnchor).abs();
      if (distance < nearestDistance) {
        nearestDistance = distance;
        nearestSection = section;
      }
    }

    if (nearestSection != null &&
        nearestSection != controller.state.selectedSection) {
      controller.selectSection(nearestSection);
    }
  }

  Future<void> _scrollToSection(PortfolioSection section) async {
    final sectionContext = _sectionKeys[section]?.currentContext;
    if (sectionContext == null) {
      return;
    }

    _isProgrammaticScroll = true;
    try {
      await Scrollable.ensureVisible(
        sectionContext,
        duration: const Duration(milliseconds: 650),
        curve: Curves.easeInOutCubic,
        alignment: 0.05,
      );
    } finally {
      _isProgrammaticScroll = false;
    }
  }

  Future<void> _openLink(ContactLink link) async {
    try {
      await widget._urlLauncherService.open(link.url);
    } catch (_) {
      _showActionError();
    }
  }

  Future<void> _openRawUrl(String url) async {
    try {
      await widget._urlLauncherService.open(url);
    } catch (_) {
      _showActionError();
    }
  }

  void _showActionError() {
    if (!mounted) {
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Unable to open this action right now.')),
    );
  }
}

class _SectionContainer extends StatelessWidget {
  const _SectionContainer({required this.sectionKey, required this.child});

  final GlobalKey sectionKey;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: sectionKey,
      margin: const EdgeInsets.only(bottom: 24),
      child: TweenAnimationBuilder<double>(
        duration: const Duration(milliseconds: 420),
        curve: Curves.easeOut,
        tween: Tween<double>(begin: 0, end: 1),
        builder: (context, value, builtChild) {
          return Opacity(opacity: value, child: builtChild);
        },
        child: child,
      ),
    );
  }
}
