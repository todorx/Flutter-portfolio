import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatefulWidget {
  const PortfolioApp({super.key});

  @override
  State<PortfolioApp> createState() => _PortfolioAppState();
}

class _PortfolioAppState extends State<PortfolioApp> {
  bool isDarkMode = false;

  void toggleDarkMode() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Light Theme Colors
    const lightBg = Color(0xFFF5F4EF);
    const lightText = Color(0xFF1C1C1A);
    const lightTextSecondary = Color(0xFF5A5A55);
    const lightAccent = Color(0xFFD97757); // Muted terracotta
    const lightCardOutline = Color(0xFFE5E4DE);

    // Dark Theme Colors
    const darkBg = Color(0xFF1E1E1C);
    const darkText = Color(0xFFEFEFEA);
    const darkTextSecondary = Color(0xFFA0A09A);
    const darkAccent = Color(0xFFD97757);
    const darkCardOutline = Color(0xFF333330);

    final bg = isDarkMode ? darkBg : lightBg;
    final text = isDarkMode ? darkText : lightText;
    final textSecondary = isDarkMode ? darkTextSecondary : lightTextSecondary;
    final accent = isDarkMode ? darkAccent : lightAccent;
    final cardOutline = isDarkMode ? darkCardOutline : lightCardOutline;

    return MaterialApp(
      title: 'Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: bg,
        colorScheme: ColorScheme.fromSeed(
          seedColor: accent,
          brightness: isDarkMode ? Brightness.dark : Brightness.light,
          background: bg,
          onBackground: text,
        ),
        textTheme: TextTheme(
          displayLarge: GoogleFonts.fraunces(
            color: text,
            fontWeight: FontWeight.w400,
          ),
          displayMedium: GoogleFonts.fraunces(
            color: text,
            fontWeight: FontWeight.w400,
          ),
          headlineLarge: GoogleFonts.fraunces(
            color: text,
            fontWeight: FontWeight.w400,
          ),
          headlineMedium: GoogleFonts.fraunces(
            color: text,
            fontWeight: FontWeight.w400,
          ),
          bodyLarge: GoogleFonts.inter(color: textSecondary, height: 1.6),
          bodyMedium: GoogleFonts.inter(color: textSecondary, height: 1.6),
          bodySmall: GoogleFonts.inter(color: textSecondary, height: 1.6),
          labelLarge: GoogleFonts.inter(
            color: accent,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      home: PortfolioHome(
        isDarkMode: isDarkMode,
        onToggleTheme: toggleDarkMode,
        textCol: text,
        textSecCol: textSecondary,
        accentCol: accent,
        cardOutlineCol: cardOutline,
      ),
    );
  }
}

class PortfolioHome extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback onToggleTheme;
  final Color textCol;
  final Color textSecCol;
  final Color accentCol;
  final Color cardOutlineCol;

  const PortfolioHome({
    super.key,
    required this.isDarkMode,
    required this.onToggleTheme,
    required this.textCol,
    required this.textSecCol,
    required this.accentCol,
    required this.cardOutlineCol,
  });

  @override
  State<PortfolioHome> createState() => _PortfolioHomeState();
}

class _PortfolioHomeState extends State<PortfolioHome> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final contentWidth = screenWidth > 800 ? 640.0 : screenWidth * 0.85;

    return Scaffold(
      body: Stack(
        children: [
          Scrollbar(
            controller: _scrollController,
            child: SingleChildScrollView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: contentWidth),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 140.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FadeInSection(
                          scrollController: _scrollController,
                          child: _buildHero(context),
                        ),
                        const SizedBox(height: 100),
                        FadeInSection(
                          scrollController: _scrollController,
                          child: _buildDivider(),
                        ),
                        const SizedBox(height: 100),
                        FadeInSection(
                          scrollController: _scrollController,
                          child: _buildAbout(context),
                        ),
                        const SizedBox(height: 100),
                        FadeInSection(
                          scrollController: _scrollController,
                          child: _buildSkills(context),
                        ),
                        const SizedBox(height: 100),
                        FadeInSection(
                          scrollController: _scrollController,
                          child: _buildProjects(context),
                        ),
                        const SizedBox(height: 120),
                        FadeInSection(
                          scrollController: _scrollController,
                          child: _buildDivider(),
                        ),
                        const SizedBox(height: 60),
                        FadeInSection(
                          scrollController: _scrollController,
                          child: _buildContact(context),
                        ),
                        const SizedBox(height: 60),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 32,
            right: 32,
            child: IconButton(
              icon: Icon(
                widget.isDarkMode
                    ? Icons.light_mode_outlined
                    : Icons.dark_mode_outlined,
                color: widget.textCol,
                size: 20,
              ),
              onPressed: widget.onToggleTheme,
              splashRadius: 24,
              tooltip: 'Toggle Theme',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(height: 1, width: 40, color: widget.cardOutlineCol);
  }

  Widget _buildHero(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Todor Todorovski',
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
            fontSize: 52,
            height: 1.1,
            letterSpacing: -1,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Software Engineer · CS Student',
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(fontSize: 20, color: widget.textCol),
        ),
        const SizedBox(height: 24),
        Text(
          'Building calm, thoughtful interfaces and robust systems.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
    );
  }

  Widget _buildAbout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About',
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(fontSize: 24),
        ),
        const SizedBox(height: 24),
        Text(
          'I am a CS student focusing on web development and functional programming. '
          'I enjoy transforming complex requirements into simple, elegant solutions. '
          'When I\'m not coding, you can find me reading sci-fi, playing chess or exploring the outdoors.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 17),
        ),
      ],
    );
  }

  Widget _buildSkills(BuildContext context) {
    final skills = [
      'Flutter & Dart',
      'React & TypeScript',
      'Python',
      'C++',
      'Node.js',
      'PostgreSQL',
      'Git',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Skills',
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(fontSize: 24),
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: skills.map((skill) {
            return Text(
              skill,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: 16,
                color: widget.textCol,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildProjects(BuildContext context) {
    final projects = [
      {
        'title': 'Minimalist Habit Tracker',
        'desc': 'A calm, data-driven tool to build routines without the noise.',
        'tech': 'Flutter, SQLite, Riverpod',
        'link': 'https://github.com/example/habit',
      },
      {
        'title': 'Oasis UI',
        'desc':
            'An open-source design system focused on accessibility and whitespace.',
        'tech': 'React, Tailwind, Storybook',
        'link': 'https://github.com/example/oasis',
      },
      {
        'title': 'Echo API',
        'desc': 'A fast, lightweight mocking server for frontend development.',
        'tech': 'Go, Redis',
        'link': 'https://github.com/example/echo',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Projects',
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(fontSize: 24),
        ),
        const SizedBox(height: 32),
        Column(
          children: projects.map((p) => _buildProjectCard(context, p)).toList(),
        ),
      ],
    );
  }

  Widget _buildProjectCard(BuildContext context, Map<String, String> project) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          border: Border.all(color: widget.cardOutlineCol, width: 1),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    project['title']!,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontFamily: GoogleFonts.inter().fontFamily,
                      fontWeight: FontWeight.w500,
                      color: widget.textCol,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                InkWell(
                  onTap: () async {
                    final uri = Uri.parse(project['link']!);
                    if (await canLaunchUrl(uri)) {
                      await launchUrl(uri);
                    }
                  },
                  borderRadius: BorderRadius.circular(20),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Icon(
                      Icons.arrow_outward,
                      size: 18,
                      color: widget.textSecCol,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              project['desc']!,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontSize: 15),
            ),
            const SizedBox(height: 20),
            Text(
              project['tech']!,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontFamily: GoogleFonts.inter().fontFamily,
                fontSize: 13,
                color: widget.accentCol,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContact(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Contact',
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(fontSize: 24),
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 32,
          runSpacing: 16,
          children: [
            _HoverLink(
              text: 'Email',
              url: 'mailto:todorovski@todorx.dev',
              color: widget.textCol,
              hoverColor: widget.accentCol,
            ),
            _HoverLink(
              text: 'GitHub',
              url: 'https://github.com/todorx',
              color: widget.textCol,
              hoverColor: widget.accentCol,
            ),
            _HoverLink(
              text: 'LinkedIn',
              url: 'https://www.linkedin.com/in/todortodorovski',
              color: widget.textCol,
              hoverColor: widget.accentCol,
            ),
          ],
        ),
      ],
    );
  }
}

class _HoverLink extends StatefulWidget {
  final String text;
  final String url;
  final Color color;
  final Color hoverColor;

  const _HoverLink({
    required this.text,
    required this.url,
    required this.color,
    required this.hoverColor,
  });

  @override
  State<_HoverLink> createState() => _HoverLinkState();
}

class _HoverLinkState extends State<_HoverLink> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: GestureDetector(
        onTap: () async {
          final uri = Uri.parse(widget.url);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri);
          }
        },
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200),
          style: GoogleFonts.inter(
            fontSize: 16,
            color: _isHovering ? widget.hoverColor : widget.color,
            decoration: _isHovering
                ? TextDecoration.underline
                : TextDecoration.none,
            decorationColor: _isHovering ? widget.hoverColor : widget.color,
          ),
          child: Text(widget.text),
        ),
      ),
    );
  }
}

class FadeInSection extends StatefulWidget {
  final Widget child;
  final ScrollController scrollController;

  const FadeInSection({
    super.key,
    required this.child,
    required this.scrollController,
  });

  @override
  State<FadeInSection> createState() => _FadeInSectionState();
}

class _FadeInSectionState extends State<FadeInSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<Offset> _slide;
  bool _isVisible = false;
  final GlobalKey _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _opacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    widget.scrollController.addListener(_checkVisibility);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkVisibility();
    });
  }

  void _checkVisibility() {
    if (_isVisible || !mounted) return;

    final context = _key.currentContext;
    if (context == null) return;

    final RenderObject? renderObject = context.findRenderObject();
    if (renderObject is RenderBox) {
      final position = renderObject.localToGlobal(Offset.zero);
      final screenHeight = MediaQuery.of(this.context).size.height;
      // Trigger when element is slightly above the bottom of the screen
      if (position.dy < screenHeight - 60) {
        setState(() {
          _isVisible = true;
        });
        _controller.forward();
      }
    }
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_checkVisibility);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _key,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Opacity(
            opacity: _opacity.value,
            child: FractionalTranslation(
              translation: _slide.value,
              child: widget.child,
            ),
          );
        },
      ),
    );
  }
}
