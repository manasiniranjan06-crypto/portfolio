import 'package:flutter/material.dart';
import 'package:portfolio/model/projectData_model.dart.dart';
import 'package:portfolio/theme/app_theme.dart';

class EducationSection extends StatelessWidget {
  const EducationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 700;
    final isTablet = width >= 700 && width < 1300;

    final cards = [
      const _EducationCard(),
      const _CertificationsCard(),
      const _WhyHireMeCard(),
    ];

    return Container(
      width: double.infinity,
      color: theme.scaffoldBackgroundColor,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 60,
        vertical: 60,
      ),
      child: (isMobile)
          ? Column(
              children: List.generate(
                cards.length,
                (i) => Padding(
                  padding: EdgeInsets.only(bottom: i < cards.length - 1 ? 20 : 0),
                  child: cards[i],
                ),
              ),
            )
          : LayoutBuilder(
              builder: (context, constraints) {
                final columns = isTablet ? 2 : 3;
                const spacing = 20.0;
                final cardWidth =
                    (constraints.maxWidth - spacing * (columns - 1)) / columns;

                return Wrap(
                  spacing: spacing,
                  runSpacing: spacing,
                  children: cards
                      .map((c) => SizedBox(width: cardWidth, child: c))
                      .toList(),
                );
              },
            ),
    );
  }
}

class _EducationCard extends StatelessWidget {
  const _EducationCard();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.colors;

    return _SectionCard(
      icon: Icons.school_outlined,
      iconColor: theme.colorScheme.primary,
      label: "EDUCATION",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Bachelor of Business Administration – Computer Applications (BBA-CA)",
            style: TextStyle(
              color: theme.textTheme.bodyLarge?.color,
              fontWeight: FontWeight.bold,
              fontSize: 15,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Sinhgad College\nPune, Maharashtra",
            style: TextStyle(color: theme.textTheme.bodyMedium?.color, fontSize: 13, height: 1.6),
          ),
          const SizedBox(height: 8),
          Text(
            "Graduated: 2026",
            style: TextStyle(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 18),
          Container(
            height: 80,
            width: double.infinity,
            decoration: BoxDecoration(
              color: colors.tagBg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(Icons.account_balance, color: colors.textMuted, size: 36),
          ),
        ],
      ),
    );
  }
}

class _CertificationsCard extends StatelessWidget {
  const _CertificationsCard();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return _SectionCard(
      icon: Icons.workspace_premium_outlined,
      iconColor: const Color(0xFFFFCA28),
      label: "CERTIFICATIONS",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: certifications
            .map(
              (c) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.check_circle_outline, color: theme.colorScheme.primary, size: 16),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        c,
                        style: TextStyle(color: theme.textTheme.bodyMedium?.color, fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _WhyHireMeCard extends StatelessWidget {
  const _WhyHireMeCard();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return _SectionCard(
      icon: Icons.star_outline_rounded,
      iconColor: const Color(0xFFFFCA28),
      label: "WHY HIRE ME?",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: whyHireMe
            .map(
              (w) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.check_rounded, color: theme.colorScheme.secondary, size: 16),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        w,
                        style: TextStyle(color: theme.textTheme.bodyMedium?.color, fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

/// Shared card chrome with hover lift, used by all three cards above.
class _SectionCard extends StatefulWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final Widget child;

  const _SectionCard({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.child,
  });

  @override
  State<_SectionCard> createState() => _SectionCardState();
}

class _SectionCardState extends State<_SectionCard> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.colors;

    return MouseRegion(
      onEnter: (_) => setState(() => hover = true),
      onExit: (_) => setState(() => hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: colors.cardBg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: hover ? theme.colorScheme.primary : theme.dividerColor,
          ),
          boxShadow: hover
              ? [
                  BoxShadow(
                    color: theme.colorScheme.primary.withOpacity(0.15),
                    blurRadius: 18,
                    spreadRadius: 1,
                  )
                ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: widget.iconColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(widget.icon, color: widget.iconColor, size: 16),
                ),
                const SizedBox(width: 8),
                Text(
                  widget.label,
                  style: TextStyle(
                    color: colors.sectionLabel,
                    fontWeight: FontWeight.w700,
                    fontSize: 11,
                    letterSpacing: 1.5,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            widget.child,
          ],
        ),
      ),
    );
  }
}