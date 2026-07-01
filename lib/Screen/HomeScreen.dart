
import 'package:flutter/material.dart';
import 'package:portfolio/Screen/aboutScreen.dart';
import 'package:portfolio/Screen/contactScreen.dart';
import 'package:portfolio/Screen/educationSec.dart';
import 'package:portfolio/Screen/heroSection.dart';
import 'package:portfolio/Screen/projectSection.dart';
import 'package:portfolio/Screen/skilllSection.dart';
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

  // Section Keys
  final homeKey = GlobalKey();
  final aboutKey = GlobalKey();
  final skillsKey = GlobalKey();
  final projectsKey = GlobalKey();
  final educationKey = GlobalKey();
  final contactKey = GlobalKey();

  // Scroll to selected section
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

  // Reusable Two-Column Row
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

          VerticalDivider(
            width: 1,
            color: Theme.of(context).dividerColor,
          ),

          Expanded(
            child: rightWidget,
          ),
        ],
      ),
    );
  }

  // Clean stand-in for sections not built yet. This is NOT Placeholder() --
  // Placeholder() draws the diagonal-cross box you saw on screen. This is
  // just plain text on the theme's background so the page still looks like
  // a page while you build the real section files one by one.
  Widget _comingSoon(String label) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(40),
      color: theme.scaffoldBackgroundColor,
      child: Text(
        "$label section coming soon",
        style: TextStyle(
          color: theme.textTheme.bodyMedium?.color,
          fontSize: 16,
        ),
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
          // Navbar
          PortfolioNavBar(
            activeSection: activeSection,
            onNavTap: scrollToSection,
            onThemeToggle: widget.onThemeToggle,
          ),

          // Page Content
          Expanded(
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                children: [

                  // Hero Section (Full Width) -- wired to your real file
                  Container(
                    key: homeKey,
                    width: double.infinity,
                    child: const HeroSection(),
                  ),

                 // abbout page
                  Container(
                    key: aboutKey,
                    width: double.infinity,
                    child: AboutSection(),
                  ),
                  //skills
                  Container(
                    key: skillsKey,
                    width: double.infinity,
                    child: SkillsSection(),
                  ),
                Container(
                    key: projectsKey,
                    width: double.infinity,
                    child: const ProjectsSection(),
                  ),

                 // abbout page
                  Container(
                    key: educationKey,
                    width: double.infinity,
                    child: EducationSection(),
                  ),
                  //skills
                  Container(
                    key: contactKey,
                    width: double.infinity,
                    child: ContactSection(),
                  ),
                  
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}