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
    return SafeArea(
      child: Scaffold(
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
                          child: Icon(
                            Icons.menu,
                            color: Colors.white,
                            size: 22,
                          ),
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

                    // Weight Progress Card
                    _buildWeightProgressCard(),
                    const SizedBox(height: 16),

                    // Today's Nutritional Analysis Card
                    _buildNutritionalAnalysisCard(),
                    const SizedBox(height: 16),

                    // Exercise Card
                    _buildExerciseCard(),
                    const SizedBox(height: 16),

                    // Your Groceries Card
                    _buildGroceriesCard(),
                    const SizedBox(height: 100), // Extra space for bottom nav
                  ],
                ),
              ),
            ),
          ],
        ),
        // Floating Bottom Navigation Bar
        floatingActionButton: Container(
          margin: EdgeInsets.only(top: 40, right: 10),
          width: 55,
          height: 55,
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

  Widget _buildWeightProgressCard() {
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
              // Title
              const Text(
                'Weight Progress',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 24),

              // Chart Area
              SizedBox(
                height: 220,
                child: CustomPaint(
                  size: const Size(double.infinity, 220),
                  painter: WeightChartPainter(),
                ),
              ),

              const SizedBox(height: 20),

              // Time Period Stats
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.1),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildWeightStat('7 days', '+0.35kg', isPositive: true),
                    _buildWeightStat('30 days', '-2.1kg', isPositive: false),
                    _buildWeightStat('90 days', '-3.5kg', isPositive: false),
                    _buildWeightStat('120 days', '-9.2kg', isPositive: false),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWeightStat(
    String period,
    String weight, {
    required bool isPositive,
  }) {
    return Column(
      children: [
        Text(
          period,
          style: TextStyle(
            fontSize: 12,
            color: isPositive
                ? const Color(0xFFf1580a)
                : Colors.white.withOpacity(0.6),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          weight,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: isPositive
                ? const Color(0xFFf1580a)
                : const Color(0xFF7ED957),
          ),
        ),
      ],
    );
  }

  Widget _buildNutritionalAnalysisCard() {
    return CustomPaint(
      painter: DashedBorderPainter(),
      child: Container(
        margin: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.07),
          borderRadius: BorderRadius.circular(22),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(22),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with icon and title
                  Row(
                    children: [
                      Icon(Icons.bolt, color: Color(0xFFf1580a), size: 30),
                      const SizedBox(width: 5),
                      const Text(
                        "Today's Nutritional Analysis",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Content box
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.8),
                          height: 1.5,
                        ),
                        children: [
                          const TextSpan(text: "You haven't eaten any "),
                          const TextSpan(
                            text: "iron",
                            style: TextStyle(
                              color: Color(0xFFf1580a),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const TextSpan(text: " today.\nConsider adding "),
                          const TextSpan(
                            text: "beans",
                            style: TextStyle(
                              color: Color(0xFFf1580a),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const TextSpan(text: " to your dinner."),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildExerciseCard() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.07),
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: Colors.white.withOpacity(0.15),
              width: 1.2,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left Side - Title and Dumbbell Image
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        'Exercise',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Image.asset(
                      'assets/WeightsImage.png',
                      width: 100,
                      height: 100,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ), // Right Side - Calories Box and Button
              Expanded(
                flex: 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Calories Burnt Box
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        // color: Colors.white.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.1),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                'assets/FLAME.png',
                                width: 24,
                                height: 24,
                                color: const Color(0xFFf1580a),
                              ),
                              const SizedBox(width: 6),
                              Flexible(
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Row(
                                    children: [
                                      const Text(
                                        '551',
                                        style: TextStyle(
                                          fontSize: 28,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        'kcal',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white.withOpacity(0.9),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Calories Burnt Today',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withOpacity(0.6),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Logging Button
                    Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFf1580a), Color(0xFFff7a3d)],
                        ),
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFf1580a).withOpacity(0.4),
                            blurRadius: 10,
                            spreadRadius: 0,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            // Add logging exercise action
                          },
                          borderRadius: BorderRadius.circular(25),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 18,
                                ),
                                const SizedBox(width: 6),
                                Flexible(
                                  child: Text(
                                    'Logging an Exercise',
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
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

  Widget _buildGroceriesCard() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.07),
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: Colors.white.withOpacity(0.15),
              width: 1.2,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Your Groceries',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Turn your weekly diet into\na shopping list with no effort.',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withOpacity(0.7),
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Generate Shopping List Button
                    Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFf1580a), Color(0xFFff7a3d)],
                        ),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFf1580a).withOpacity(0.4),
                            blurRadius: 12,
                            spreadRadius: 0,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            // Generate shopping list action
                          },
                          borderRadius: BorderRadius.circular(30),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 10,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 14,
                                ),
                                const SizedBox(width: 3),
                                Flexible(
                                  child: Text(
                                    'Generate Shopping List',
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 16),

              // Right Side - Shopping Bag Image
              Expanded(
                flex: 3,
                child: Image.asset(
                  'assets/ShoppingBagImage.png',
                  fit: BoxFit.cover,
                  height: 150,
                  width: 150,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Custom Painter for Weight Progress Chart
class WeightChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..color = const Color(0xFFf1580a);

    final fillPaint = Paint()
      ..style = PaintingStyle.fill
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          const Color(0xFFf1580a).withOpacity(0.3),
          const Color(0xFFf1580a).withOpacity(0.2),
          const Color(0xFFf1580a).withOpacity(0.0),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final gridPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = Colors.white.withOpacity(0.1);

    // Draw horizontal grid lines (dotted)
    final gridLinePositions = [0.2, 0.5, 0.8]; // Positions for 72k, 71k, 70k
    for (var pos in gridLinePositions) {
      final y = size.height * pos;
      _drawDottedLine(canvas, Offset(40, y), Offset(size.width, y), gridPaint);
    }

    // Draw Y-axis labels
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.right,
    );

    final labels = ['72k', '71k', '70k', '0'];
    final positions = [0.2, 0.5, 0.8, 1.0];

    for (var i = 0; i < labels.length; i++) {
      textPainter.text = TextSpan(
        text: labels[i],
        style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 12),
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(0, size.height * positions[i] - 20));
    }

    // Draw X-axis labels
    final xLabels = ['M', 'T', 'W', 'Th', 'F', 'S', 'S'];
    final xSpacing = (size.width - 60) / (xLabels.length - 1);

    for (var i = 0; i < xLabels.length; i++) {
      textPainter.text = TextSpan(
        text: xLabels[i],
        style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 12),
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(40 + (i * xSpacing) - (textPainter.width / 2), size.height - 20),
      );
    }

    // Chart data points (simulating the wave pattern from the image)
    final dataPoints = [
      0.54, // M (going up)
      0.34, // T (peak)
      0.54, // W (dip)
      0.64, // Th
      0.44, // F (small peak)
      0.34, // S (going down)
      0.54, // S (lowest)
    ];

    // Create path for the line
    final path = Path();
    final fillPath = Path();

    final chartHeight = size.height - 40;
    final startX = 50.0;

    path.moveTo(startX, chartHeight * dataPoints[0]);
    fillPath.moveTo(startX, chartHeight);
    fillPath.lineTo(startX, chartHeight * dataPoints[0]);

    for (var i = 0; i < dataPoints.length; i++) {
      final x = startX + (i * xSpacing);
      final y = chartHeight * dataPoints[i];

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        // Create smooth curves using quadratic bezier
        final prevX = startX + ((i - 1) * xSpacing);
        final prevY = chartHeight * dataPoints[i - 1];
        final controlX = (prevX + x) / 2;

        path.quadraticBezierTo(controlX, prevY, x, y);
        fillPath.quadraticBezierTo(controlX, prevY, x, y);
      }
    }

    // Close the fill path
    fillPath.lineTo(startX + ((dataPoints.length - 1) * xSpacing), chartHeight);
    fillPath.close();

    // Draw the filled area first
    canvas.drawPath(fillPath, fillPaint);

    // Draw the line on top
    canvas.drawPath(path, paint);
  }

  // Helper method to draw dotted lines
  void _drawDottedLine(Canvas canvas, Offset start, Offset end, Paint paint) {
    const double dashWidth = 5;
    const double dashSpace = 5;
    double distance = (end - start).distance;
    double dashCount = distance / (dashWidth + dashSpace);

    for (int i = 0; i < dashCount; i++) {
      double startX = start.dx + ((end.dx - start.dx) / dashCount) * i;
      double startY = start.dy + ((end.dy - start.dy) / dashCount) * i;
      double endX = start.dx + ((end.dx - start.dx) / dashCount) * (i + 0.5);
      double endY = start.dy + ((end.dy - start.dy) / dashCount) * (i + 0.5);

      canvas.drawLine(Offset(startX, startY), Offset(endX, endY), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Custom Painter for Dashed Gradient Border
class DashedBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final borderRadius = 30.0;
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(borderRadius));

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..shader = const LinearGradient(
        colors: [
          Color.fromRGBO(241, 88, 10, 0.7), // Orange
          Color.fromRGBO(191, 129, 154, 0.6), // Purple
          Color.fromRGBO(137, 128, 235, 0.6), // Blue
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(rect);

    final path = Path()..addRRect(rrect);

    // Draw dashed border
    _drawDashedPath(canvas, path, paint);
  }

  void _drawDashedPath(Canvas canvas, Path path, Paint paint) {
    const dashWidth = 10.0;
    const dashSpace = 8.0;

    final pathMetrics = path.computeMetrics();

    for (final metric in pathMetrics) {
      double distance = 0.0;
      bool draw = true;

      while (distance < metric.length) {
        final length = draw ? dashWidth : dashSpace;
        final nextDistance = distance + length;

        if (draw) {
          final extractPath = metric.extractPath(
            distance,
            nextDistance > metric.length ? metric.length : nextDistance,
          );
          canvas.drawPath(extractPath, paint);
        }

        distance = nextDistance;
        draw = !draw;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
