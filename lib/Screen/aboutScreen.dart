import 'package:flutter/material.dart';
import 'package:portfolio/theme/app_theme.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.colors;

    final width = MediaQuery.of(context).size.width;

    final bool isMobile = width < 600;
    final bool isSmallTablet = width >= 600 && width < 900;
    final bool isTablet = width >= 900 && width < 1200;

    final horizontalPadding = isMobile
        ? 20.0
        : isSmallTablet
        ? 35.0
        : isTablet
        ? 60.0
        : 100.0;

    final titleSize = isMobile
        ? 28.0
        : isSmallTablet
        ? 34.0
        : 38.0;

    final bodySize = isMobile ? 14.0 : 16.0;

    final badgeSize = isMobile
        ? 70.0
        : isSmallTablet
        ? 80.0
        : 90.0;

    Widget content = Column(
      crossAxisAlignment: isMobile
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        Text(
          "ABOUT ME",
          style: TextStyle(
            color: colors.sectionLabel,
            letterSpacing: 2,
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),

        const SizedBox(height: 12),

        RichText(
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
          text: TextSpan(
            style: TextStyle(fontSize: titleSize, fontWeight: FontWeight.bold),
            children: [
              TextSpan(
                text: "Let me introduce ",
                style: TextStyle(color: theme.textTheme.bodyLarge!.color),
              ),
              TextSpan(
                text: "myself",
                style: TextStyle(color: theme.colorScheme.primary),
              ),
            ],
          ),
        ),

        const SizedBox(height: 25),

        Text(
          "I am a passionate Java and Flutter Developer from Pune, India. I recently completed my BBA-CA and enjoy building scalable applications with clean and efficient code.",
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
          style: TextStyle(
            fontSize: bodySize,
            height: 1.8,
            color: theme.textTheme.bodyMedium!.color,
          ),
        ),

        const SizedBox(height: 15),

        Text(
          "My interests include Java Backend Development, Flutter Cross-Platform Development, Firebase, and AI integration.",
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
          style: TextStyle(
            fontSize: bodySize,
            height: 1.8,
            color: theme.textTheme.bodyMedium!.color,
          ),
        ),

        const SizedBox(height: 15),

        Text(
          "I continuously improve my programming skills by building real-world projects and learning modern technologies like Spring Boot, REST APIs, Git and AI-powered applications.",
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
          style: TextStyle(
            fontSize: bodySize,
            height: 1.8,
            color: theme.textTheme.bodyMedium!.color,
          ),
        ),
      ],
    );

    Widget badgeSection = SizedBox(
      width: isMobile ? double.infinity : 350,
      height: isMobile ? 280 : 320,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: badgeSize * 2,
            height: badgeSize * 2,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: theme.colorScheme.primary.withOpacity(.08),
            ),
            child: Icon(Icons.person, size: badgeSize, color: colors.textMuted),
          ),

          Positioned(
            top: 0,
            child: _TechBadge(
              icon: Icons.coffee,
              label: "Java",
              color: Colors.orange,
            ),
          ),

          Positioned(
            right: 10,
            top: 50,
            child: _TechBadge(
              icon: Icons.flutter_dash,
              label: "Flutter",
              color: Colors.blue,
            ),
          ),


          Positioned(
            bottom: 30,
            right: 20,
            child: _TechBadge(
              icon: Icons.local_fire_department,
              label: "Firebase",
              color: Colors.amber,
            ),
          ),

         

          Positioned(
            bottom: 20,
            left: 10,
            child: _TechBadge(
              icon: Icons.code,
              label: "</>",
              color: theme.colorScheme.primary,
            ),
          ),
        ],
      ),
    );

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: 70,
      ),
      color: theme.scaffoldBackgroundColor,
      child: isMobile || isSmallTablet
          ? Column(
              children: [badgeSection, const SizedBox(height: 40), content],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(flex: 6, child: content),

                const SizedBox(width: 60),

                Expanded(flex: 4, child: badgeSection),
              ],
            ),
    );
  }
}

class _TechBadge extends StatefulWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _TechBadge({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  State<_TechBadge> createState() => _TechBadgeState();
}

class _TechBadgeState extends State<_TechBadge> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.colors;

    return MouseRegion(
      onEnter: (_) => setState(() => hover = true),
      onExit: (_) => setState(() => hover = false),
      child: AnimatedScale(
        scale: hover ? 1.1 : 1,
        duration: const Duration(milliseconds: 200),
        child: Container(
          width: 75,
          height: 75,
          decoration: BoxDecoration(
            color: colors.cardBg,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: hover ? widget.color : theme.dividerColor,
            ),
            boxShadow: hover
                ? [
                    BoxShadow(
                      color: widget.color.withOpacity(.3),
                      blurRadius: 15,
                    ),
                  ]
                : [],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(widget.icon, color: widget.color),
              const SizedBox(height: 5),
              Text(
                widget.label,
                style: TextStyle(
                  fontSize: 10,
                  color: theme.textTheme.bodyMedium!.color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
