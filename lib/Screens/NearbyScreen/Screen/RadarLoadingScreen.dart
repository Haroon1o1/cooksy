import 'package:cooksy/Screens/NearbyScreen/widgets/RadarLoadingPainter.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class RadarLoadingScreen extends StatefulWidget {
  const RadarLoadingScreen({super.key});

  @override
  State<RadarLoadingScreen> createState() => _RadarLoadingScreenState();
}

class _RadarLoadingScreenState extends State<RadarLoadingScreen> with TickerProviderStateMixin {
  late AnimationController _radarController;
  late AnimationController _pulseController;
  late AnimationController _progressController;
  late AnimationController _textController;
  late Animation<double> _radarAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<double> _progressAnimation;
  late Animation<double> _textAnimation;

  final List<String> _loadingSteps = [
    "🛰️ Getting GPS location...",
    "📡 Connecting to servers...",
    "🔍 Scanning nearby restaurants...",
    "⭐ Loading ratings & reviews...",
    "🍽️ Preparing your results...",
  ];

  int _currentStep = 0;
  int _foundRestaurants = 0;

  @override
  void initState() {
    super.initState();

    _radarController = AnimationController(duration: const Duration(seconds: 2), vsync: this);
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _progressController = AnimationController(duration: const Duration(seconds: 8), vsync: this);
    _textController = AnimationController(duration: const Duration(milliseconds: 500), vsync: this);

    _radarAnimation = Tween<double>(
      begin: 0,
      end: 2 * math.pi,
    ).animate(CurvedAnimation(parent: _radarController, curve: Curves.linear));

    _pulseAnimation = Tween<double>(
      begin: 0.9,
      end: 1.1,
    ).animate(CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut));

    _progressAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _progressController, curve: Curves.easeInOut));

    _textAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _textController, curve: Curves.easeInOut));

    _radarController.repeat();
    _pulseController.repeat(reverse: true);
    _progressController.forward();

    _startStepUpdates();
  }

  void _startStepUpdates() {
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) _updateStep();
    });
  }

  void _updateStep() {
    if (_currentStep < _loadingSteps.length - 1) {
      setState(() {
        _currentStep++;
        if (_currentStep >= 2) {
          _foundRestaurants = math.Random().nextInt(3) + 1;
        }
      });
      _textController.reset();
      _textController.forward();

      Future.delayed(Duration(milliseconds: _currentStep == 2 ? 2000 : 1500), () {
        if (mounted) _updateStep();
      });
    }
  }

  @override
  void dispose() {
    _radarController.dispose();
    _pulseController.dispose();
    _progressController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF0A0A0A), Color(0xFF1A1A1A), Color(0xFF0A0A0A)],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(height: 40),

              // App Title
              const Text(
                "COOKSY RADAR",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 3,
                ),
              ),

              const SizedBox(height: 60),

              // Radar Animation
              AnimatedBuilder(
                animation: _pulseAnimation,
                child: SizedBox(
                  width: 250,
                  height: 250,
                  child: AnimatedBuilder(
                    animation: _radarAnimation,
                    builder: (context, child) {
                      return CustomPaint(
                        painter: RadarLoadingPainter(
                          radarAngle: _radarAnimation.value,
                          pulseScale: _pulseAnimation.value,
                        ),
                      );
                    },
                  ),
                ),
                builder: (context, child) {
                  return Transform.scale(scale: _pulseAnimation.value, child: child);
                },
              ),

              const SizedBox(height: 40),

              // Progress Bar
              Container(
                width: double.infinity,
                height: 6,
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(3),
                ),
                child: AnimatedBuilder(
                  animation: _progressAnimation,
                  builder: (context, child) {
                    return FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: _progressAnimation.value,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(colors: [Colors.green, Colors.lightGreen]),
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),

              // Progress Percentage
              AnimatedBuilder(
                animation: _progressAnimation,
                builder: (context, child) {
                  return Text(
                    "${(_progressAnimation.value * 100).toInt()}%",
                    style: const TextStyle(
                      color: Colors.green,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),

              const SizedBox(height: 30),

              // Current Step with Animation
              AnimatedBuilder(
                animation: _textAnimation,
                builder: (context, child) {
                  return Opacity(
                    opacity: _textAnimation.value,
                    child: Transform.translate(
                      offset: Offset(0, 20 * (1 - _textAnimation.value)),
                      child: Text(
                        _loadingSteps[_currentStep],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 20),

              // Found Restaurants Counter
              if (_currentStep >= 2)
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.green.withOpacity(0.5)),
                  ),
                  child: Text(
                    "Found: $_foundRestaurants restaurants nearby",
                    style: const TextStyle(
                      color: Colors.green,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

              const Spacer(),

              // Bottom Stats
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStatItem("📍", "GPS", _currentStep >= 1 ? "Active" : "Waiting"),
                  _buildStatItem("📶", "Signal", _currentStep >= 2 ? "Strong" : "Connecting"),
                  _buildStatItem("🎯", "Scan", _currentStep >= 3 ? "Complete" : "Scanning"),
                ],
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(String icon, String title, String status) {
    bool isActive = status != "Waiting" && status != "Connecting" && status != "Scanning";

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isActive ? Colors.green.withOpacity(0.1) : Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isActive ? Colors.green.withOpacity(0.3) : Colors.grey.withOpacity(0.3),
        ),
      ),
      child: Column(
        children: [
          Text(icon, style: const TextStyle(fontSize: 20)),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              color: isActive ? Colors.green : Colors.grey,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            status,
            style: TextStyle(color: isActive ? Colors.green : Colors.grey, fontSize: 10),
          ),
        ],
      ),
    );
  }
}
