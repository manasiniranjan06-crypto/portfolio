import 'package:flutter/material.dart';
import 'package:portfolio/theme/app_theme.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.colors;
    final width = MediaQuery.of(context).size.width;

    final bool isMobile = width < 700;
    final bool isTablet = width >= 700 && width < 1100;

    final int columns = isMobile ? 1 : (isTablet ? 2 : 3);
    const double spacing = 20;

    return Container(
      width: double.infinity,
      color: theme.scaffoldBackgroundColor,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 60,
        vertical: 60,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "MY SKILLS",
            style: TextStyle(
              color: colors.sectionLabel,
              letterSpacing: 2,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 10),
          RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                  text: "Technologies I ",
                  style: TextStyle(color: theme.textTheme.bodyLarge?.color),
                ),
                TextSpan(
                  text: "Work With",
                  style: TextStyle(color: theme.colorScheme.primary),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          LayoutBuilder(
            builder: (context, constraints) {
              final cardWidth =
                  (constraints.maxWidth - spacing * (columns - 1)) / columns;

              return Wrap(
                spacing: spacing,
                runSpacing: spacing,
                children: List.generate(skillCategories.length, (i) {
                  final cat = skillCategories[i];
                  return SizedBox(
                    width: cardWidth,
                    // FadeSlideIn staggers each card's entrance by index,
                    // so cards animate in one after another instead of
                    // all popping in simultaneously.
                    child: FadeSlideIn(
                      delay: Duration(milliseconds: 80 * i),
                      child: SkillCard(title: cat.title, skills: cat.skills),
                    ),
                  );
                }),
              );
            },
          ),
        ],
      ),
    );
  }
}

/// ---- Reusable entrance animation ----
class FadeSlideIn extends StatefulWidget {
  final Widget child;
  final Duration delay;
  const FadeSlideIn({
    super.key,
    required this.child,
    this.delay = Duration.zero,
  });

  @override
  State<FadeSlideIn> createState() => _FadeSlideInState();
}

class _FadeSlideInState extends State<FadeSlideIn>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    Future.delayed(widget.delay, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(position: _slide, child: widget.child),
    );
  }
}

/// ---- Data ----
class SkillCategory {
  final String title;
  final List<Skill> skills;
  const SkillCategory(this.title, this.skills);
}

const List<SkillCategory> skillCategories = [
  SkillCategory("Programming", [
    Skill("Java", Icons.coffee, Color(0xffE76F00)),
    Skill("Dart", Icons.code, Color(0xff00B4FF)),
    Skill("SQL", Icons.storage, Color(0xff4CAF50)),
    Skill("HTML", Icons.language, Color(0xffE44D26)),
    Skill("CSS", Icons.palette, Color(0xff2965F1)),
  ]),
  SkillCategory("Frameworks", [
    Skill("Flutter", Icons.flutter_dash, Color(0xff54C5F8)),
    Skill("JavaFX", Icons.desktop_windows, Color(0xff007396)),
    Skill("Spring Boot", Icons.eco, Color(0xff6DB33F)),
  ]),
  SkillCategory("Tools", [
    Skill("Git", Icons.merge_type, Color(0xffF05032)),
    Skill("GitHub", Icons.code, Color(0xffE0E0E0)),
    Skill("Maven", Icons.inventory, Color(0xffC71A36)),
    Skill("VS Code", Icons.code_off, Color(0xff007ACC)),
    Skill("IntelliJ", Icons.developer_mode, Color(0xffFF4081)),
    Skill("Postman", Icons.send, Color(0xffFF6C37)),
    Skill("Figma", Icons.design_services, Color(0xffF24E1E)),
  ]),
  SkillCategory("Concepts", [
    Skill("OOP", Icons.layers, Color(0xff9C27B0)),
    Skill("Collections", Icons.list_alt, Color(0xff26A69A)),
    Skill("Exception", Icons.warning, Color(0xffFFA726)),
    Skill("JDBC", Icons.cable, Color(0xff42A5F5)),
    Skill("Threading", Icons.memory, Color(0xffEF5350)),
    Skill("DBMS", Icons.storage, Color(0xff66BB6A)),
  ]),
  SkillCategory("Database", [
    Skill("MySQL", Icons.storage, Color(0xff4479A1)),
    Skill("Firebase", Icons.local_fire_department, Color(0xffFFCA28)),
  ]),
];

class Skill {
  final String title;
  final IconData icon;
  final Color color;
  const Skill(this.title, this.icon, this.color);
}

/// ---- Card ----
class SkillCard extends StatefulWidget {
  final String title;
  final List<Skill> skills;

  const SkillCard({super.key, required this.title, required this.skills});

  @override
  State<SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<SkillCard> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.colors;

    return MouseRegion(
      onEnter: (_) => setState(() => hover = true),
      onExit: (_) => setState(() => hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: hover ? colors.cardBg.withOpacity(.95) : colors.cardBg,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: hover ? theme.colorScheme.primary : theme.dividerColor,
          ),
          boxShadow: hover
              ? [
                  BoxShadow(
                    color: theme.colorScheme.primary.withOpacity(.25),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.title,
              style: TextStyle(
                color: theme.textTheme.bodyLarge?.color,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 25),
            Wrap(
              spacing: 18,
              runSpacing: 18,
              children: widget.skills
                  .map((e) => SkillWidget(skill: e))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

/// ---- Individual skill chip ----
class SkillWidget extends StatefulWidget {
  final Skill skill;
  const SkillWidget({super.key, required this.skill});

  @override
  State<SkillWidget> createState() => _SkillWidgetState();
}

class _SkillWidgetState extends State<SkillWidget> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Tooltip(
      message: widget.skill.title,
      waitDuration: const Duration(milliseconds: 400),
      child: MouseRegion(
        onEnter: (_) => setState(() => hover = true),
        onExit: (_) => setState(() => hover = false),
        child: AnimatedScale(
          duration: const Duration(milliseconds: 200),
          scale: hover ? 1.12 : 1,
          child: SizedBox(
            width: 75,
            child: Column(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height: 55,
                  width: 55,
                  decoration: BoxDecoration(
                    color: theme.scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: hover ? widget.skill.color : theme.dividerColor,
                      width: 2,
                    ),
                  ),
                  child: Icon(
                    widget.skill.icon,
                    color: widget.skill.color,
                    size: 28,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  widget.skill.title,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: theme.textTheme.bodyMedium?.color,
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
