
import 'package:flutter/material.dart';

class PortfolioNavBar extends StatelessWidget {
  final String activeSection;
  final ValueChanged<String> onNavTap;
  final VoidCallback onThemeToggle;

  const PortfolioNavBar({
    super.key,
    required this.activeSection,
    required this.onNavTap,
    required this.onThemeToggle,
  });

  static const List<String> sections = [
    "Home",
    "About",
    "Skills",
    "Projects",
    "Education",
    "Contact",
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.of(context).size.width;

    final bool isMobile = width < 800;
    final bool isTablet = width >= 800 && width < 1100;

    return Material(
      elevation: 3,
      color: theme.appBarTheme.backgroundColor ??
          theme.scaffoldBackgroundColor,
      child: SafeArea(
        bottom: false,
        child: Container(
          height: 70,
          padding: EdgeInsets.symmetric(
            horizontal: isMobile
                ? 16
                : isTablet
                    ? 28
                    : 50,
          ),
          child: Row(
            children: [
              Expanded(
                child: RichText(
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                    children: [
                      TextSpan(
                        text: "Manasi ",
                        style: TextStyle(
                          color: theme.textTheme.bodyLarge?.color,
                        ),
                      ),
                      TextSpan(
                        text: "Niranjan",
                        style: TextStyle(
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              if (!isMobile)
                ...sections.map(
                  (item) => _NavItem(
                    label: item,
                    active: activeSection == item,
                    onTap: () => onNavTap(item),
                  ),
                ),

              const SizedBox(width: 10),

              _ThemeToggle(
                onTap: onThemeToggle,
              ),

              if (isMobile)
                PopupMenuButton<String>(
                  icon: Icon(
                    Icons.menu_rounded,
                    color: theme.iconTheme.color,
                  ),
                  color: theme.cardColor,
                  onSelected: onNavTap,
                  itemBuilder: (_) => sections
                      .map(
                        (e) => PopupMenuItem<String>(
                          value: e,
                          child: Text(
                            e,
                            style: TextStyle(
                              color: activeSection == e
                                  ? theme.colorScheme.primary
                                  : theme.textTheme.bodyMedium?.color,
                              fontWeight: activeSection == e
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatefulWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;

  const _NavItem({
    required this.label,
    required this.active,
    required this.onTap,
  });

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final bool highlight = hover || widget.active;

    return MouseRegion(
      onEnter: (_) => setState(() => hover = true),
      onExit: (_) => setState(() => hover = false),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 10,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: highlight
                      ? FontWeight.w600
                      : FontWeight.normal,
                  color: highlight
                      ? theme.colorScheme.primary
                      : theme.textTheme.bodyMedium?.color,
                ),
                child: Text(widget.label),
              ),
              const SizedBox(height: 5),
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOut,
                height: 2,
                width: widget.active ? 22 : 0,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ThemeToggle extends StatefulWidget {
  final VoidCallback onTap;

  const _ThemeToggle({
    required this.onTap,
  });

  @override
  State<_ThemeToggle> createState() => _ThemeToggleState();
}

class _ThemeToggleState extends State<_ThemeToggle> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final bool dark =
        theme.brightness == Brightness.dark;

    return MouseRegion(
      onEnter: (_) => setState(() => hover = true),
      onExit: (_) => setState(() => hover = false),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: hover
                ? theme.colorScheme.primary.withOpacity(.12)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                return RotationTransition(
                  turns: animation,
                  child: FadeTransition(
                    opacity: animation,
                    child: child,
                  ),
                );
              },
              child: Icon(
                dark
                    ? Icons.dark_mode_rounded
                    : Icons.light_mode_rounded,
                key: ValueKey(dark),
                size: 21,
                color: theme.iconTheme.color,
              ),
            ),
          ),
        ),
      ),
    );
  }
}