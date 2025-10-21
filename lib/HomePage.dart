import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int _selectedIndex = 0;
  late AnimationController _controller1;
  late AnimationController _controller2;
  late AnimationController _controller3;

  @override
  void initState() {
    super.initState();
    _controller1 = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat(reverse: true);

    _controller2 = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat(reverse: true);

    _controller3 = AnimationController(
      duration: const Duration(seconds: 6),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          // Animated Background with Glowing Orbs
          AnimatedBuilder(
            animation: Listenable.merge([
              _controller1,
              _controller2,
              _controller3,
            ]),
            builder: (context, child) {
              return Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF0a0a0a),
                      Color(0xFF1a1a1a),
                      Color(0xFF0a0a0a),
                    ],
                  ),
                ),
                child: Stack(
                  children: [
                    // Glowing Orb 1 - Top Right (attached to right edge)
                    Positioned(
                      top: -50 + (_controller1.value * 30),
                      right: -150,
                      child: Container(
                        width: 400,
                        height: 400,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: [
                              const Color(0xFFD2691E).withOpacity(0.35),
                              const Color(0xFFCD853F).withOpacity(0.2),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Glowing Orb 2 - Bottom Right (attached to right edge)
                    Positioned(
                      bottom: -100 + (_controller2.value * 40),
                      right: -120,
                      child: Container(
                        width: 380,
                        height: 380,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: [
                              const Color(0xFFD2691E).withOpacity(0.3),
                              const Color(0xFFCD853F).withOpacity(0.18),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Glowing Orb 3 - Left Side (attached to left edge)
                    Positioned(
                      top: 200 + (_controller3.value * 50),
                      left: -140,
                      child: Container(
                        width: 380,
                        height: 380,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: [
                              const Color(0xFFD2691E).withOpacity(0.32),
                              const Color(0xFFCD853F).withOpacity(0.2),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          // Scrollable Content
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 60),
                  // Header with Menu Icon
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.2),
                            width: 1,
                          ),
                        ),
                        child: Icon(Icons.menu, color: Colors.white, size: 22),
                      ),
                    ],
                  ),
                  const Text(
                    "Today's overview",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Nutrition Overview Card
                  _buildNutritionOverviewCard(),
                  const SizedBox(height: 16),

                  // Keep up the streak Card
                  _buildStreakCard(),
                  const SizedBox(height: 16),
                  _buildGlassCard(
                    title: 'Analytics',
                    subtitle: 'View your performance',
                    icon: Icons.analytics,
                    color: const Color(0xFFf1580a),
                  ),
                  const SizedBox(height: 16),
                  _buildGlassCard(
                    title: 'Messages',
                    subtitle: '5 new messages',
                    icon: Icons.message,
                    color: const Color(0xFFf1580a),
                  ),
                  const SizedBox(height: 16),
                  _buildGlassCard(
                    title: 'Settings',
                    subtitle: 'Manage your account',
                    icon: Icons.settings,
                    color: const Color(0xFFf1580a),
                  ),
                  const SizedBox(height: 16),
                  _buildGlassCard(
                    title: 'Notifications',
                    subtitle: '3 new updates',
                    icon: Icons.notifications,
                    color: const Color(0xFFf1580a),
                  ),
                  const SizedBox(height: 16),
                  _buildGlassCard(
                    title: 'Profile',
                    subtitle: 'View your profile',
                    icon: Icons.person,
                    color: const Color(0xFFf1580a),
                  ),
                  const SizedBox(height: 100), // Extra space for bottom nav
                ],
              ),
            ),
          ),
        ],
      ),
      // Floating Bottom Navigation Bar
      floatingActionButton: Container(
        margin: EdgeInsets.only(top: 40),
        width: 65,
        height: 65,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white.withOpacity(0.2), width: 2),
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [const Color(0xFFf1580a), const Color(0xFFf1580a)],
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFf1580a).withOpacity(0.4),
              blurRadius: 15,
              spreadRadius: 1,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              // Add action
            },
            borderRadius: BorderRadius.circular(50),
            child: const Center(
              child: Icon(Icons.add, size: 32, color: Colors.white),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 20,
              spreadRadius: 0,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(
              height: 75,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFFE74E1F).withOpacity(0.1),
                    const Color(0xFFD5633A).withOpacity(0.2),
                  ],
                ),
                borderRadius: BorderRadius.circular(40),
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                  width: 1.2,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItemWithLabel(Icons.home_rounded, 'Home', 0),
                  _buildNavItemWithLabel(
                    Icons.description_outlined,
                    'Diary',
                    1,
                  ),
                  const SizedBox(width: 56), // Space for FAB
                  _buildNavItemWithLabel(Icons.restaurant_menu, 'Diet', 2),
                  _buildNavItemWithLabel(
                    Icons.bar_chart_rounded,
                    'Progress',
                    3,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItemWithLabel(IconData icon, String label, int index) {
    bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected
                  ? const Color(0xFFf1580a)
                  : Colors.white.withOpacity(0.5),
              size: 28,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected
                    ? const Color(0xFFf1580a)
                    : Colors.white.withOpacity(0.5),
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNutritionOverviewCard() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.07),
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: Colors.white.withOpacity(0.15),
              width: 1.2,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Nutrition Overview',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(6),

                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.1),
                          blurRadius: 1,
                          spreadRadius: 0.1,
                        ),
                      ],
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      'assets/Info.png',
                      width: 20,
                      height: 20,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                'Calories & macros',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
              const SizedBox(height: 24),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Eaten
                  Column(
                    children: [
                      const Text(
                        '1250',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Eaten',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),

                  // Circular Progress Chart
                  SizedBox(
                    width: 180,
                    height: 150,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        // Background gray ring (270 degree arc)
                        SfRadialGauge(
                          axes: <RadialAxis>[
                            RadialAxis(
                              minimum: 0,
                              maximum: 100,
                              startAngle: 135,
                              endAngle: 45,
                              showLabels: false,
                              showTicks: false,
                              showAxisLine: false,
                              radiusFactor: 1.0,
                              pointers: <GaugePointer>[
                                RangePointer(
                                  value: 100,
                                  width: 16,
                                  color: Colors.grey.withOpacity(0.3),
                                  cornerStyle: CornerStyle.bothCurve,
                                ),
                              ],
                            ),
                          ],
                        ),
                        // Orange progress ring on top
                        SfRadialGauge(
                          axes: <RadialAxis>[
                            RadialAxis(
                              minimum: 0,
                              maximum: 100,
                              startAngle: 135,
                              endAngle: 45,
                              showLabels: false,
                              showTicks: false,
                              showAxisLine: false,
                              radiusFactor: 1.0,
                              pointers: <GaugePointer>[
                                RangePointer(
                                  value: 39,
                                  width: 16,
                                  color: const Color(0xFFf1580a),
                                  cornerStyle: CornerStyle.bothCurve,
                                  enableAnimation: true,
                                  animationDuration: 1200,
                                  animationType: AnimationType.ease,
                                ),
                              ],
                            ),
                          ],
                        ),
                        // Center content
                        Positioned(
                          bottom: 40,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                'assets/FLAME.png',
                                width: 28,
                                height: 28,
                                color: const Color(0xFFf1580a),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                '1503',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  height: 1.0,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Remaining',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white.withOpacity(0.7),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Goal
                  Column(
                    children: [
                      const Text(
                        '3200',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Goal',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Divider
              Container(height: 1, color: Colors.white.withOpacity(0.1)),

              const SizedBox(height: 20),

              // Macros Progress Bars
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: _buildMacroProgress(
                      icon: 'assets/ProteinIcon.png',
                      label: 'Protein',
                      current: '145',
                      total: '180g',
                      progress: 0.81,
                      color: const Color(0xFFFF6B9D),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildMacroProgress(
                      icon: 'assets/CarbsIcon.png',
                      label: 'Carbs',
                      current: '135',
                      total: '210g',
                      progress: 0.64,
                      color: const Color(0xFF7ED957),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildMacroProgress(
                      icon: 'assets/FatsIcon.png',
                      label: 'Fats',
                      current: '55',
                      total: '90g',
                      progress: 0.61,
                      color: const Color(0xFFFFB84D),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMacroProgress({
    required String icon,
    required String label,
    required String current,
    required String total,
    required double progress,
    required Color color,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Image.asset(icon, width: 16, height: 16),
            const SizedBox(width: 4),
            Flexible(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white.withOpacity(0.8),
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                height: 8,
                child: LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.grey.withOpacity(0.3),
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                ),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              '$current / $total',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Colors.white.withOpacity(0.9),
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStreakCard() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.07),
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: Colors.white.withOpacity(0.15),
              width: 1.2,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  // color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.symmetric(
                    vertical: BorderSide(
                      color: Colors.white.withOpacity(0.2),
                      width: 1,
                    ),
                    horizontal: BorderSide(
                      color: Colors.white.withOpacity(0.2),
                      width: 0.5,
                    ),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/Streak.png', width: 45, height: 45),
                    const SizedBox(height: 6),
                    const Text(
                      '37 Days',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),

              // Right side - Text and week indicators
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Keep up the streak!',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Small wins today fuel big results tomorrow.',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withOpacity(0.6),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Week day indicators - horizontal row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _buildDayIndicator('Mon', true),
                        const SizedBox(width: 8),
                        _buildDayIndicator('Tue', true),
                        const SizedBox(width: 8),
                        _buildDayIndicator('Wed', true),
                        const SizedBox(width: 8),
                        _buildDayIndicator('Thu', false),
                        const SizedBox(width: 8),
                        _buildDayIndicator('Fri', false),
                        const SizedBox(width: 8),
                        _buildDayIndicator('Sat', false),
                        const SizedBox(width: 8),
                        _buildDayIndicator('Sun', false),
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

  Widget _buildDayIndicator(String day, bool isCompleted) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(
            color: isCompleted
                ? const Color(0xFFf1580a)
                : Colors.grey.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: isCompleted
                ? const Icon(Icons.check, color: Colors.white, size: 12)
                : Container(), // Empty for incomplete days
          ),
        ),
        const SizedBox(height: 4),
        Text(
          day,
          style: TextStyle(fontSize: 10, color: Colors.white.withOpacity(0.5)),
        ),
      ],
    );
  }

  Widget _buildGlassCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(icon, color: Colors.white, size: 30),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.white.withOpacity(0.5),
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
