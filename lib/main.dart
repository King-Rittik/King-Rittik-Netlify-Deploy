import 'package:flutter/material.dart';
import 'package:kr_netlify/utils/kutils.dart';
import 'dart:ui';
import 'dart:math' as math;

void main() {
  runApp(const KingRittikApp());
}

const String kingRittikYouTube =
    'https://www.youtube.com/@king_rittik?sub_confirmation=1';

class KingRittikApp extends StatelessWidget {
  const KingRittikApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'King Rittik - YouTube Creator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'SF Pro Display',
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _floatingController;
  late AnimationController _glowController;

  @override
  void initState() {
    super.initState();
    _floatingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _floatingController.dispose();
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MouseRegion(
        onHover: (event) {
          setState(() {});
        },
        child: Stack(
          children: [
            // Animated Gradient Background
            AnimatedGradientBackground(controller: _glowController),

            // Floating Orbs
            ...List.generate(
              5,
              (index) =>
                  FloatingOrb(controller: _floatingController, index: index),
            ),

            // Main Content
            SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 60),

                      // Header Section
                      _buildHeader(),

                      const SizedBox(height: 100),

                      // Hero Section
                      _buildHeroSection(),

                      const SizedBox(height: 120),

                      // Stats Section
                      _buildStatsSection(),

                      const SizedBox(height: 120),

                      // Content Cards
                      _buildContentCards(),

                      const SizedBox(height: 120),

                      // CTA Section
                      _buildCTASection(),

                      const SizedBox(height: 80),

                      // Footer
                      _buildFooter(),

                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return GlassContainer(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFF0050), Color(0xFFFF6B9D)],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFFF0050).withValues(alpha: 0.5),
                        blurRadius: 20,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.play_circle_filled,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                const Text(
                  'King Rittik',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
            _buildNavButton(
              'Subscribe',
              Icons.favorite,
              onTap: () => Kutils.kLaunchUrl(kingRittikYouTube),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection() {
    return Center(
      child: Column(
        children: [
          // Animated Badge
          AnimatedBuilder(
            animation: _floatingController,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(
                  0,
                  math.sin(_floatingController.value * 2 * math.pi) * 10,
                ),
                child: GlassContainer(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF00F5FF), Color(0xFF0080FF)],
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.rocket_launch,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'Flutter & Web Development',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 40),

          // Main Heading
          ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [Color(0xFFFFFFFF), Color(0xFFB4B4FF), Color(0xFFFF6B9D)],
            ).createShader(bounds),
            child: const Text(
              'Learn. Build.\nDeploy.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 80,
                fontWeight: FontWeight.bold,
                height: 1.1,
                color: Colors.white,
                letterSpacing: -2,
              ),
            ),
          ),

          const SizedBox(height: 32),

          // Subtitle
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Text(
              'Master Flutter development and deployment with step-by-step tutorials. From code to cloud in minutes.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: Colors.white.withValues(alpha: 0.7),
                height: 1.6,
                letterSpacing: 0.3,
              ),
            ),
          ),

          const SizedBox(height: 50),

          // CTA Buttons
          Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            children: [
              _buildPrimaryButton(
                'Watch Tutorials',
                Icons.play_circle_outline,
                const LinearGradient(
                  colors: [Color(0xFFFF0050), Color(0xFFFF6B9D)],
                ),
                onTap: () => Kutils.kLaunchUrl(kingRittikYouTube),
              ),
              _buildSecondaryButton('View Projects', Icons.code),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Wrap(
          spacing: 24,
          runSpacing: 24,
          alignment: WrapAlignment.center,
          children: [
            _buildStatCard(
              '100,000+',
              'Views',
              Icons.people,
              const Color(0xFFFF0050),
            ),
            _buildStatCard(
              '50+',
              'Tutorials',
              Icons.video_library,
              const Color(0xFF00F5FF),
            ),
            _buildStatCard(
              '100%',
              'Free Content',
              Icons.favorite,
              const Color(0xFFFF6B9D),
            ),
          ],
        );
      },
    );
  }

  Widget _buildStatCard(
    String value,
    String label,
    IconData icon,
    Color color,
  ) {
    return GlassContainer(
      width: 240,
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [color, color.withValues(alpha: 0.6)],
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: color.withValues(alpha: 0.4),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Icon(icon, size: 32, color: Colors.white),
            ),
            const SizedBox(height: 20),
            Text(
              value,
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                letterSpacing: -1,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white.withValues(alpha: 0.6),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContentCards() {
    final topics = [
      {
        'title': 'Flutter Basics',
        'icon': Icons.flutter_dash,
        'color': const Color(0xFF02569B),
      },
      {
        'title': 'Web Deployment',
        'icon': Icons.cloud_upload,
        'color': const Color(0xFFFF0050),
      },
      {
        'title': 'UI/UX Design',
        'icon': Icons.palette,
        'color': const Color(0xFF00F5FF),
      },
      {
        'title': 'State Management',
        'icon': Icons.settings_suggest,
        'color': const Color(0xFFFF6B9D),
      },
    ];

    return Wrap(
      spacing: 24,
      runSpacing: 24,
      alignment: WrapAlignment.center,
      children: topics
          .map(
            (topic) => _buildTopicCard(
              topic['title'] as String,
              topic['icon'] as IconData,
              topic['color'] as Color,
            ),
          )
          .toList(),
    );
  }

  Widget _buildTopicCard(String title, IconData icon, Color color) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GlassContainer(
        width: 280,
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [color, color.withValues(alpha: 0.6)],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(icon, size: 32, color: Colors.white),
              ),
              const SizedBox(height: 24),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Step-by-step guides and real-world examples',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withValues(alpha: 0.6),
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Text(
                    'Learn More',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: color,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(Icons.arrow_forward, size: 16, color: color),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCTASection() {
    return Center(
      child: GlassContainer(
        width: 800,
        child: Padding(
          padding: const EdgeInsets.all(60),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFF0050), Color(0xFFFF6B9D)],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFF0050).withValues(alpha: 0.4),
                      blurRadius: 30,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.subscriptions,
                  size: 48,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                'Ready to Start Learning?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -1,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Join thousands of developers learning Flutter',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white.withValues(alpha: 0.7),
                ),
              ),
              const SizedBox(height: 40),
              _buildPrimaryButton(
                'Subscribe on YouTube',

                Icons.play_arrow,
                const LinearGradient(
                  colors: [Color(0xFFFF0050), Color(0xFFFF6B9D)],
                ),
                onTap: () => Kutils.kLaunchUrl(kingRittikYouTube),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Column(
      children: [
        const Divider(color: Colors.white24),
        const SizedBox(height: 32),
        Text(
          '© ${DateTime.now().year} King Rittik. Built with Flutter & ❤️',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.5),
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSocialIcon(Icons.video_library),
            const SizedBox(width: 16),
            _buildSocialIcon(Icons.code),
            const SizedBox(width: 16),
            _buildSocialIcon(Icons.flutter_dash),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialIcon(IconData icon) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        ),
        child: Icon(icon, size: 20, color: Colors.white.withValues(alpha: 0.7)),
      ),
    );
  }

  Widget _buildNavButton(String text, IconData icon, {void Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFFF0050), Color(0xFFFF6B9D)],
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFFF0050).withValues(alpha: 0.4),
                blurRadius: 20,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(icon, size: 18, color: Colors.white),
              const SizedBox(width: 8),
              Text(
                text,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPrimaryButton(
    String text,
    IconData icon,
    Gradient gradient, {
    void Function()? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFFF0050).withValues(alpha: 0.4),
                blurRadius: 25,
                spreadRadius: 3,
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 22, color: Colors.white),
              const SizedBox(width: 12),
              Text(
                text,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSecondaryButton(String text, IconData icon) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GlassContainer(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 22, color: Colors.white),
              const SizedBox(width: 12),
              Text(
                text,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Glass Container Widget
class GlassContainer extends StatelessWidget {
  final Widget child;
  final double? width;

  const GlassContainer({super.key, required this.child, this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.2),
          width: 1.5,
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withValues(alpha: 0.1),
            Colors.white.withValues(alpha: 0.05),
          ],
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: child,
        ),
      ),
    );
  }
}

// Animated Background
class AnimatedGradientBackground extends StatelessWidget {
  final AnimationController controller;

  const AnimatedGradientBackground({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.lerp(
                  const Color(0xFF0F0C29),
                  const Color(0xFF1A1A2E),
                  controller.value,
                )!,
                Color.lerp(
                  const Color(0xFF1A1A2E),
                  const Color(0xFF16213E),
                  controller.value,
                )!,
                Color.lerp(
                  const Color(0xFF16213E),
                  const Color(0xFF0F0C29),
                  controller.value,
                )!,
              ],
            ),
          ),
        );
      },
    );
  }
}

// Floating Orb
class FloatingOrb extends StatelessWidget {
  final AnimationController controller;
  final int index;

  const FloatingOrb({super.key, required this.controller, required this.index});

  @override
  Widget build(BuildContext context) {
    final colors = [
      const Color(0xFFFF0050),
      const Color(0xFF00F5FF),
      const Color(0xFFFF6B9D),
      const Color(0xFF0080FF),
      const Color(0xFFB4B4FF),
    ];

    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final offset = math.sin((controller.value + index * 0.2) * 2 * math.pi);
        return Positioned(
          left: 100.0 + index * 200,
          top: 100.0 + offset * 100 + index * 150,
          child: Container(
            width: 200 + index * 50,
            height: 200 + index * 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  colors[index % colors.length].withValues(alpha: 0.3),
                  colors[index % colors.length].withValues(alpha: 0),
                ],
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
              child: Container(),
            ),
          ),
        );
      },
    );
  }
}
