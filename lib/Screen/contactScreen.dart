import 'package:flutter/material.dart';
import 'package:portfolio/model/launcher.dart';
import 'package:portfolio/model/links.dart';
import 'package:portfolio/theme/app_theme.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _msgCtrl = TextEditingController();

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _msgCtrl.dispose();
    super.dispose();
  }

  void _handleSend() {
    if (_nameCtrl.text.trim().isEmpty ||
        _emailCtrl.text.trim().isEmpty ||
        _msgCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill in name, email and message."),
        ),
      );
      return;
    }

    sendEmail(
      to: PortfolioLinks.email,
      subject: "Portfolio contact from ${_nameCtrl.text.trim()}",
      body:
          "${_msgCtrl.text.trim()}\n\n— ${_nameCtrl.text.trim()} (${_emailCtrl.text.trim()})",
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Opening your email app to send the message..."),
      ),
    );

    _nameCtrl.clear();
    _emailCtrl.clear();
    _msgCtrl.clear();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 900;

    return Container(
      width: double.infinity,
      color: theme.scaffoldBackgroundColor,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 60,
        vertical: 60,
      ),
      child: isMobile
          ? Column(
              children: [
                const _ResumeCard(),
                const SizedBox(height: 20),
                _ContactCard(
                  nameCtrl: _nameCtrl,
                  emailCtrl: _emailCtrl,
                  msgCtrl: _msgCtrl,
                  onSend: _handleSend,
                ),
              ],
            )
          : IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Expanded(child: _ResumeCard()),
                  const SizedBox(width: 20),
                  Expanded(
                    flex: 2,
                    child: _ContactCard(
                      nameCtrl: _nameCtrl,
                      emailCtrl: _emailCtrl,
                      msgCtrl: _msgCtrl,
                      onSend: _handleSend,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

enum _ResumeType { flutter, java }

class _ResumeCard extends StatefulWidget {
  const _ResumeCard();

  @override
  State<_ResumeCard> createState() => _ResumeCardState();
}

class _ResumeCardState extends State<_ResumeCard> {
  _ResumeType selected = _ResumeType.flutter;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.colors;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: colors.cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "RESUME",
            style: TextStyle(
              color: colors.sectionLabel,
              fontWeight: FontWeight.w700,
              fontSize: 11,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "My Resume",
            style: TextStyle(
              color: theme.textTheme.bodyLarge?.color,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "Pick a version and download my resume to know more about my education, experience, projects and skills.",
            style: TextStyle(
              color: theme.textTheme.bodyMedium?.color,
              fontSize: 13,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 20),
          _ResumeToggle(
            selected: selected,
            onChanged: (v) => setState(() => selected = v),
          ),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _DownloadButton(
                  onTap: () => openUrl(
                    selected == _ResumeType.flutter
                        ? (PortfolioLinks.flutterResumeUrl)
                        : PortfolioLinks.javaResumeUrl,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Container(
                width: 90,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: theme.dividerColor),
                ),
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "MANASI\nNIRANJAN",
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...List.generate(
                      6,
                      (i) => Container(
                        margin: const EdgeInsets.only(bottom: 4),
                        height: 4,
                        width: double.infinity,
                        color: Colors.grey[300],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Segmented toggle to pick which resume version to download.
class _ResumeToggle extends StatelessWidget {
  final _ResumeType selected;
  final ValueChanged<_ResumeType> onChanged;

  const _ResumeToggle({required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.colors;

    Widget option(String label, _ResumeType type) {
      final active = selected == type;
      return Expanded(
        child: GestureDetector(
          onTap: () => onChanged(type),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            padding: const EdgeInsets.symmetric(vertical: 10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: active ? theme.colorScheme.primary : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: active
                    ? Colors.white
                    : theme.textTheme.bodyMedium?.color,
              ),
            ),
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: colors.tagBg,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Row(
        children: [
          option("Flutter Developer", _ResumeType.flutter),
          option("Java Developer", _ResumeType.java),
        ],
      ),
    );
  }
}

class _DownloadButton extends StatefulWidget {
  final VoidCallback onTap;
  const _DownloadButton({required this.onTap});

  @override
  State<_DownloadButton> createState() => _DownloadButtonState();
}

class _DownloadButtonState extends State<_DownloadButton> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.colors;

    return MouseRegion(
      onEnter: (_) => setState(() => hover = true),
      onExit: (_) => setState(() => hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: hover ? colors.accentGlow : theme.colorScheme.primary,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.download_rounded, color: Colors.white, size: 18),
              SizedBox(width: 8),
              Flexible(
                child: Text(
                  "Download",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 13.5,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContactCard extends StatelessWidget {
  final TextEditingController nameCtrl;
  final TextEditingController emailCtrl;
  final TextEditingController msgCtrl;
  final VoidCallback onSend;

  const _ContactCard({
    required this.nameCtrl,
    required this.emailCtrl,
    required this.msgCtrl,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.colors;
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 900;

    final info = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "CONTACT ME",
          style: TextStyle(
            color: colors.sectionLabel,
            fontWeight: FontWeight.w700,
            fontSize: 11,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          "Let's Work Together!",
          style: TextStyle(
            color: theme.textTheme.bodyLarge?.color,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        const SizedBox(height: 20),
        _InfoRow(
          icon: Icons.email_outlined,
          label: PortfolioLinks.email,
          onTap: () => sendEmail(to: PortfolioLinks.email),
        ),
        const SizedBox(height: 12),
        const _InfoRow(
          icon: Icons.location_on_outlined,
          label: "Pune, Maharashtra, India",
        ),
        const SizedBox(height: 12),
        _InfoRow(
          icon: Icons.code_rounded,
          label: "https://github.com/manasiniranjan06-crypto",
          onTap: () => openUrl(PortfolioLinks.github),
        ),
        const SizedBox(height: 12),
        _InfoRow(
          icon: Icons.work_outline_rounded,
          label: "https://linkedin.com/in/manasi-niranjan-607b28360",
          onTap: () => openUrl(PortfolioLinks.linkedin),
        ),
        const SizedBox(height: 12),
        _InfoRow(
          icon: Icons.terminal_rounded,
          label: "https://leetcode.com/u/manasiniranjan_06",
          onTap: () => openUrl(PortfolioLinks.leetcode),
        ),
      ],
    );

    final form = Column(
      children: [
        _FormField(hint: "Your Name", controller: nameCtrl),
        const SizedBox(height: 12),
        _FormField(hint: "Your Email", controller: emailCtrl),
        const SizedBox(height: 12),
        _FormField(hint: "Your Message", controller: msgCtrl, maxLines: 4),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: _SendButton(onTap: onSend),
        ),
      ],
    );

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: colors.cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.dividerColor),
      ),
      child: isMobile
          ? Column(children: [info, const SizedBox(height: 20), form])
          : IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: info),
                  const SizedBox(width: 24),
                  Expanded(flex: 2, child: form),
                ],
              ),
            ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  const _InfoRow({required this.icon, required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: MouseRegion(
        cursor: onTap != null ? SystemMouseCursors.click : MouseCursor.defer,
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: theme.colorScheme.primary, size: 16),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  color: theme.textTheme.bodyMedium?.color,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FormField extends StatefulWidget {
  final String hint;
  final int maxLines;
  final TextEditingController controller;
  const _FormField({
    required this.hint,
    required this.controller,
    this.maxLines = 1,
  });

  @override
  State<_FormField> createState() => _FormFieldState();
}

class _FormFieldState extends State<_FormField> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextField(
      controller: widget.controller,
      maxLines: widget.maxLines,
      style: TextStyle(color: theme.textTheme.bodyLarge?.color, fontSize: 14),
      decoration: InputDecoration(
        hintText: widget.hint,
        hintStyle: TextStyle(
          color: theme.textTheme.bodyMedium?.color,
          fontSize: 13,
        ),
        filled: true,
        fillColor: theme.scaffoldBackgroundColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: theme.dividerColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: theme.dividerColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: theme.colorScheme.primary),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 12,
        ),
      ),
    );
  }
}

class _SendButton extends StatefulWidget {
  final VoidCallback onTap;
  const _SendButton({required this.onTap});

  @override
  State<_SendButton> createState() => _SendButtonState();
}

class _SendButtonState extends State<_SendButton> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.colors;

    return MouseRegion(
      onEnter: (_) => setState(() => hover = true),
      onExit: (_) => setState(() => hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: hover ? colors.accentGlow : theme.colorScheme.primary,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Center(
            child: Text(
              "Send Message",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
