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

  const HomeScreen({super.key, required this.onThemeToggle});

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
                  // Hero Section (Full Width)
                  Container(
                    key: homeKey,
                    width: double.infinity,
                    child: HeroSection(onNavTap: scrollToSection),
                  ),

                  // About
                  Container(
                    key: aboutKey,
                    width: double.infinity,
                    child: const AboutSection(),
                  ),

                  // Skills
                  Container(
                    key: skillsKey,
                    width: double.infinity,
                    child: const SkillsSection(),
                  ),

                  // Projects
                  Container(
                    key: projectsKey,
                    width: double.infinity,
                    child: const ProjectsSection(),
                  ),

                  // Education
                  Container(
                    key: educationKey,
                    width: double.infinity,
                    child: const EducationSection(),
                  ),

                  // Contact
                  Container(
                    key: contactKey,
                    width: double.infinity,
                    child: const ContactSection(),
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
