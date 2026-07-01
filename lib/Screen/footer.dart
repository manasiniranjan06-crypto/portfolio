import 'package:flutter/material.dart';

class PortfolioFooter extends StatelessWidget {
  const PortfolioFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 700;

    const navItems = ["Home", "About", "Skills", "Projects", "Education", "Resume", "Contact"];

    return Container(
      width: double.infinity,
      color: theme.appBarTheme.backgroundColor,
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 60, vertical: 28),
      child: Column(
        children: [
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            runSpacing: 20,
            children: [
              RichText(
                text: TextSpan(
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(text: "Manasi ", style: TextStyle(color: theme.textTheme.bodyLarge?.color)),
                    TextSpan(text: "Niranjan", style: TextStyle(color: theme.colorScheme.primary)),
                  ],
                ),
              ),
              Wrap(
                spacing: 18,
                children: navItems
                    .map((i) => Text(i, style: TextStyle(color: theme.textTheme.bodyMedium?.color, fontSize: 13)))
                    .toList(),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  _FooterIcon(Icons.code),
                  SizedBox(width: 10),
                  _FooterIcon(Icons.work_outline),
                  SizedBox(width: 10),
                  _FooterIcon(Icons.email_outlined),
                  SizedBox(width: 10),
                  _FooterIcon(Icons.language),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Divider(color: theme.dividerColor, height: 1),
          const SizedBox(height: 16),
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            runSpacing: 8,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Made with Flutter ", style: TextStyle(color: theme.textTheme.bodyMedium?.color, fontSize: 12.5)),
                  const Icon(Icons.favorite, color: Color(0xFFEF5350), size: 13),
                ],
              ),
              Text(
                "© 2026 Manasi Niranjan. All rights reserved.",
                style: TextStyle(color: theme.textTheme.bodyMedium?.color, fontSize: 12.5),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FooterIcon extends StatefulWidget {
  final IconData icon;
  const _FooterIcon(this.icon);

  @override
  State<_FooterIcon> createState() => _FooterIconState();
}

class _FooterIconState extends State<_FooterIcon> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MouseRegion(
      onEnter: (_) => setState(() => hover = true),
      onExit: (_) => setState(() => hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: hover ? theme.dividerColor : Colors.transparent,
          borderRadius: BorderRadius.circular(7),
          border: Border.all(color: theme.dividerColor),
        ),
        child: Icon(
          widget.icon,
          size: 14,
          color: hover ? theme.colorScheme.primary : theme.textTheme.bodyMedium?.color,
        ),
      ),
    );
  }
}