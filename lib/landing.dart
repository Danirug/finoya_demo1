// lib/landing_page.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:visibility_detector/visibility_detector.dart';
//import 'package:intercom_flutter/intercom_flutter.dart';
import 'intercom.dart'; // Import the Intercom functions

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return Scaffold(
      // Optional: Uncomment to add a floating button to show the Intercom Messenger
      /*
      floatingActionButton: FloatingActionButton(
        onPressed: showIntercomMessenger,
        backgroundColor: Colors.tealAccent,
        child: const Icon(Icons.chat, color: Colors.black87),
      ),
      */
      body: VisibilityDetector(
        key: const Key('landing_page'),
        onVisibilityChanged: (info) {
          if (info.visibleFraction > 0) {
            // Log page view event
            logIntercomEvent('viewed_landing_page');
            // Update Intercom for SPA navigation
            updateIntercom();
          }
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Sticky Header
              FadeInDown(
                duration: const Duration(milliseconds: 800),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 16 : 40,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.95),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Finoya',
                        style: GoogleFonts.inter(
                          fontSize: isMobile ? 20 : 28,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF1A237E),
                        ),
                      ),
                      Row(
                        children: [
                          _buildNavButton('Features', isMobile),
                          const SizedBox(width: 20),
                          _buildNavButton('Pricing', isMobile),
                          const SizedBox(width: 20),
                          _buildCTAButton(
                            'Start Free Trial',
                            isMobile,
                            eventName: 'clicked_start_free_trial',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // Hero Section
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: isMobile ? 40 : 80,
                  horizontal: isMobile ? 16 : 40,
                ),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF1A237E), Color(0xFF3F51B5)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: FadeInUp(
                  duration: const Duration(milliseconds: 1000),
                  child: Column(
                    children: [
                      Text(
                        'Simplify Your Finances with Noya AI',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: isMobile ? 32 : 56,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          letterSpacing: -1,
                          shadows: [
                            Shadow(
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.2),
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        width: isMobile ? 200 : 300,
                        height: 4,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Colors.tealAccent, Colors.amberAccent],
                          ),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Real-time cash flow analysis, AI-driven forecasts, and secure insights—without spreadsheets.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: isMobile ? 16 : 20,
                          color: Colors.white70,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 32),
                      _buildCTAButton(
                        'Get Started Now',
                        isMobile,
                        isHero: true,
                        eventName: 'clicked_get_started',
                      ),
                    ],
                  ),
                ),
              ),
              // Features Section
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: isMobile ? 40 : 80,
                  horizontal: isMobile ? 16 : 40,
                ),
                color: Colors.grey[50],
                child: Column(
                  children: [
                    FadeIn(
                      duration: const Duration(milliseconds: 800),
                      child: Text(
                        'Why Finoya Stands Out',
                        style: GoogleFonts.inter(
                          fontSize: isMobile ? 28 : 40,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF1A237E),
                        ),
                      ),
                    ),
                    const SizedBox(height: 48),
                    Wrap(
                      spacing: isMobile ? 16 : 32,
                      runSpacing: isMobile ? 16 : 32,
                      alignment: WrapAlignment.center,
                      children: [
                        FadeInLeft(
                          duration: const Duration(milliseconds: 1000),
                          child: FeatureCard(
                            title: 'Real-Time Insights',
                            description:
                                'Track cash flow with dynamic KPI visualizations.',
                            icon: Icons.bar_chart,
                            isMobile: isMobile,
                          ),
                        ),
                        FadeInUp(
                          duration: const Duration(milliseconds: 1000),
                          child: FeatureCard(
                            title: 'AI-Powered Advice',
                            description:
                                'Personalized recommendations to optimize your finances.',
                            icon: Icons.smart_toy,
                            isMobile: isMobile,
                          ),
                        ),
                        FadeInRight(
                          duration: const Duration(milliseconds: 1000),
                          child: FeatureCard(
                            title: 'Scenario Planning',
                            description: 'Forecast with future-ready tools.',
                            icon: Icons.timeline,
                            isMobile: isMobile,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavButton(String text, bool isMobile) {
    return TextButton(
      onPressed: () {
        // Log navigation button click
        logIntercomEvent('clicked_nav_${text.toLowerCase()}');
      },
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      child: Text(
        text,
        style: GoogleFonts.inter(
          fontSize: isMobile ? 14 : 16,
          color: const Color(0xFF1A237E),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildCTAButton(String text, bool isMobile,
      {bool isHero = false, String? eventName}) {
    return ElevatedButton(
      onPressed: () {
        // Log button click event
        if (eventName != null) {
          logIntercomEvent(eventName);
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isHero ? Colors.tealAccent : const Color(0xFF1A237E),
        foregroundColor: isHero ? Colors.black87 : Colors.white,
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 20 : 30,
          vertical: isMobile ? 12 : 16,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 5,
        shadowColor: Colors.black.withOpacity(0.2),
      ),
      child: Text(
        text,
        style: GoogleFonts.inter(
          fontSize: isMobile ? 14 : 16,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class FeatureCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final bool isMobile;

  const FeatureCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isMobile ? 280 : 320,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Colors.tealAccent, Colors.amberAccent],
              ),
            ),
            child: Icon(
              icon,
              size: isMobile ? 32 : 40,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: isMobile ? 18 : 22,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF1A237E),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: GoogleFonts.inter(
              fontSize: isMobile ? 14 : 16,
              color: Colors.blueGrey[700],
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}