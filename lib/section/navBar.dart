// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class PortfolioNavBar extends StatelessWidget {
//   final String activeSection;
//   final ValueChanged<String> onNavTap;
//   final VoidCallback onThemeToggle;

//   PortfolioNavBar({
//     super.key,
//     required this.activeSection,
//     required this.onNavTap,
//     required this.onThemeToggle,
//   });

//   @override
//   Widget build(BuildContext context) {
//     //navItems
//     final navItems = [
//       "Home",
//       "About",
//       "Skills",
//       "Projects",
//       "Education",
//       "Resume",
//       "Contact",
//     ];

//     final theme = Theme.of(context);

//     return Container(
//       height: 70,
//       padding: EdgeInsets.symmetric(horizontal: 30),
//       color: theme.appBarTheme.backgroundColor,
//       child: Row(
//         children: [
//           //Logo
//           RichText(
//             text: TextSpan(
//               style: GoogleFonts.poppins(
//                 fontSize: 22,
//                 fontWeight: FontWeight.bold,
//               ),
//               children: [
//                 TextSpan(
//                   text: "Manasi",
//                   style: GoogleFonts.poppins(
//                     color: theme.textTheme.bodyLarge?.color,
//                   ),
//                 ),
//                 TextSpan(
//                   text: "Niranjan",
//                   style: GoogleFonts.poppins(color: theme.colorScheme.primary),
//                 ),
//               ],
//             ),
//           ),

//           Spacer(),

//           //navigation items
//           for (String item in navItems)
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 10),
//               child: InkWell(
//                 onTap: () => onNavTap(item),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       item,
//                       style: GoogleFonts.poppins(
//                         fontSize: 15,
//                         fontWeight: FontWeight.w600,
//                         color: activeSection == item
//                             ? theme.colorScheme.primary
//                             : theme.textTheme.bodyMedium?.color,
//                       ),
//                     ),

//                     SizedBox(height: 5),

//                     Container(
//                       height: 2,
//                       width: 25,
//                       color: activeSection == item
//                           ? theme.colorScheme.primary
//                           : Colors.transparent,
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//           SizedBox(width: 15),

//           IconButton(
//             onPressed: onThemeToggle,
//             icon: Icon(
//               theme.brightness == Brightness.dark
//                   ? Icons.light_mode
//                   : Icons.dark_mode,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Screen Width
    double width = MediaQuery.of(context).size.width;

    // Responsive Values
    double logoSize;
    double navSize;
    double horizontalPadding;
    double spacing;

    if (width >= 1200) {
      // Desktop
      logoSize = 24;
      navSize = 16;
      horizontalPadding = 40;
      spacing = 18;
    } else if (width >= 700) {
      // Tablet
      logoSize = 20;
      navSize = 14;
      horizontalPadding = 20;
      spacing = 10;
    } else {
      // Mobile
      logoSize = 16;
      navSize = 12;
      horizontalPadding = 10;
      spacing = 6;
    }

    final navItems = [
      "Home",
      "About",
      "Skills",
      "Projects",
      "Education",
      "Contact",
    ];

    return Container(
      height: 70,
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      color: theme.appBarTheme.backgroundColor,
      child: Padding(
        padding: const EdgeInsets.only(top:20),
        child: Row(
          children: [
        
            /// Logo
            RichText(
              text: TextSpan(
                style: GoogleFonts.poppins(
                  fontSize: logoSize,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: "Manasi ",
                    style: TextStyle(
                      color: theme.textTheme.bodyLarge!.color,
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
        
            const SizedBox(width: 20),
        
            /// Navigation
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (String item in navItems)
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: spacing),
                        child: InkWell(
                          onTap: () => onNavTap(item),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                item,
                                style: GoogleFonts.poppins(
                                  fontSize: navSize,
                                  fontWeight: FontWeight.w600,
                                  color: activeSection == item
                                      ? theme.colorScheme.primary
                                      : theme.textTheme.bodyMedium!.color,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Container(
                                width: 25,
                                height: 2,
                                color: activeSection == item
                                    ? theme.colorScheme.primary
                                    : Colors.transparent,
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
        
            IconButton(
              onPressed: onThemeToggle,
              icon: Icon(
                theme.brightness == Brightness.dark
                    ? Icons.light_mode
                    : Icons.dark_mode,
              ),
            ),
          ],
        ),
      ),
    );
  }
}