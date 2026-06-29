import 'package:flutter/material.dart';
import 'package:portfolio/section/navBar.dart';



class HomeScreen extends StatefulWidget {
  final VoidCallback onThemeToggle;

  const HomeScreen({
    super.key,
    required this.onThemeToggle,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController scrollController = ScrollController();

  String activeSection = "Home";

  final homeKey = GlobalKey();
  final aboutKey = GlobalKey();
  final skillsKey = GlobalKey();
  final projectsKey = GlobalKey();
  final educationKey = GlobalKey();
  final resumeKey = GlobalKey();
  final contactKey = GlobalKey();

  void scrollToSection(String section) {
    setState(() {
      activeSection = section;
    });

    GlobalKey? key;

    switch (section) {
      case "Home":
        key = homeKey;
        break;

      case "About":
        key = aboutKey;
        break;

      case "Skills":
        key = skillsKey;
        break;

      case "Projects":
        key = projectsKey;
        break;

      case "Education":
        key = educationKey;
        break;

      case "Contact":
        key = contactKey;
        break;
    }

    if (key?.currentContext != null) {
      Scrollable.ensureVisible(
        key!.currentContext!,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    }
  }

  Widget buildRow({
    required GlobalKey leftKey,
    required Widget leftWidget,
    required Widget rightWidget,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              key: leftKey,
              child: leftWidget,
            ),
          ),

          const VerticalDivider(width: 1),

          Expanded(
            child: rightWidget,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      body: Column(
        children: [

          PortfolioNavBar(
            activeSection: activeSection,
            onNavTap: scrollToSection,
            onThemeToggle: widget.onThemeToggle,
          ),

        ],
      ),
    );
  }
}