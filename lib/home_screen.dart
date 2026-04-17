import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    _TodayPage(),
    _ProgramPage(),
    _ProgressPage(),
    _ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: _currentIndex,
          children: _screens,
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Color(0x0A000000), blurRadius: 12, offset: Offset(0, -2)),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _NavItem(icon: Icons.today_outlined, activeIcon: Icons.today, label: 'Today', index: 0, currentIndex: _currentIndex, onTap: _switchTab),
                _NavItem(icon: Icons.restaurant_menu_outlined, activeIcon: Icons.restaurant_menu, label: 'Program', index: 1, currentIndex: _currentIndex, onTap: _switchTab),
                _NavItem(icon: Icons.insights_outlined, activeIcon: Icons.insights, label: 'Progress', index: 2, currentIndex: _currentIndex, onTap: _switchTab),
                _NavItem(icon: Icons.person_outline, activeIcon: Icons.person, label: 'Profile', index: 3, currentIndex: _currentIndex, onTap: _switchTab),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _switchTab(int index) {
    setState(() => _currentIndex = index);
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final int index;
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.index,
    required this.currentIndex,
    required this.onTap,
  });

  bool get _active => index == currentIndex;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: _active ? const Color(0xFFC4607A).withOpacity(0.08) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(_active ? activeIcon : icon, size: 22, color: _active ? const Color(0xFFC4607A) : const Color(0xFF9B9B9B)),
            const SizedBox(height: 3),
            Text(label, style: TextStyle(fontSize: 11, fontWeight: _active ? FontWeight.w700 : FontWeight.w500, color: _active ? const Color(0xFFC4607A) : const Color(0xFF9B9B9B))),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// TODAY PAGE
// ═══════════════════════════════════════════════════════════

class _TodayPage extends StatelessWidget {
  const _TodayPage();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // Header
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text('Good Morning', style: GoogleFonts.cormorantGaramond(fontSize: 26, fontWeight: FontWeight.w600, color: const Color(0xFF2D2D2D))),
                      const SizedBox(height: 2),
                      Text(_getDate(), style: const TextStyle(fontSize: 13, color: Color(0xFF9B9B9B))),
                    ])),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(color: const Color(0xFFC4607A).withOpacity(0.1), borderRadius: BorderRadius.circular(14)),
                      child: const Icon(Icons.notifications_outlined, color: Color(0xFFC4607A), size: 22),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        // Calorie Card
        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: [
                SizedBox(
                  width: 160, height: 160,
                  child: CustomPaint(painter: _CalorieRingPainter(progress: 0.65, color: const Color(0xFFC4607A)), child: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text('1,340', style: GoogleFonts.dmSans(fontSize: 32, fontWeight: FontWeight.w800, color: const Color(0xFF2D2D2D))),
                    const Text('of 2,000 kcal', style: TextStyle(fontSize: 12, color: Color(0xFF9B9B9B))),
                    const SizedBox(height: 4),
                    Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3), decoration: BoxDecoration(color: const Color(0xFF7A9E87).withOpacity(0.12), borderRadius: BorderRadius.circular(8)), child: const Text('660 left', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF7A9E87)))),
                  ]))),
                ),
                const SizedBox(height: 24),
                Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                  _MacroWidget(label: 'Protein', value: '82g', target: '120g', color: const Color(0xFFC4607A), progress: 0.68),
                  _MacroWidget(label: 'Carbs', value: '145g', target: '200g', color: const Color(0xFF7A9E87), progress: 0.72),
                  _MacroWidget(label: 'Fat', value: '38g', target: '65g', color: const Color(0xFFD4A853), progress: 0.58),
                ]),
              ],
            ),
          ),
        ),

        // Water Tracker
        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.blue.withOpacity(0.1), borderRadius: BorderRadius.circular(10)), child: const Icon(Icons.water_drop, color: Colors.blue, size: 20)),
                  const SizedBox(width: 12),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
                    Text('Water Intake', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF2D2D2D))),
                    Text('5 of 8 glasses (1,250ml)', style: TextStyle(fontSize: 12, color: Color(0xFF9B9B9B))),
                  ])),
                  const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(value: 0.625, backgroundColor: Color(0xFFEDE8E4), valueColor: AlwaysStoppedAnimation<Color>(Colors.blue), strokeWidth: 4)),
                ]),
                const SizedBox(height: 14),
                Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: List.generate(8, (i) => Container(width: 36, height: 36, decoration: BoxDecoration(color: i < 5 ? Colors.blue.withOpacity(0.8) : const Color(0xFFEDE8E4), borderRadius: BorderRadius.circular(8)), child: Center(child: Icon(i < 5 ? Icons.water_drop : Icons.water_drop_outlined, color: i < 5 ? Colors.white : Colors.blue.withOpacity(0.3), size: 16)))),
              ]),
            ],
          ),
        ),

        // Cycle Card
        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFC4607A).withOpacity(0.2))),
            child: Row(
              children: [
                Container(width: 8, height: 50, decoration: BoxDecoration(color: const Color(0xFF7A9E87), borderRadius: BorderRadius.circular(4))),
                const SizedBox(width: 12),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
                  Text('Follicular Phase', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Color(0xFF7A9E87))),
                  SizedBox(height: 2),
                  Text('Day 9 of 28  ·  Next period in 19 days', style: TextStyle(fontSize: 12, color: Color(0xFF9B9B9B))),
                ])),
                const Icon(Icons.chevron_right, color: Color(0xFF9B9B9B), size: 20),
              ],
            ),
          ),
        ),

        // Quick Add
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Text('Today\'s Meals', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Color(0xFF2D2D2D))),
              Container(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8), decoration: BoxDecoration(color: const Color(0xFFC4607A), borderRadius: BorderRadius.circular(10)), child: Row(mainAxisSize: MainAxisSize.min, children: const [Icon(Icons.add, color: Colors.white, size: 18), SizedBox(width: 4), Text('Quick Add', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white))])),
            ]),
          ),
        ),

        // Meal entries
        SliverToBoxAdapter(child: _MealCard(emoji: '🌅', name: 'Greek Yogurt Parfait', calories: 320, type: 'Breakfast', time: '8:30 AM')),
        SliverToBoxAdapter(child: _MealCard(emoji: '☀️', name: 'Grilled Chicken Salad', calories: 380, type: 'Lunch', time: '12:45 PM')),
        SliverToBoxAdapter(child: _MealCard(emoji: '🍎', name: 'Dark Chocolate & Almonds', calories: 220, type: 'Snack', time: '3:00 PM')),

        const SliverToBoxAdapter(child: SizedBox(height: 100)),
      ],
    );
  }

  String _getDate() {
    final now = DateTime.now();
    final months = ['January','February','March','April','May','June','July','August','September','October','November','December'];
    final days = ['Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday'];
    return '${days[now.weekday - 1]}, ${months[now.month - 1]} ${now.day}';
  }
}

class _CalorieRingPainter extends CustomPainter {
  final double progress;
  final Color color;
  _CalorieRingPainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - 14) / 2;
    const stroke = 12;
    final bgPaint = Paint()..color = const Color(0xFFEDE8E4)..style = PaintingStyle.stroke..strokeWidth = stroke;
    canvas.drawCircle(center, radius, bgPaint);
    final fgPaint = Paint()..color = color..style = PaintingStyle.stroke..strokeWidth = stroke..strokeCap = StrokeCap.round;
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -3.14159 / 2, 2 * 3.14159 * progress, false, fgPaint);
  }

  @override
  bool shouldRepaint(covariant _CalorieRingPainter old) => old.progress != progress;
}

class _MacroWidget extends StatelessWidget {
  final String label, value, target;
  final Color color;
  final double progress;
  const _MacroWidget({required this.label, required this.value, required this.target, required this.color, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      SizedBox(width: 64, height: 64, child: CustomPaint(painter: _SmallRingPainter(progress: progress, color: color), child: Center(child: Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF2D2D2D)))))),
      const SizedBox(height: 6),
      Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: Color(0xFF6B6B6B))),
      Text('/ $target', style: const TextStyle(fontSize: 10, color: Color(0xFF9B9B9B))),
    ]);
  }
}

class _SmallRingPainter extends CustomPainter {
  final double progress;
  final Color color;
  _SmallRingPainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - 6) / 2;
    canvas.drawCircle(center, radius, Paint()..color = color.withOpacity(0.15)..style = PaintingStyle.stroke..strokeWidth = 5);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -3.14159 / 2, 2 * 3.14159 * progress, false, Paint()..color = color..style = PaintingStyle.stroke..strokeWidth = 5..strokeCap = StrokeCap.round);
  }

  @override
  bool shouldRepaint(covariant _SmallRingPainter old) => old.progress != progress;
}

class _MealCard extends StatelessWidget {
  final String emoji, name, calories, type, time;
  const _MealCard({required this.emoji, required this.name, required this.calories, required this.type, required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
      child: Row(children: [
        Container(width: 44, height: 44, decoration: BoxDecoration(color: const Color(0xFFC4607A).withOpacity(0.08), borderRadius: BorderRadius.circular(12)), child: Center(child: Text(emoji, style: const TextStyle(fontSize: 22)))),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF2D2D2D))),
          Text('$type  ·  $time', style: const TextStyle(fontSize: 12, color: Color(0xFF9B9B9B))),
        ])),
        Text('$calories kcal', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFFC4607A))),
      ]),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// PROGRAM PAGE
// ═══════════════════════════════════════════════════════════

class _ProgramPage extends StatelessWidget {
  const _ProgramPage();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.fromLTRB(20, 20, 20, 8), child: Text('Meal Program', style: GoogleFonts.dmSans(fontSize: 24, fontWeight: FontWeight.w700, color: const Color(0xFF2D2D2D))))),

        // Phase banner
        SliverToBoxAdapter(child: Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: const Color(0xFF7A9E87).withOpacity(0.06), borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFF7A9E87).withOpacity(0.15))),
          child: Row(children: [
            Container(width: 44, height: 44, decoration: BoxDecoration(color: const Color(0xFF7A9E87).withOpacity(0.12), borderRadius: BorderRadius.circular(12)), child: const Icon(Icons.local_florist, color: Color(0xFF7A9E87), size: 22)),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [Text('Follicular Phase Program', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF2D2D2D))), Text('Meals optimized for your follicular phase', style: TextStyle(fontSize: 13, color: Color(0xFF6B6B6B)))])),
          ]),
        )),

        // Meal sections
        SliverToBoxAdapter(child: _MealSection(title: 'Breakfast', icon: Icons.wb_sunny, iconColor: const Color(0xFFFFB347), meals: [
          _MealItem(name: 'Greek Yogurt Parfait', desc: 'Thick yogurt with berries, granola & chia seeds', calories: 320, protein: '22g', carbs: '38g', fat: '10g'),
          _MealItem(name: 'Avocado Toast with Eggs', desc: 'Sourdough with smashed avocado & poached eggs', calories: 380, protein: '18g', carbs: '32g', fat: '22g'),
        ])),

        SliverToBoxAdapter(child: _MealSection(title: 'Lunch', icon: Icons.wb_cloudy, iconColor: const Color(0xFF7EC8E3), meals: [
          _MealItem(name: 'Grilled Chicken Salad', desc: 'Mixed greens, quinoa, cherry tomatoes & lemon vinaigrette', calories: 380, protein: '35g', carbs: '28g', fat: '14g'),
          _MealItem(name: 'Salmon & Quinoa Bowl', desc: 'Baked salmon over quinoa with roasted vegetables', calories: 480, protein: '38g', carbs: '40g', fat: '18g'),
        ])),

        SliverToBoxAdapter(child: _MealSection(title: 'Snacks', icon: Icons.apple, iconColor: const Color(0xFF7A9E87), meals: [
          _MealItem(name: 'Dark Chocolate & Almonds', desc: '1oz dark chocolate (70%+) with raw almonds', calories: 220, protein: '6g', carbs: '18g', fat: '15g'),
        ])),

        SliverToBoxAdapter(child: _MealSection(title: 'Dinner', icon: Icons.nightlight, iconColor: const Color(0xFF7C83FD), meals: [
          _MealItem(name: 'Herb-Crusted Chicken', desc: 'Herb-marinated chicken with roasted root vegetables & quinoa', calories: 450, protein: '40g', carbs: '35g', fat: '16g'),
        ])),

        const SliverToBoxAdapter(child: SizedBox(height: 100)),
      ],
    );
  }
}

class _MealSection extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor;
  final List<_MealItem> meals;
  const _MealSection({required this.title, required this.icon, required this.iconColor, required this.meals});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [Icon(icon, color: iconColor, size: 20), const SizedBox(width: 8), Text(title, style: GoogleFonts.dmSans(fontSize: 17, fontWeight: FontWeight.w600, color: const Color(0xFF2D2D2D))), const SizedBox(width: 8), Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2), decoration: BoxDecoration(color: const Color(0xFFEDE8E4), borderRadius: BorderRadius.circular(8)), child: Text('${meals.length}', style: GoogleFonts.dmSans(fontSize: 11, fontWeight: FontWeight.w600, color: const Color(0xFF9B9B9B))))]),
        const SizedBox(height: 10),
        ...meals,
      ]),
    );
  }
}

class _MealItem extends StatelessWidget {
  final String name, desc, calories, protein, carbs, fat;
  const _MealItem({required this.name, required this.desc, required this.calories, required this.protein, required this.carbs, required this.fat});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF2D2D2D))),
          const SizedBox(height: 4),
          Text(desc, style: const TextStyle(fontSize: 12, color: Color(0xFF6B6B6B), height: 1.4), maxLines: 2, overflow: TextOverflow.ellipsis),
          const SizedBox(height: 8),
          Row(children: [
            _MacroPill(label: calories, color: const Color(0xFFC4607A)),
            const SizedBox(width: 6), _MacroPill(label: 'P $protein', color: const Color(0xFFC4607A)),
            const SizedBox(width: 6), _MacroPill(label: 'C $carbs', color: const Color(0xFF7A9E87)),
            const SizedBox(width: 6), _MacroPill(label: 'F $fat', color: const Color(0xFFD4A853)),
          ]),
        ])),
        const SizedBox(width: 12),
        Container(width: 40, height: 40, decoration: BoxDecoration(color: const Color(0xFF7A9E87).withOpacity(0.1), borderRadius: BorderRadius.circular(10)), child: const Center(child: Icon(Icons.add_circle, color: Color(0xFF7A9E87), size: 22))),
      ]),
    );
  }
}

class _MacroPill extends StatelessWidget {
  final String label;
  final Color color;
  const _MacroPill({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: color.withOpacity(0.08), borderRadius: BorderRadius.circular(6)), child: Text(label, style: GoogleFonts.dmSans(fontSize: 10, fontWeight: FontWeight.w600, color: color)));
  }
}

// ═══════════════════════════════════════════════════════════
// PROGRESS PAGE
// ═══════════════════════════════════════════════════════════

class _ProgressPage extends StatelessWidget {
  const _ProgressPage();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.fromLTRB(20, 20, 20, 8), child: Text('Progress', style: GoogleFonts.dmSans(fontSize: 24, fontWeight: FontWeight.w700, color: const Color(0xFF2D2D2D))))),

        // Stat cards
        SliverToBoxAdapter(child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(children: [
            Expanded(child: _StatCard(title: 'This Week', value: '9,380', unit: 'kcal total', color: const Color(0xFFC4607A), icon: Icons.local_fire_department)),
            const SizedBox(width: 10),
            Expanded(child: _StatCard(title: 'Avg Daily', value: '1,340', unit: 'kcal/day', color: const Color(0xFF7A9E87), icon: Icons.trending_up)),
            const SizedBox(width: 10),
            Expanded(child: _StatCard(title: 'Weight', value: '63.2', unit: 'kg', color: const Color(0xFFD4A853), icon: Icons.monitor_weight)),
          ]),
        )),

        // Weekly chart placeholder
        SliverToBoxAdapter(child: Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('Weekly Calories', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF2D2D2D))),
            const SizedBox(height: 20),
            SizedBox(height: 180, child: CustomPaint(painter: _BarChartPainter(), size: Size.infinite)),
          ]),
        )),

        // Cycle insights
        SliverToBoxAdapter(child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
            Text('Cycle Insights', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF2D2D2D))),
            SizedBox(height: 14),
            Text('Focus on iron-rich foods like lentils, spinach, and dark chocolate. Stay warm with herbal teas.', style: TextStyle(fontSize: 13, color: Color(0xFF6B6B6B), height: 1.5)),
          ]),
        )),

        // Weight logger
        SliverToBoxAdapter(child: Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('Log Weight', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF2D2D2D))),
            const SizedBox(height: 12),
            Row(children: [
              Expanded(child: Container(height: 48, decoration: BoxDecoration(color: const Color(0xFFFAF7F4), borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFFEDE8E4))), padding: const EdgeInsets.symmetric(horizontal: 16), alignment: Alignment.centerLeft, child: const Text('Weight (kg)', style: TextStyle(fontSize: 14, color: Color(0xFF9B9B9B))))),
              const SizedBox(width: 12),
              Container(height: 48, width: 80, decoration: BoxDecoration(color: const Color(0xFFC4607A), borderRadius: BorderRadius.circular(12)), alignment: Alignment.center, child: const Text('Log', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white))),
            ]),
          ]),
        )),

        const SliverToBoxAdapter(child: SizedBox(height: 100)),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title, value, unit;
  final Color color;
  final IconData icon;
  const _StatCard({required this.title, required this.value, required this.unit, required this.color, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Icon(icon, color: color, size: 18), const SizedBox(height: 8),
      Text(title, style: GoogleFonts.dmSans(fontSize: 11, color: const Color(0xFF9B9B9B), fontWeight: FontWeight.w500)),
      const SizedBox(height: 4),
      Text(value, style: GoogleFonts.dmSans(fontSize: 18, fontWeight: FontWeight.w700, color: const Color(0xFF2D2D2D))),
      Text(unit, style: GoogleFonts.dmSans(fontSize: 10, color: const Color(0xFF9B9B9B))),
    ]));
  }
}

class _BarChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final values = [0.65, 0.82, 0.55, 0.90, 0.70, 0.45, 0.60];
    final barWidth = (size.width - 40) / 7 - 8;
    final maxHeight = size.height - 40;

    // Target line
    final targetY = maxHeight * 0.3;
    canvas.drawLine(Offset(30, targetY), Offset(size.width, targetY), Paint()..color = const Color(0xFFEDE8E4)..strokeWidth = 1);

    for (var i = 0; i < 7; i++) {
      final x = 30 + (barWidth + 8) * i;
      final barHeight = maxHeight * values[i];
      final color = values[i] > 0.85 ? const Color(0xFF27AE60) : const Color(0xFFC4607A);

      // Bar
      final rect = RRect.fromRectAndRadius(Rect.fromLTWH(x, maxHeight - barHeight, barWidth, barHeight), const Radius.circular(6));
      canvas.drawRRect(rect, Paint()..color = color);

      // Day label
      final textPainter = TextPainter(text: TextSpan(text: days[i], style: const TextStyle(fontSize: 10, color: Color(0xFF9B9B9B))), textDirection: TextDirection.ltr)..layout();
      textPainter.paint(canvas, Offset(x + barWidth / 2 - textPainter.width / 2, maxHeight + 8));
    }
  }

  @override
  bool shouldRepaint(covariant _BarChartPainter old) => false;
}

// ═══════════════════════════════════════════════════════════
// PROFILE PAGE
// ═══════════════════════════════════════════════════════════

class _ProfilePage extends StatelessWidget {
  const _ProfilePage();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.fromLTRB(20, 20, 20, 8), child: Text('Profile', style: GoogleFonts.dmSans(fontSize: 24, fontWeight: FontWeight.w700, color: const Color(0xFF2D2D2D))))),

        // Avatar + name
        SliverToBoxAdapter(child: Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Column(children: [
            Container(width: 80, height: 80, decoration: BoxDecoration(color: const Color(0xFFC4607A).withOpacity(0.1), borderRadius: BorderRadius.circular(40)), child: const Center(child: Text('Q', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700, color: Color(0xFFC4607A), fontFamily: 'CormorantGaramond')))),
            const SizedBox(height: 16),
            Text('Welcome to QYVRA', style: GoogleFonts.cormorantGaramond(fontSize: 22, fontWeight: FontWeight.w600, color: const Color(0xFF2D2D2D))),
            const SizedBox(height: 4),
            const Text('Your wellness journey starts here', style: TextStyle(fontSize: 13, color: Color(0xFF9B9B9B))),
          ]),
        )),

        // Settings
        SliverToBoxAdapter(child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
          child: Column(children: [
            _SettingsTile(icon: Icons.person, title: 'Edit Profile', trailing: const Icon(Icons.chevron_right, color: Color(0xFF9B9B9B), size: 20)),
            const Divider(height: 1, color: Color(0xFFEDE8E4), indent: 52),
            _SettingsTile(icon: Icons.track_changes, title: 'Cycle Settings', trailing: const Icon(Icons.chevron_right, color: Color(0xFF9B9B9B), size: 20)),
            const Divider(height: 1, color: Color(0xFFEDE8E4), indent: 52),
            _SettingsTile(icon: Icons.workspace_premium, title: 'Upgrade to Premium', trailing: Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: const Color(0xFFD4A853).withOpacity(0.12), borderRadius: BorderRadius.circular(8)), child: const Text('PRO', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Color(0xFFD4A853))))),
            const Divider(height: 1, color: Color(0xFFEDE8E4), indent: 52),
            _SettingsTile(icon: Icons.notifications_outlined, title: 'Notifications', trailing: const Icon(Icons.chevron_right, color: Color(0xFF9B9B9B), size: 20)),
            const Divider(height: 1, color: Color(0xFFEDE8E4), indent: 52),
            _SettingsTile(icon: Icons.info_outline, title: 'About QYVRA', trailing: const Icon(Icons.chevron_right, color: Color(0xFF9B9B9B), size: 20)),
          ]),
        )),

        // Premium banner
        SliverToBoxAdapter(child: Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(gradient: LinearGradient(colors: [const Color(0xFFC4607A).withOpacity(0.08), const Color(0xFF7A9E87).withOpacity(0.08)]), borderRadius: BorderRadius.circular(16)),
          child: Row(children: [
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [Text('QYVRA Premium', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: Color(0xFF2D2D2D))), SizedBox(height: 4), Text('Cycle sync, AI tips & advanced charts', style: TextStyle(fontSize: 13, color: Color(0xFF6B6B6B)))])),
            Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10), decoration: BoxDecoration(color: const Color(0xFFD4A853), borderRadius: BorderRadius.circular(10)), child: const Text('\$39.99/yr', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white))),
          ]),
        )),

        // Version
        SliverToBoxAdapter(child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(children: [
            const Text('QYVRA v1.0.0', style: TextStyle(fontSize: 12, color: Color(0xFF9B9B9B))),
            const SizedBox(height: 4),
            const Text('Made with care for your wellness', style: TextStyle(fontSize: 11, color: Color(0xFF9B9B9B))),
          ]),
        )),

        const SliverToBoxAdapter(child: SizedBox(height: 100)),
      ],
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget trailing;
  const _SettingsTile({required this.icon, required this.title, required this.trailing});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(horizontal: 4), child: ListTile(contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4), leading: Icon(icon, color: const Color(0xFFC4607A), size: 22), title: Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Color(0xFF2D2D2D))), trailing: trailing));
  }
}
