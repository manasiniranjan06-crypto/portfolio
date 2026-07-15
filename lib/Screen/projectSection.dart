import 'package:flutter/material.dart';
import 'package:portfolio/model/launcher.dart';
import 'package:portfolio/model/projectData_model.dart.dart';
import 'package:portfolio/theme/app_theme.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  int currentPage = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.34);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.colors;
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 700;
    final isTablet = width >= 700 && width < 1100;

    final viewportFraction = isMobile ? 0.92 : (isTablet ? 0.48 : 0.34);

    if (_pageController.viewportFraction != viewportFraction) {
      _pageController.dispose();
      _pageController = PageController(viewportFraction: viewportFraction);
    }

    final sectionPadding = isMobile ? 20.0 : 60.0;
    final arrowsReservedWidth = isMobile ? 0.0 : 100.0;
    final containerWidth = width - (sectionPadding * 2) - arrowsReservedWidth;
    final cardWidth = containerWidth * viewportFraction;
    final carouselWidth = (cardWidth * projects.length).clamp(
      cardWidth,
      containerWidth,
    );

    return Container(
      width: double.infinity,
      color: colors.cardBg.withOpacity(0.3),
      padding: EdgeInsets.symmetric(horizontal: sectionPadding, vertical: 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "MY PROJECTS",
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
                  text: "Things I've ",
                  style: TextStyle(color: theme.textTheme.bodyLarge?.color),
                ),
                TextSpan(
                  text: "Built",
                  style: TextStyle(color: theme.colorScheme.primary),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          SizedBox(
            height: 420,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!isMobile)
                  _ArrowButton(
                    icon: Icons.chevron_left_rounded,
                    onTap: () {
                      _pageController.previousPage(
                        duration: const Duration(milliseconds: 350),
                        curve: Curves.easeOut,
                      );
                    },
                  ),
                SizedBox(
                  width: carouselWidth,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: projects.length,
                    onPageChanged: (i) => setState(() => currentPage = i),
                    itemBuilder: (context, i) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: _ProjectCard(project: projects[i]),
                      );
                    },
                  ),
                ),
                if (!isMobile)
                  _ArrowButton(
                    icon: Icons.chevron_right_rounded,
                    onTap: () {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 350),
                        curve: Curves.easeOut,
                      );
                    },
                  ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(projects.length, (i) {
              final active = i == currentPage;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: active ? 20 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: active
                      ? theme.colorScheme.primary
                      : theme.dividerColor,
                  borderRadius: BorderRadius.circular(4),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _ArrowButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _ArrowButton({required this.icon, required this.onTap});

  @override
  State<_ArrowButton> createState() => _ArrowButtonState();
}

class _ArrowButtonState extends State<_ArrowButton> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MouseRegion(
      onEnter: (_) => setState(() => hover = true),
      onExit: (_) => setState(() => hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: hover ? theme.dividerColor : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: theme.dividerColor),
          ),
          child: Icon(widget.icon, color: theme.textTheme.bodyMedium?.color),
        ),
      ),
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final ProjectDataModel project;
  const _ProjectCard({required this.project});

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
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
        transform: hover
            ? (Matrix4.identity()..translate(0.0, -6.0))
            : Matrix4.identity(),
        decoration: BoxDecoration(
          color: colors.cardBg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: hover ? theme.colorScheme.primary : theme.dividerColor,
          ),
          boxShadow: hover
              ? [
                  BoxShadow(
                    color: theme.colorScheme.primary.withOpacity(0.18),
                    blurRadius: 24,
                    spreadRadius: 2,
                  ),
                ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // project image
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: Container(
                height: 130,
                width: double.infinity,
                color: theme.scaffoldBackgroundColor,
                child: widget.project.imagePath != null
                    ? Image.asset(
                        widget.project.imagePath!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Icon(
                          Icons.window_rounded,
                          size: 44,
                          color: theme.dividerColor,
                        ),
                      )
                    : Icon(
                        Icons.window_rounded,
                        size: 44,
                        color: theme.dividerColor,
                      ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.project.titile,
                      style: TextStyle(
                        color: theme.textTheme.bodyLarge?.color,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.project.subtitle,
                      style: TextStyle(color: colors.textMuted, fontSize: 12),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: Text(
                        widget.project.description,
                        style: TextStyle(
                          color: theme.textTheme.bodyMedium?.color,
                          fontSize: 12.5,
                          height: 1.5,
                        ),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: widget.project.tags
                          .map((t) => _Tag(label: t))
                          .toList(),
                    ),
                    const SizedBox(height: 12),
                    _ViewProjectButton(
                      onTap: () {
                        final url =
                            widget.project.liveUrl ?? widget.project.githubUrl;
                        if (url != null) {
                          openUrl(url);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  final String label;
  const _Tag({required this.label});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.colors;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
      decoration: BoxDecoration(
        color: colors.tagBg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: theme.textTheme.bodyMedium?.color,
          fontSize: 10.5,
        ),
      ),
    );
  }
}

class _ViewProjectButton extends StatefulWidget {
  final VoidCallback onTap;
  const _ViewProjectButton({required this.onTap});

  @override
  State<_ViewProjectButton> createState() => _ViewProjectButtonState();
}

class _ViewProjectButtonState extends State<_ViewProjectButton> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MouseRegion(
      onEnter: (_) => setState(() => hover = true),
      onExit: (_) => setState(() => hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: hover ? theme.colorScheme.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: hover ? theme.colorScheme.primary : theme.dividerColor,
            ),
          ),
          child: Text(
            "View Project",
            style: TextStyle(
              color: hover ? Colors.white : theme.textTheme.bodyMedium?.color,
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
