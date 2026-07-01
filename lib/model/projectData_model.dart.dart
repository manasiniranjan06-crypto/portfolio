// NOTE: `titile` is kept as-is (not renamed to `title`) to avoid breaking
// any code that already references `.titile` on this class. If starting
// fresh, prefer correcting the spelling everywhere at once.
class ProjectDataModel {
  final String titile;
  final String subtitle;
  final String description;
  final List<String> tags;

  const ProjectDataModel({
    required this.titile,
    required this.subtitle,
    required this.description,
    required this.tags,
  });
}

class SkillItem {
  final String name;
  final String icon;
  const SkillItem({required this.name, required this.icon});
}

const List<ProjectDataModel> projects = [
  ProjectDataModel(
    titile: 'Artisans',
    subtitle: 'AI + Java Desktop Application',
    description:
        'Developed an AI-powered desktop application that connects artisans with customers. The platform enables product management, secure authentication, order tracking, and inventory management using Firebase and JDBC.',
    tags: ['Java', 'JavaFX', 'Firebase', 'JDBC', 'Maven'],
  ),
  ProjectDataModel(
    titile: 'Grocery Shopping App',
    subtitle: 'Flutter + Firebase',
    description:
        'Developed a modern grocery shopping application with Firebase backend, featuring user authentication, category browsing, cart management, and responsive UI.',
    tags: ['Flutter', 'Firebase'],
  ),
  ProjectDataModel(
    titile: 'Portfolio Website',
    subtitle: 'Flutter Web',
    description:
        'Designed and developed a fully responsive personal portfolio website showcasing projects, skills, resume, and contact information with modern UI and smooth animations.',
    tags: ['Flutter Web'],
  ),
];

const List<String> certifications = [
  'Java Programming',
  'Flutter Development',
  'SQL',
  'Firebase',
  'Git & GitHub',
  'Problem Solving (DSA)',
  'Database Management',
  'SqfLite',
  'State Management',
  'GetX , provider , bloc ',
  'OOP in Java',
];

const List<String> whyHireMe = [
  'Strong Java Fundamentals',
  'Flutter Cross-Platform Development',
  'Firebase Integration',
  'Object-Oriented Programming',
  'Data Structures & Algorithms',
  'Database Management (SQL)',
  'AI-Powered Project Development',
  'Quick Learner',
  'Problem Solver',
  'Team Player',
  'Passionate About Building Real-World Applications',
];