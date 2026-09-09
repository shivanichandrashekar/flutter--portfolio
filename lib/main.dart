import 'package:flutter/material.dart';

const Color primaryPurple = Color(0xFF6C4AB6);
const Color darkPurple = Color(0xFF452A75);
const Color lightPurple = Color(0xFFF5F0FF);

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'KOUKUNTLA SHIVANI',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryPurple,
        ),
        scaffoldBackgroundColor: Colors.white,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/about': (context) => const AboutPage(),
        '/projects': (context) => const ProjectsPage(),
      },
    );
  }
}

// --------------------------------------------------
// NAVIGATION BAR
// --------------------------------------------------

class PortfolioAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String currentPage;

  const PortfolioAppBar({
    super.key,
    required this.currentPage,
  });

  void goTo(BuildContext context, String route) {
    if (currentPage != route) {
      Navigator.pushReplacementNamed(context, route);
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 700;

    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: primaryPurple,
      foregroundColor: Colors.white,
      elevation: 0,
      title: const Text(
        'KOUKUNTLA SHIVANI',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
      actions: [
        if (!isMobile) ...[
          TextButton(
            onPressed: () => goTo(context, '/'),
            child: Text(
              'Home',
              style: TextStyle(
                color: Colors.white,
                fontWeight:
                    currentPage == '/' ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
          TextButton(
            onPressed: () => goTo(context, '/about'),
            child: Text(
              'About Me',
              style: TextStyle(
                color: Colors.white,
                fontWeight: currentPage == '/about'
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            ),
          ),
          TextButton(
            onPressed: () => goTo(context, '/projects'),
            child: Text(
              'Projects',
              style: TextStyle(
                color: Colors.white,
                fontWeight: currentPage == '/projects'
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            ),
          ),
          const SizedBox(width: 15),
        ] else
          PopupMenuButton<String>(
            icon: const Icon(Icons.menu),
            onSelected: (value) => goTo(context, value),
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: '/',
                child: Text('Home'),
              ),
              PopupMenuItem(
                value: '/about',
                child: Text('About Me'),
              ),
              PopupMenuItem(
                value: '/projects',
                child: Text('Projects'),
              ),
            ],
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

// --------------------------------------------------
// HOME PAGE
// --------------------------------------------------

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 700;

    return Scaffold(
      appBar: const PortfolioAppBar(currentPage: '/'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 25 : 80,
                vertical: isMobile ? 50 : 80,
              ),
              color: lightPurple,
              child: isMobile
                  ? const Column(
                      children: [
                        ProfileAvatar(),
                        SizedBox(height: 30),
                        HomeIntroduction(),
                      ],
                    )
                  : const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ProfileAvatar(),
                        SizedBox(width: 70),
                        Flexible(
                          child: HomeIntroduction(),
                        ),
                      ],
                    ),
            ),

            // QUICK BUTTONS
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
                vertical: 35,
              ),
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 18,
                runSpacing: 15,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                        context,
                        '/about',
                      );
                    },
                    icon: const Icon(Icons.person_outline),
                    label: const Text('About Me'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryPurple,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 15,
                      ),
                    ),
                  ),
                  OutlinedButton.icon(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                        context,
                        '/projects',
                      );
                    },
                    icon: const Icon(Icons.folder_open),
                    label: const Text('Projects'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: primaryPurple,
                      side: const BorderSide(
                        color: primaryPurple,
                        width: 2,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const PortfolioFooter(),
          ],
        ),
      ),
    );
  }
}

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 190,
      height: 190,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: primaryPurple,
        border: Border.all(
          color: darkPurple,
          width: 5,
        ),
      ),
      child: const Icon(
        Icons.person,
        size: 100,
        color: Colors.white,
      ),
    );
  }
}

class HomeIntroduction extends StatelessWidget {
  const HomeIntroduction({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'KOUKUNTLA SHIVANI',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: darkPurple,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Computer Science and Applied Mathematics',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            color: primaryPurple,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'A passionate student interested in technology, '
          'data, machine learning and organizational behaviour. '
          'I enjoy learning new skills and building useful projects.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            height: 1.6,
          ),
        ),
      ],
    );
  }
}

// --------------------------------------------------
// ABOUT PAGE
// --------------------------------------------------

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PortfolioAppBar(currentPage: '/about'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              const PageTitle(
                title: 'About Me',
                subtitle: 'Education, skills and technical interests',
              ),
              const SizedBox(height: 30),

              const InfoCard(
                icon: Icons.school,
                title: 'Education',
                content:
                    'Computer Science and Applied Mathematics',
              ),

              const InfoCard(
                icon: Icons.psychology,
                title: 'Skills',
                content:
                    'Organizational Behaviour, Problem Solving, '
                    'Communication, Teamwork and Analytical Thinking',
              ),

              const InfoCard(
                icon: Icons.code,
                title: 'Programming & Technical Skills',
                content:
                    'Dart, Python, C, HTML, JavaScript, ML and Power BI',
              ),

              const InfoCard(
                icon: Icons.lightbulb_outline,
                title: 'Areas of Interest',
                content:
                    'Machine Learning, Data Analysis, Web Development '
                    'and Organizational Behaviour',
              ),

              const SizedBox(height: 25),

ElevatedButton.icon(
  onPressed: () {
    Navigator.pushReplacementNamed(context, '/');
  },
  icon: const Icon(Icons.arrow_back),
  label: const Text('Back to Home'),
  style: ElevatedButton.styleFrom(
    backgroundColor: primaryPurple,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(
      horizontal: 25,
      vertical: 14,
    ),
  ),
),

const SizedBox(height: 30),
const PortfolioFooter(),
            ],
          ),
        ),
      ),
    );
  }
}

// --------------------------------------------------
// PROJECTS PAGE
// --------------------------------------------------

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PortfolioAppBar(currentPage: '/projects'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              const PageTitle(
                title: 'Projects',
                subtitle: 'Some of my academic and personal projects',
              ),

              const SizedBox(height: 30),

              LayoutBuilder(
                builder: (context, constraints) {
                  final isMobile = constraints.maxWidth < 700;

                  return Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 25,
                    runSpacing: 25,
                    children: [
                      ProjectCard(
                        width: isMobile ? constraints.maxWidth : 320,
                        icon: Icons.web,
                        title: 'Personal Portfolio',
                        description:
                            'A responsive personal portfolio website '
                            'developed using Flutter and Dart.',
                        technologies: 'Flutter • Dart',
                      ),

                      ProjectCard(
                        width: isMobile ? constraints.maxWidth : 320,
                        icon: Icons.auto_graph,
                        title: 'Machine Learning Project',
                        description:
                            'A machine learning project involving '
                            'data processing, analysis and prediction.',
                        technologies: 'Python • ML • Pandas',
                      ),
                    ],
                  );
                },
              ),
const SizedBox(height: 40),

ElevatedButton.icon(
  onPressed: () {
    Navigator.pushReplacementNamed(context, '/');
  },
  icon: const Icon(Icons.arrow_back),
  label: const Text('Back to Home'),
  style: ElevatedButton.styleFrom(
    backgroundColor: primaryPurple,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(
      horizontal: 25,
      vertical: 14,
    ),
  ),
),

const SizedBox(height: 30),
const PortfolioFooter(),
            ],
          ),
        ),
      ),
    );
  }
}

// --------------------------------------------------
// REUSABLE WIDGETS
// --------------------------------------------------

class PageTitle extends StatelessWidget {
  final String title;
  final String subtitle;

  const PageTitle({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: darkPurple,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}

class InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String content;

  const InfoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: lightPurple,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: primaryPurple.withValues(alpha:0.2),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 35,
            color: primaryPurple,
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: darkPurple,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  content,
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProjectCard extends StatelessWidget {
  final double width;
  final IconData icon;
  final String title;
  final String description;
  final String technologies;

  const ProjectCard({
    super.key,
    required this.width,
    required this.icon,
    required this.title,
    required this.description,
    required this.technologies,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: primaryPurple.withValues(alpha:0.25),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha:0.15),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 55,
            color: primaryPurple,
          ),
          const SizedBox(height: 18),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
              color: darkPurple,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 15,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            technologies,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: primaryPurple,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class PortfolioFooter extends StatelessWidget {
  const PortfolioFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      color: darkPurple,
      child: const Text(
        '© 2026 KOUKUNTLA SHIVANI | Built with Flutter',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 14,
        ),
      ),
    );
  }
}