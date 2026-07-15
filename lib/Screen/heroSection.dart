
import 'package:flutter/material.dart';
import 'package:portfolio/model/launcher.dart';
import 'package:portfolio/model/links.dart';


class HeroSection extends StatelessWidget {
  final ValueChanged<String> onNavTap;

  const HeroSection({super.key, required this.onNavTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    double width = MediaQuery.of(context).size.width;

    bool isMobile = width < 700;
    bool isTablet = width >= 700 && width < 1100;

    double padding = isMobile
        ? 20
        : isTablet
        ? 35
        : 60;

    double headingSize = isMobile
        ? 34
        : isTablet
        ? 42
        : 52;

    double titleSize = isMobile ? 15 : 18;

    double avatarSize = isMobile
        ? 220
        : isTablet
        ? 280
        : 340;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(padding),
      color: theme.scaffoldBackgroundColor,
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ProfileAvatar(size: avatarSize),
                const SizedBox(height: 30),
                HeroContent(
                  theme: theme,
                  headingSize: headingSize,
                  titleSize: titleSize,
                  center: true,
                  onNavTap: onNavTap,
                ),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 6,
                  child: HeroContent(
                    theme: theme,
                    headingSize: headingSize,
                    titleSize: titleSize,
                    onNavTap: onNavTap,
                  ),
                ),
                const SizedBox(width: 0),
                Expanded(
                  flex: 4,
                  child: Center(child: ProfileAvatar(size: avatarSize)),
                ),
              ],
            ),
    );
  }
}

class HeroContent extends StatelessWidget {
  final ThemeData theme;
  final double headingSize;
  final double titleSize;
  final bool center;
  final ValueChanged<String> onNavTap;

  const HeroContent({
    super.key,
    required this.theme,
    required this.headingSize,
    required this.titleSize,
    required this.onNavTap,
    this.center = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: center
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        Text(
          "Hi, I'm",
          textAlign: center ? TextAlign.center : TextAlign.left,
          style: TextStyle(
            fontSize: titleSize,
            color: theme.textTheme.bodyMedium?.color,
          ),
        ),
        const SizedBox(height: 10),
        RichText(
          textAlign: center ? TextAlign.center : TextAlign.left,
          text: TextSpan(
            style: TextStyle(
              fontSize: headingSize,
              fontWeight: FontWeight.bold,
            ),
            children: [
              TextSpan(
                text: "Manasi ",
                style: TextStyle(color: theme.textTheme.bodyLarge?.color),
              ),
              TextSpan(
                text: "Niranjan",
                style: TextStyle(color: theme.colorScheme.primary),
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        Text(
          "Java Developer • Flutter Developer • AI Enthusiast",
          textAlign: center ? TextAlign.center : TextAlign.left,
          style: TextStyle(
            fontSize: titleSize,
            color: theme.textTheme.bodyMedium?.color,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          "I build modern applications using Java, Flutter, Firebase and AI-powered solutions.",
          textAlign: center ? TextAlign.center : TextAlign.left,
          style: TextStyle(
            height: 1.7,
            color: theme.textTheme.bodyMedium?.color,
          ),
        ),
        const SizedBox(height: 30),
        Wrap(
          alignment: center ? WrapAlignment.center : WrapAlignment.start,
          spacing: 15,
          runSpacing: 15,
          children: [
            HeroButton(
              text: "Resume",
              //filled: true,
              onTap: () => onNavTap("Contact"),
            ),
            HeroButton(text: "Projects", onTap: () => onNavTap("Projects")),
            HeroButton(text: "Contact", onTap: () => onNavTap("Contact")),
          ],
        ),
        const SizedBox(height: 35),
        Text(
          "Find Me On",
          style: TextStyle(color: theme.textTheme.bodyMedium?.color),
        ),
        const SizedBox(height: 15),
        Wrap(
          alignment: center ? WrapAlignment.center : WrapAlignment.start,
          spacing: 15,
          runSpacing: 15,
          children: [
            SocialIcon(
              icon: Icons.code,
              tooltip: "GitHub",
              onTap: () => openUrl(PortfolioLinks.github),
            ),
            SocialIcon(
              icon: Icons.work,
              tooltip: "LinkedIn",
              onTap: () => openUrl(PortfolioLinks.linkedin),
            ),
            SocialIcon(
              icon: Icons.terminal_rounded,
              tooltip: "LeetCode",
              onTap: () => openUrl(PortfolioLinks.leetcode),
            ),
            SocialIcon(
              icon: Icons.email,
              tooltip: "Email",
             onTap: () => sendEmail(to: PortfolioLinks.email),
            ),
          ],
        ),
      ],
    );
  }
}

class HeroButton extends StatefulWidget {
  final String text;
  final bool filled;
  final VoidCallback onTap;

  const HeroButton({
    super.key,
    required this.text,
    required this.onTap,
    this.filled = false,
  });

  @override
  State<HeroButton> createState() => _HeroButtonState();
}

class _HeroButtonState extends State<HeroButton> {
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
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
          decoration: BoxDecoration(
            color: widget.filled
                ? theme.colorScheme.primary
                : hover
                ? theme.dividerColor
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: theme.colorScheme.primary),
          ),
          child: Text(
            widget.text,
            style: TextStyle(
              color: widget.filled
                  ? Colors.white
                  : theme.textTheme.bodyLarge?.color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

class SocialIcon extends StatefulWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;

  const SocialIcon({
    super.key,
    required this.icon,
    required this.tooltip,
    required this.onTap,
  });

  @override
  State<SocialIcon> createState() => _SocialIconState();
}

class _SocialIconState extends State<SocialIcon> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Tooltip(
      message: widget.tooltip,
      child: MouseRegion(
        onEnter: (_) => setState(() => hover = true),
        onExit: (_) => setState(() => hover = false),
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: hover
                  ? theme.colorScheme.primary.withOpacity(0.15)
                  : theme.cardColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              widget.icon,
              color: hover
                  ? theme.colorScheme.primary
                  : theme.textTheme.bodyMedium?.color,
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileAvatar extends StatelessWidget {
  final double size;

  const ProfileAvatar({super.key, this.size = 250});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: theme.colorScheme.primary, width: 3),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.primary.withOpacity(0.3),
            blurRadius: 25,
          ),
        ],
      ),
      child: ClipOval(
        child: Image.asset(
          "assets/m3.png",
          fit: BoxFit.cover,
          width: size,
          height: size,
          errorBuilder: (context, error, stackTrace) {
            return _fallbackAvatar(theme, size);
          },
        ),
      ),
    );
  }

  Widget _fallbackAvatar(ThemeData theme, double size) {
    return Container(
      color: theme.cardColor,
      child: Icon(
        Icons.person,
        size: size * 0.5,
        color: theme.textTheme.bodyMedium?.color,
      ),
    );
  }
}